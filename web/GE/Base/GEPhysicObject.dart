part of GE;

class GEPhysicObject{
  Box2D.Body body;
  Box2D.BodyDef bodyDef;
  Box2D.FixtureDef fixtureDef;  
  
  void createBody(){
    // Create a bouncing ball.
    Box2D.CircleShape shape = new Box2D.CircleShape();
    shape.radius = 1;

    // Create fixture for that ball shape.
    fixtureDef = new Box2D.FixtureDef();
    fixtureDef.restitution = 1;
    fixtureDef.density =  0.5;
    fixtureDef.shape = shape;

    // Create the active ball body.
    bodyDef = new Box2D.BodyDef();
    bodyDef.linearVelocity = new Box2D.Vector(0, -5);
    bodyDef.position = new Box2D.Vector(0,0);
    bodyDef.type = Box2D.BodyType.DYNAMIC;
    //bodyDef.bullet = true;
    body = GEBox2D.world.createBody(bodyDef);
    body.createFixture(fixtureDef);    
  }
  
  void createRectangleBody(num width, num height, String type){
    // Create a bouncing ball
    Box2D.PolygonShape shape = new Box2D.PolygonShape();
    shape.setAsBox(width / 2, height / 2);

    // Create fixture for that ball shape.
    fixtureDef = new Box2D.FixtureDef();
    fixtureDef.restitution = 1;
    fixtureDef.density =  1;
    fixtureDef.shape = shape;

    // Create the active ball body.
    bodyDef = new Box2D.BodyDef();
    bodyDef.linearVelocity = new Box2D.Vector(0, 0);
    bodyDef.position = new Box2D.Vector(0,0);
    
    if(type == 'static')
      bodyDef.type = Box2D.BodyType.STATIC;
    else
      bodyDef.type = Box2D.BodyType.DYNAMIC;
      
    //bodyDef.bullet = true;
    body = GEBox2D.world.createBody(bodyDef);
    body.createFixture(fixtureDef); 
  }
  
  num get bodyX{
    return body.position.x;
  }
  
  num get bodyY{
    return body.position.y;
  }
  
  num get bodyAngle{
    return body.angle;
  }
  
  void set bodyX(x){
    body.setTransform(new Box2D.Vector(x, this.bodyY), this.bodyAngle);
  }
  
  void set bodyY(y){
    body.setTransform(new Box2D.Vector(this.bodyX, y), this.bodyAngle);
  }
}
