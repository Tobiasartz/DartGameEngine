library GE;

import 'dart:html';
import 'package:js/js.dart' as js;
import 'dart:math';
import 'package:box2d/box2d_browser.dart' as Box2D;

part 'GE/Proxy/GEBox2D.dart';
part 'GE/Proxy/GEWebGL.dart';
part 'GE/Proxy/GEWebGLProxy.dart';
part 'GE/Proxy/GEWebGLProxyThreejs.dart';

part 'GE/Base/GEObject.dart';
part 'GE/Base/GEGraphic.dart';
part 'GE/Base/GEHitObject.dart';
part 'GE/Base/GEPhysicObject.dart';

part 'GE/GameObjects/GEObstacle.dart';

GEWebGL webGL;
GEBox2D box2D;

num lastFrameTime = 0;
num frameRate = 0;

void main() {
  initGame();
}

void initGame() {
  initPhysics();
  
  webGL = new GEWebGL('#container','three.js');
  webGL.init();

  
  for(var i = 0; i < 10; i++){
    GEHitObject graphic = new GEHitObject('Hit object');
    graphic.setAsRectangle(100, 100, 100);
    graphic.setPosition(-500 + (i* 110), 750, 1);
    graphic.attachPhysics();
    webGL.addToScene(graphic, true, false);
  }

  /*
  GEObstacle wall = new GEObstacle('Bottom wall');
  wall.setAsRectangle(1500, 1, 5);
  wall.setPosition(1, -750, 0);
  wall.attachPhysics();
  webGL.addToScene(wall, false, false);
  */
  
  /*
  GEObstacle wall2 = new GEObstacle('Left wall');
  wall2.setAsRectangle(1, 1000, 5);
  wall2.setPosition(-750, -10, 0);
  wall2.attachPhysics();
  webGL.addToScene(wall2, false, false);
  
  
  GEObstacle wall3 = new GEObstacle('Left wall');
  wall3.setAsRectangle(1, 1000, 5);
  wall3.setPosition(750, -10, 0);
  wall3.attachPhysics();
  webGL.addToScene(wall3, false, false);
  */
  initListeners();
  
  window.requestAnimationFrame(update);
}

void initPhysics() {
  box2D = new GEBox2D();
  box2D.init();
 // box2D.activateDebug(query('#debugDraw'));
}

void initListeners() {
  window.on.click.add(onWindowClick, true);
}

void update(num time){
  window.requestAnimationFrame(update);
  
  /*
  js.scoped((){
    js.context.stats.update();
  });
  */
  
  box2D.onUpdate();
  webGL.onUpdate();
  
  frameRate = 1 / (time - lastFrameTime);
  lastFrameTime = time;
  
}

void onWindowClick(MouseEvent e) {
  e.stopPropagation();
  print('Click event: x:${e.clientX} y:${e.clientY}'); 
  webGL.detectHit(e.clientX, e.clientY);
}