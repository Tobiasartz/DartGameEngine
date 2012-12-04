library GE;

import 'dart:html';
import 'dart:json';
import 'package:js/js.dart' as js;
import 'dart:math';
import 'package:box2d/box2d_browser.dart' as Box2D;
import 'package:three/three.dart' as THREE;
import 'package:three/extras/image_utils.dart' as THREEImageUtils;

part 'GE/Globals/Settings.dart';
part 'GE/Globals/Instruction.dart';

part 'GE/Proxy/GEBox2D.dart';
part 'GE/Proxy/GEWebGL.dart';
part 'GE/Proxy/GEWebGLProxy.dart';
part 'GE/Proxy/GEWebGLProxyThreeDart.dart';

part 'GE/Base/GEObject.dart';
part 'GE/Base/GEGraphic.dart';
part 'GE/Base/GEHitObject.dart';
part 'GE/Base/GEPhysicObject.dart';

part 'GE/GameObjects/GEObstacle.dart';
part 'GE/GameObjects/GEPlayer.dart';
part 'GE/GameObjects/GEBullet.dart';
part 'GE/GameObjects/GEDestroyable.dart';
part 'GE/GameObjects/GEEnemy.dart';

GEWebGL WEBGL;
GEBox2D BOX2D;
GEPlayer PLAYER;
List<GEObject> EXPIREABLES = new List();

List<int> KEYSDOWN = new List();

num LASTFRAME = 0;
num FRAMERATE = 0;

Settings SETTINGS;

void main() {
  SETTINGS = new Settings();
  SETTINGS.canvasWidth = 800;
  SETTINGS.canvasHeight = 800;
  initGame();
}

void initGame() {
  initPhysics();
  
  WEBGL = new GEWebGL('#container','three.js');
  WEBGL.init();
  
  Instruction instruction = new Instruction('/Projects/Dart/DartGameEngine/instructions.html');  
  instruction.onComplete = function(){
    initListeners();
    window.requestAnimationFrame(update);
  };
  
  instruction.init();
}

void initPhysics() {
  BOX2D = new GEBox2D();
  BOX2D.init();
  BOX2D.activateDebug(query('#debugDraw'));
}

void initListeners() {
  window.on.click.add(onWindowClick, true);
  window.on.keyDown.add(onKeyDown, true);
  window.on.keyUp.add(onKeyUp, true);
}

void update(num time){
  window.requestAnimationFrame(update);
  
  BOX2D.onUpdate();
  WEBGL.onUpdate(time);
  
  for(GEObject object in EXPIREABLES){
    if(object.ttl < time){
      object.expire();      
    }
  }
  
  FRAMERATE = 1 / (time - LASTFRAME);
  LASTFRAME = time;  
}

void onWindowClick(MouseEvent e) {
  e.stopPropagation();
  print('Click event: x:${e.clientX} y:${e.clientY}'); 
  WEBGL.detectHit(e.clientX, e.clientY);
}

void onKeyDown(KeyboardEvent e) {
  e.stopPropagation();
  if(KEYSDOWN.indexOf(e.keyCode) == -1){
    KEYSDOWN.add(e.keyCode);
  }
}

void onKeyUp(KeyboardEvent e) {
 e.stopPropagation();
 int index = KEYSDOWN.indexOf(e.keyCode);
 if(index > -1) {
   KEYSDOWN.removeAt(index);
 }
}