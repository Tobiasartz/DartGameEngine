part of GE;

class GEWebGLProxyThreejs extends GEWebGLProxy{
  String name = 'Three.js';
  js.Proxy camera;
  js.Proxy scene;
  js.Proxy three;  
  js.Proxy projector;
   
  
  GEWebGLProxyThreejs(num canvasWidth, num canvasHeight) : super(canvasWidth, canvasHeight);
  
  bool init(){
    bool result = false;
    
    js.scoped((){
      this.projector = new js.Proxy(js.context.THREE.Projector);  
      js.retain(this.projector);
      
      //this.camera = new js.Proxy(js.context.THREE.OrthographicCamera( canvasWidth / - 2, canvasWidth / 2, canvasHeight / 2, canvasHeight / - 2, - 2000, 1000 ));
          
          
      this.camera = new js.Proxy(js.context.THREE.PerspectiveCamera, 75, this.canvasWidth/this.canvasHeight, 1, 10000);      
      this.camera.position.z = 1000;
      js.retain(this.camera);
      
      this.scene = new js.Proxy(js.context.THREE.Scene);
      js.retain(this.scene);
            
      this.renderer = new js.Proxy(js.context.THREE.WebGLRenderer, js.map({
        'antialias' : true
      }));
      
      this.renderer.setSize( this.canvasWidth, this.canvasHeight );
      js.retain(this.renderer);
    });
    
    return result;
  }
  
  void addToScene(GEGraphic graphic){
    js.scoped((){
      this.scene.add(graphic.mesh);
    });
  }
  
  void detectHit(num x, num y){
    js.scoped((){
      js.Proxy vector = new js.Proxy(js.context.THREE.Vector3, ( x / this.canvasWidth ) * 2 - 1, -( y / this.canvasHeight ) * 2 + 1, 0.5 );
      
      this.projector.unprojectVector( vector, this.camera );
      
      js.Proxy ray = new js.Proxy(js.context.THREE.Ray, this.camera.position, vector.subSelf( this.camera.position ).normalize() );
      var jsArray = js.array(GEWebGL.clickables);
      
      js.Proxy intersects = ray.intersectObjects(jsArray);
      if ( intersects.length > 0 ) {

        Random random = new Random();
        intersects[ 0 ].object.material.color.setHex( random.nextInt(0xffffff) * 0xffffff );
        intersects[ 0 ].object.GEOnClick();
      }
    });
  }
  
  void render(){
    this.renderer.render( this.scene, this.camera ); 
    
    for(GEObject object in GEWebGL.updateables){
      object.onUpdate();
    }
   }
}