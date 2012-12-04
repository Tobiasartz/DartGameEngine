part of GE;

class Instruction {
  Function onComplete;
  String url;
  
  Instruction(this.url);
  
  void init(){
    //new HttpRequest.get(this.url, onSuccessGetJSONInstructions);
    
    String jsonMap;
    js.scoped((){
      var json = js.context.getOuterJSON();
      jsonMap = json;
    });
    
    print(jsonMap);
    this.parseJSONInstructions(jsonMap);
    
  }

  void onSuccessGetJSONInstructions(HttpRequest request){
    parseJSONInstructions(request.responseText);
  }

  void parseJSONInstructions(String json){
    Map instructions = JSON.parse(json);
    instructions.forEach((index,value){
      switch(index){
        case 'player':
          parsePlayerInstruction(value);
          break;
        case 'obstacles':
          parseObstaclesInstruction(value);
          break;
        case 'enemies':
          parseEnemiesInstruction(value);
          break;
        case 'destroyables':
          parseDestroyablesInstruction(value);
          break;
      }
    });
    
    if(this.onComplete != null){
      onComplete();
    } else {
      print('No on complete supplied');
    }
  }

  void parsePlayerInstruction(Map instruction){
    if(PLAYER == null){
      Map graphicInstructions = _getGraphicInstructions(instruction);
      
      PLAYER = new GEPlayer('player');
      PLAYER.setAsRectangle(graphicInstructions['width'], graphicInstructions['height'], graphicInstructions['height']);
      PLAYER.setPosition(graphicInstructions['x'], graphicInstructions['y'], graphicInstructions['z']);
      PLAYER.attachPhysics();
      WEBGL.addToScene(PLAYER, true, false);
      GEWebGL.followGraphic = PLAYER;
    }
  }

  void parseObstaclesInstruction(Map instruction){
    List objects = instruction['objects'];
    
    for(Map objectInstruction in objects){
      Map graphicInstructions = _getGraphicInstructions(objectInstruction);
      
      GEObstacle obstacle = new GEObstacle(objectInstruction['name'] != null ? objectInstruction['name'] : 'unnamed');
      obstacle.setAsRectangle(graphicInstructions['width'], graphicInstructions['height'], graphicInstructions['height']);
      obstacle.setPosition(graphicInstructions['x'], graphicInstructions['y'], graphicInstructions['z']);
      obstacle.attachPhysics();
      WEBGL.addToScene(obstacle, false, false);
    }
    
  }

  void parseDestroyablesInstruction(Map instruction){
    List objects = instruction['objects'];
    
    for(Map objectInstruction in objects){
      Map graphicInstructions = _getGraphicInstructions(objectInstruction);
      
      GEDestroyable destroyable = new GEDestroyable(objectInstruction['name'] != null ? objectInstruction['name'] : 'unnamed');
      destroyable.setAsRectangle(graphicInstructions['width'], graphicInstructions['height'], graphicInstructions['height']);
      destroyable.setPosition(graphicInstructions['x'], graphicInstructions['y'], graphicInstructions['z']);
      destroyable.attachPhysics();
      destroyable.life = objectInstruction['life'] != null ? objectInstruction['life'] : 100;
      WEBGL.addToScene(destroyable, true, false);
    }
    
  }
  
  void parseEnemiesInstruction(Map instruction){
    
  }

  Map _getGraphicInstructions(Map instruction){
    num determineValue(String index, num defaultValue){
      num result;
     
      switch(instruction[index]){
        case 'canvasLeft':
          result = -(SETTINGS.canvasWidth / 2);
          break;
        case 'canvasRight':
          result = SETTINGS.canvasWidth / 2;
          break;
        case 'canvasBottom':
          result = -(SETTINGS.canvasHeight / 2);
          break;
        case 'canvasTop':
          result = SETTINGS.canvasHeight / 2;
          break;   
        case 'canvasWidth':
          result = SETTINGS.canvasWidth;
          break;  
        case 'canvasHeight':
          result = SETTINGS.canvasHeight;
          break;  
        default:
          result = instruction[index] != null ? instruction[index] : defaultValue;
          break;
      }
      
      return result;
    }
    
    num width = determineValue('width', 20);
    num height = determineValue('height', 20);
    num depth = determineValue('depth', 20);
    num x = (determineValue('x', 20) - (SETTINGS.canvasWidth / 2)) + (width / 2);
    //(x - (SETTINGS.canvasWidth / 2)) + (this.width / 2);
    num y = -((determineValue('y', 20) - (SETTINGS.canvasHeight / 2)) + (height / 2));
    //this._y = -((y - (SETTINGS.canvasHeight / 2)) + (this.height / 2));
    num z = determineValue('z', 20);
    
    return {
      "width" : width,
      "height" : height,
      "depth" : depth,
      "x" : x,
      "y" : y,
      "z" : z
    };
  }
}
