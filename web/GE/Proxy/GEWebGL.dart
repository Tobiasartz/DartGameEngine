part of GE;

class GEWebGL {
  static GEWebGLProxyThreeDart webGLProxy;
  Element container;
  
  static List<GEDisplayObject> updateables = new List();
  static List<THREE.Mesh> clickables = new List();
  static THREE.Vector3 mouse2D = new THREE.Vector3( 0, 10000, 0.5 );
  static THREE.Vector3 mouse3D = new THREE.Vector3();
  static GEDisplayObject followGraphic; 
  
  
  GEWebGL(String containerName, String library){
    switch(library.toLowerCase()){      
      case 'three.js':
      default:
        GEWebGL.webGLProxy = new GEWebGLProxyThreeDart(SETTINGS.canvasWidth, SETTINGS.canvasHeight);
        break;
    }
    
    this.container = query(containerName);
  }
  
  void init() {
    GEWebGL.webGLProxy.init();
    this.container.elements.add(GEWebGL.webGLProxy.renderer.domElement);
   }
  
  void addToScene(GEDisplayObject graphic, bool needsUpdate, bool clickable){
    GEWebGL.webGLProxy.addToScene(graphic);
    
    if(needsUpdate)
      GEWebGL.addUpdateable(graphic);
   
    if(clickable)
      GEWebGL.clickables.add(graphic.mesh);
  }
  
  void detectHit(num x, num y) {
   GEWebGL.mouse2D.x = ( x / GEWebGL.webGLProxy.canvasWidth ) * 2 - 1;
   GEWebGL.mouse2D.y = - ( y / GEWebGL.webGLProxy.canvasHeight ) * 2 + 1;
   
   GEWebGL.mouse3D.x = ( x / GEWebGL.webGLProxy.canvasWidth ) * 2 - 1;
   GEWebGL.mouse3D.y = - ( y / GEWebGL.webGLProxy.canvasHeight ) * 2 + 1;
   GEWebGL.mouse3D.z = 0.5;
   
   GEWebGL.webGLProxy.detectHit();
  }
  
  static remove(GEDisplayObject graphic){
    GEWebGL.removeClickable(graphic);
    GEWebGL.removeUpdateable(graphic);
    GEWebGL.webGLProxy.removeFromScene(graphic);
  }
  
  void onUpdate(num time){
    GEWebGL.webGLProxy.render();
    
    if(GEWebGL.followGraphic != null){
      GEWebGL.webGLProxy.camera.position.copy(GEWebGL.followGraphic.mesh.position);
    }
    
    for(GEObject object in GEWebGL.updateables){
      object.onUpdate(time);
    }
  }
  
  
  static void addUpdateable(GEObject object){
    if(GEWebGL.updateables.indexOf(object) == -1)
      GEWebGL.updateables.add(object);
  }
  
  static void removeUpdateable(GEObject object){
    int index = GEWebGL.updateables.indexOf(object);
    
    if( index != -1){
      GEWebGL.updateables.removeAt(index);
    }
  }
  
  static void addClickable(GEDisplayObject graphic){
    GEWebGL.clickables.add(graphic.mesh);
  }
  
  static void removeClickable(GEDisplayObject graphic){
    int index = GEWebGL.clickables.indexOf(graphic.mesh);
    
    if( index != -1){
      GEWebGL.clickables.removeAt(index);
    }
  }
}