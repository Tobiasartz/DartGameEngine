part of GE;

class GEBullet extends GEDynamicObject{
  num ttlAddon = 500;
  String direction;
  bool isAlive;
  num damage = 15;
  
  GEBullet(String name, this.direction) : super(name){
    this.ttl = LASTFRAME + ttlAddon;
    this.isAlive = true;
    EXPIREABLES.add(this);    
  }
  
  void attachPhysics(){
   this.physicsObject = new GEPhysicObject(this); 
   this.physicsObject.createCircleBody(this.radius, 'dynamic');
   if(this.direction == 'left')
    this.physicsObject.body.linearVelocity.x = -5;
   else
     this.physicsObject.body.linearVelocity.x = 5;
   
   this.physicsObject.body.linearVelocity.y = .5;
   this.physicsObject.bodyX = this.x;
   this.physicsObject.bodyY = this.y;
   this.physicsObject.body.bullet = true;
   this.physicsObject.onHit = this.onHit;
   this.physicsObject.type = 'bullet';
  }
  
  void onHit(GEPhysicObject hitObject){
    this.isAlive = false;    
  }
  
  void expire(){
    super.expire();    
    GEWebGL.remove(this);
    GEBox2D.expireds.add(this);
  }
}
