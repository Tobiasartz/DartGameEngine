part of GE;

class GEWebGLProxyThreeDart extends GEWebGLProxy{
  String name = 'Three.js';
  THREE.OrthographicCamera camera;
  THREE.Scene scene;
  THREE.Projector projector;   
  THREE.WebGLRenderer renderer;
  
  GEWebGLProxyThreeDart(num canvasWidth, num canvasHeight) : super(canvasWidth, canvasHeight);
  
  void init(){
      this.projector = new THREE.Projector();            
          
      this.camera = new THREE.OrthographicCamera( this.canvasWidth / - 2, this.canvasWidth / 2, this.canvasHeight / 2, this.canvasHeight / - 2, - 2000, 1000 );
      //this.camera = new THREE.PerspectiveCamera(75, this.canvasWidth/this.canvasHeight, 1, 10000);    
      this.camera.position.z = 600;
      
      this.scene = new THREE.Scene();
      
      this.renderer = new THREE.WebGLRenderer();
      this.renderer.antialias = true;
      
      this.renderer.setSize( this.canvasWidth, this.canvasHeight );
  }
  
  void addToScene(GEGraphic graphic){
      this.scene.add(graphic.mesh);
  }
  
  void removeFromScene(GEGraphic graphic){
      this.scene.remove(graphic.mesh);
  }
  
  void detectHit(){
    //this.projector.unprojectVector( GEWebGL.mouse3D, this.camera );
    
    //THREE.Ray ray = new THREE.Ray(this.camera.position, vector.subSelf( this.camera.position ).normalize() );
    THREE.Ray ray = this.projector.pickingRay(GEWebGL.mouse2D.clone(), camera);
    List intersects = ray.intersectObjects(GEWebGL.clickables);
    if ( intersects.length > 0 ) {      
      intersects[ 0 ].object.properties['self'].onClick();
    }
    
    print(intersects.length);
  }
  
  void render(){
    this.renderer.render( this.scene, this.camera ); 
   }
}