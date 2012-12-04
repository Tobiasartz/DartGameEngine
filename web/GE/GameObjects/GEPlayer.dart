part of GE;

class GEPlayer extends GEGraphic{
  String facing;
  num timeNextAction = 0;
  num timeActionInterval = 30;
  num speedHorizontal = .5;
  
  GEPlayer(String name) : super(name);
  
  void attachPhysics(){
   this.physicsObject = new GEPhysicObject(this); 
   this.physicsObject.density = 1000;
   //this.physicsObject.createCircleBody(this.width / 2, 'dynamic');
   this.physicsObject.createRectangleBody(this.width, this.height, 'dynamic');
   this.physicsObject.bodyX = this.x;
   this.physicsObject.bodyY = this.y;
   this.physicsObject.fixtureDef.restitution = 0;
   this.physicsObject.body.linearDamping = .4;
  }
  
  void onUpdate(num time){
    super.onUpdate(time);
    //this.mesh.rotation.z = 0;
    if(time > timeNextAction){
      if(KEYSDOWN.indexOf(37) > -1){
        PLAYER.moveLeft();
      }
      
      if(KEYSDOWN.indexOf(38) > -1){
        PLAYER.moveUp();
      }
      
      if(KEYSDOWN.indexOf(39) > -1){
        PLAYER.moveRight();
      }
      
      if(KEYSDOWN.indexOf(32) > -1){
        PLAYER.shoot();
      }
      
      timeNextAction = time + timeActionInterval;
    }
  }
  
  void moveUp(){
    Box2D.Vector velocity = this.physicsObject.velocity;
    if(velocity.y > -0.025 && velocity.y < 0.025){
      Box2D.Vector point = this.physicsObject.body.getWorldPoint(this.physicsObject.body.localCenter);    
      this.physicsObject.body.applyLinearImpulse(new Box2D.Vector(0, 200), point);
    }
  }
  
  void moveLeft(){
    Box2D.Vector velocity = this.physicsObject.velocity;
    
    this.facing = 'left';
    
    if(velocity.x > -speedHorizontal)
      this.physicsObject.body.applyLinearImpulse(new Box2D.Vector(-speedHorizontal, 0), new Box2D.Vector(0,0));   
  }
  
  void moveRight(){
    Box2D.Vector velocity = this.physicsObject.velocity;
    this.facing = 'right';
        
    if(velocity.x < speedHorizontal)
      this.physicsObject.body.applyLinearImpulse(new Box2D.Vector(speedHorizontal, 0), new Box2D.Vector(0,0));
  }
  
  void shoot(){
    num bulletSize = 2;
    num offsetX = bulletSize + 2;
    
    GEBullet bullet = new GEBullet('player', this.facing);        
    bullet.setAsSphere(bulletSize);
    switch(this.geometryType){
      case 'sphere':
        if(this.facing == 'left')
          bullet.setPosition(this.x - (this.radius + offsetX), this.y, 1);
        else
          bullet.setPosition(this.x + this.radius + offsetX, this.y, 1);
        break;
      case 'rectangle':
        if(this.facing == 'left')
          bullet.setPosition(this.x - (this.width + offsetX), this.y, 1);
        else
          bullet.setPosition(this.x + this.width + offsetX, this.y, 1);
        break;
    }
    
    bullet.attachPhysics();
    WEBGL.addToScene(bullet, true, false);    
  }
}
