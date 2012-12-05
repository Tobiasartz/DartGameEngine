part of GE;

class GEDestroyable extends GEDynamicObject{
  num life = 50;
  bool isAlive;
  
  GEDestroyable(String name) : super(name){
    this.isAlive = true;
  }
  
  void attachPhysics(){
   this.physicsObject = new GEPhysicObject(this); 
   this.physicsObject.density = 10000;
   this.physicsObject.friction = 1000;
   this.physicsObject.createRectangleBody(this.width, this.height,'dynamic');
   this.physicsObject.bodyX = this.x;
   this.physicsObject.bodyY = this.y;
   this.physicsObject.onHit = this.onHit;
  }
  
  void onHit(GEPhysicObject hitObject){
    if(hitObject.type == 'bullet'){
      GEBullet bullet = hitObject.parent as GEBullet;
      
      if(bullet.isAlive)
        this.subtractLife(bullet.damage);
    }
  }
  
  void subtractLife(num amount){
    if(this.isAlive){
      this.life -= amount;
      print(this.life);
      if(this.life <= 0){
        this.die();
      }
    }
  }
  
  void die(){
    this.isAlive = false;
    this.expire();
  }
  
  void expire(){
    GEWebGL.remove(this);
    GEBox2D.expireds.add(this);
  }
}