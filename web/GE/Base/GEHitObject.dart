part of GE;

class GEHitObject extends GEGraphic {
  int random;
  
  GEHitObject(String name) : super(name){
    Random rand = new Random();
    this.random = rand.nextInt(100);
  }
  
  void setAsRectangle(num width, num height, num depth){
    super.setAsRectangle(width,height,depth);
    
    js.scoped((){
      this.mesh.GEOnClick = new js.Callback.many(this.onClick);  
    });
  }
  
  void onUpdate() {
    super.onUpdate();
    
    /*
    js.scoped((){
      //this.mesh.rotation.x += 0.5 / this.random;
      //this.mesh.rotation.y += 0.5 / this.random;
    });
    */
  }
  
  void onClick() {
    print('Clicked meh');
    GEWebGL.addUpdateable(this);
  }
}