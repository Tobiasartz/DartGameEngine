part of GE;

class GEBox2D {
  static Box2D.World world;
  static int scale = 60;
  static int gravityX = 0;
  static int gravityY = -1;
  
  static List<GEGraphic> expireds = new List();
  
  CanvasRenderingContext2D context;
  
  num VIterations = 10;
  num PIterations = 10;
  
  bool debugEnabled = false;
  
  void init(){
    world = new Box2D.World(new Box2D.Vector(GEBox2D.gravityX, GEBox2D.gravityY), true, new Box2D.DefaultWorldPool());
    world.contactListener = new CollisionListener();
  }
  
  void activateDebug(Element debugContainer){
    Element canvas = new Element.tag('canvas');
    canvas.width = SETTINGS.canvasWidth;
    canvas.height = SETTINGS.canvasHeight;
    debugContainer.nodes.add(canvas);
    
    this.context = canvas.getContext('2d');
    
    // Create the viewport transform with the center at extents.
    Box2D.Vector extents = new Box2D.Vector(SETTINGS.canvasWidth / 2, SETTINGS.canvasHeight / 2);
    Box2D.CanvasViewportTransform viewport = new Box2D.CanvasViewportTransform(extents, extents);
    viewport.scale = GEBox2D.scale;

    // Create our canvas drawing tool to give to the world.
    Box2D.CanvasDraw debugDraw = new Box2D.CanvasDraw(viewport, context);

    // Have the world draw itself for debugging purposes.
    world.debugDraw = debugDraw;
    
    this.debugEnabled = true;
  }
  
  void onUpdate(){
    world.step(FRAMERATE, VIterations, PIterations);
    if(this.debugEnabled){
      context.clearRect(0, 0, SETTINGS.canvasWidth, SETTINGS.canvasHeight);
      world.drawDebugData();
    }
    
    for(GEGraphic graphic in GEBox2D.expireds){
      GEBox2D.world.destroyBody(graphic.physicsObject.body);
      GEBox2D.expireds.removeAt(GEBox2D.expireds.indexOf(graphic));
    }
  }
}


class CollisionListener implements Box2D.ContactListener {
  void beginContact(Box2D.Contact contact) 
  {
    GEPhysicObject physicsObjectA = contact.fixtureA.body.userData;
    GEPhysicObject physicsObjectB = contact.fixtureB.body.userData;
    
    physicsObjectA.onHitCallback(physicsObjectB);
    physicsObjectB.onHitCallback(physicsObjectA);
   }
  
  void endContact(Box2D.Contact contact) 
  { 
    GEPhysicObject physicsObjectA = contact.fixtureA.body.userData;
    GEPhysicObject physicsObjectB = contact.fixtureB.body.userData;
    
    physicsObjectA.onHitEndCallback(physicsObjectB);
    physicsObjectB.onHitEndCallback(physicsObjectA);
  }
  
  void preSolve(Box2D.Contact contact, Box2D.Manifold manifold) {
  }
  
  void postSolve(Box2D.Contact contact, Box2D.ContactImpulse manifold) {
    
  }
}