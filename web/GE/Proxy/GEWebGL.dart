part of GE;

class GEWebGL {
  GEWebGLProxy webGLProxy;
  Element container;
  
  static List<GEGraphic> updateables = new List();
  static List<js.Proxy> clickables = new List();
  
  GEWebGL(String containerName, String library){
    switch(library.toLowerCase()){      
      case 'three.js':
      default:
        this.webGLProxy = new GEWebGLProxyThreejs(800, 800);
        break;
    }
    
    this.container = query(containerName);
  }
  
  void init() {
    this.webGLProxy.init();
    js.scoped((){
      this.container.elements.add(this.webGLProxy.renderer.domElement);
    });    
   }
  
  void addToScene(GEGraphic graphic, bool needsUpdate, bool clickable){
    this.webGLProxy.addToScene(graphic);
    
    if(needsUpdate)
      GEWebGL.addUpdateable(graphic);
   
    if(clickable)
      GEWebGL.clickables.add(graphic.mesh);
  }
  
  void detectHit(num x, num y) {
   this.webGLProxy.detectHit(x, y);
  }
  
  void onUpdate(){
    js.scoped((){
      this.webGLProxy.render();
    });
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
  
  static void addClickable(GEGraphic graphic){
    GEWebGL.clickables.add(graphic.mesh);
  }
  
  static void removeClickable(GEGraphic graphic){
    int index = GEWebGL.clickables.indexOf(graphic.mesh);
    
    if( index != -1){
      GEWebGL.clickables.removeAt(index);
    }
  }
}