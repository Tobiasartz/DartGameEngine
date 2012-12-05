part of GE;

class GEWebGLProxy {
  String name;
  num canvasWidth;
  num canvasHeight;
  
  GEWebGLProxy(num this.canvasWidth, num this.canvasHeight);
  
  void init() {
    // Extend
  }
  
  void addToScene(GEObject object) {
    // Extend
  }
  
  void removeFromScene(GEDisplayObject graphic){
    // Extendd
  }
  
  void detectHit() {
    // Extend
  }
  
  void render(){
    // Extend
  }
}