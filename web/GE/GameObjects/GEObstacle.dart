part of GE;

class GEObstacle extends GEGraphic{
  GEObstacle(String name) : super(name);
  
  void attachPhysics(){
   this.physicsObject = new GEPhysicObject(); 
   this.physicsObject.createRectangleBody(this.width, this.height,'static');
   this.physicsObject.bodyX = this.x;
   this.physicsObject.bodyY = this.y;
  }
}
