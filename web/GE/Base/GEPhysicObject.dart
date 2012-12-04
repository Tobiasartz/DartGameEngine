part of GE;

class GEPhysicObject{
  Box2D.Body body;
  Box2D.BodyDef bodyDef;
  Box2D.FixtureDef fixtureDef;
  
  String type = '';
  GEGraphic parent;
  
  Function _onHitCallback;
  Function _onHitEndCallback;
  
  num density = 1000;
  num friction = 10;
  num restitution = 0;
  
  GEPhysicObject(this.parent);
  
  void createRectangleBody(num width, num height, String type){
    width = width / GEBox2D.scale;
    height = height / GEBox2D.scale;
    
    Box2D.PolygonShape shape = new Box2D.PolygonShape();
    shape.setAsBox(width / 2, height / 2);

    this.fixtureDef = this._createFixtureDef(shape);    
    this.bodyDef = this._createBodyType(type);
    this.body = this._createBody();
  }
  
  void createCircleBody(num radius, String type){
    radius = radius / GEBox2D.scale;
    
    Box2D.CircleShape shape = new Box2D.CircleShape();
    shape.radius = radius;
    
    this.fixtureDef = this._createFixtureDef(shape);
    this.bodyDef = this._createBodyType(type);
    this.body = this._createBody();
  }
  
  Box2D.FixtureDef _createFixtureDef(Box2D.Shape shape){
    Box2D.FixtureDef fixtureDef = new Box2D.FixtureDef();
    fixtureDef.restitution = this.restitution;
    fixtureDef.density =  this.density;
    fixtureDef.shape = shape;
    fixtureDef.friction = this.friction;
    
    return fixtureDef;
  }
  
  Box2D.BodyDef _createBodyType(String type){
    // Create the active ball body.
    Box2D.BodyDef bodyDef = new Box2D.BodyDef();
    bodyDef.position = new Box2D.Vector(0,0);
    
    if(type == 'static')
      bodyDef.type = Box2D.BodyType.STATIC;
    else
      bodyDef.type = Box2D.BodyType.DYNAMIC;
    
    return bodyDef;
  }
  
  Box2D.Body _createBody(){
    Box2D.Body body;
   
    body = GEBox2D.world.createBody(bodyDef);
    body.createFixture(fixtureDef); 
    body.userData = this;
    
    return body;
  }
  
  // CALLBACKS
  
  void onHitCallback(GEPhysicObject hitObject) {
    if(this._onHitCallback != null){
      this._onHitCallback(hitObject);
    }
  }
  
  void onHitEndCallback(GEPhysicObject hitObject) {
    if(this._onHitEndCallback != null){
      this._onHitEndCallback(hitObject);
    }
  }
  
  // GETTERS AND SETTERS
  
  Box2D.Vector get velocity{
    return this.body.getLinearVelocityFromLocalPoint(this.body.localCenter); 
  }
  
  void set onHit(Function callback) {
    this._onHitCallback = callback;
  }
  
  void set onHitEnd(Function callback) {
    this._onHitEndCallback = callback;
  }
  
  num get bodyX{
    return body.position.x * GEBox2D.scale;
  }
  
  num get bodyY{
    return body.position.y * GEBox2D.scale;
  }
  
  num get bodyAngle{
    return body.angle;
  }
  
  void set bodyX(x){
    x = x / ( GEBox2D.scale * GEBox2D.scale);
    body.setTransform(new Box2D.Vector(x, this.bodyY), this.bodyAngle);
  }
  
  void set bodyY(y){
    y = y / GEBox2D.scale;
    body.setTransform(new Box2D.Vector(this.bodyX, y), this.bodyAngle);
  }
}
