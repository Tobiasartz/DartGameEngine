part of GE;

class GEBox2D {
  static Box2D.World world;  
  var context;
  
  num VIterations = 10;
  num PIterations = 10;
  
  bool debugEnabled = false;
  
  void init(){
    world = new Box2D.World(new Box2D.Vector(0,-1000), true, new Box2D.DefaultWorldPool());
  }
  
  void activateDebug(Element debugContainer){
    Element canvas = new Element.tag('canvas');
    canvas.width = debugContainer.clientWidth;
    canvas.height = debugContainer.clientHeight;
    debugContainer.nodes.add(canvas);
    
    this.context = canvas.getContext('2d');
    
    // Create the viewport transform with the center at extents.
    Box2D.Vector extents = new Box2D.Vector(debugContainer.clientWidth / 2, debugContainer.clientHeight / 2);
    Box2D.CanvasViewportTransform viewport = new Box2D.CanvasViewportTransform(extents, extents);
    viewport.scale = 1;

    // Create our canvas drawing tool to give to the world.
    Box2D.CanvasDraw debugDraw = new Box2D.CanvasDraw(viewport, context);

    // Have the world draw itself for debugging purposes.
    world.debugDraw = debugDraw;
    
    this.debugEnabled = true;
  }
  
  void onUpdate(){
    world.step(frameRate, VIterations, PIterations);
  }
}
