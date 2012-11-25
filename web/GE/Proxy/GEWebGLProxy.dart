part of GE;

class GEWebGLProxy {
  String name;
  js.Proxy renderer;
  num canvasWidth;
  num canvasHeight;
  
  GEWebGLProxy(num this.canvasWidth, num this.canvasHeight);
  
  void init() {
    // Extend
  }
  
  void addToScene(GEObject object) {
    // Extend
  }
  
  void detectHit(num x, num y) {
    // Extend
  }
  
  void render(){
    // Extend
  }
}