part of GE;

class GEGraphic extends GEObject {
  js.Proxy geometry;
  js.Proxy material;
  js.Proxy mesh;
  num _x;
  num _y;
  num _z;
  num _color = 0xFF0000;
  num width;
  num height;
  num depth;
  GEPhysicObject physicsObject;
  
  GEGraphic(String name) : super(name);
  
  
  void setAsRectangle(num width, num height, num depth) {
    js.scoped((){
      this.geometry = new js.Proxy(js.context.THREE.PlaneGeometry, width, height, 1 , 1 );
      this.material = new js.Proxy(js.context.THREE.MeshBasicMaterial, js.map({
        'color' : this._color,
        'wireframe' : true
      }));
      this.mesh = new js.Proxy(js.context.THREE.Mesh, this.geometry, this.material );
      js.retain(this.geometry);
      js.retain(this.material);
      js.retain(this.mesh);
    });
    
    this.width = width;
    this.height = height;
    this.depth = depth;
  }

  void attachPhysics(){
   this.physicsObject = new GEPhysicObject(); 
   this.physicsObject.createRectangleBody(this.width, this.height,'dynamic');
   this.physicsObject.bodyX = this.x;
   this.physicsObject.bodyY = this.y;
  }
  
  void setPosition(num x, num y, num z){
    this._x = x;
    this._y = y;
    this._z = z;
    //js.scoped((){
      //this.mesh.position.set(x,y,z);
    //});
  }
  
  void onUpdate(){
   super.onUpdate();
   
   if(this.physicsObject != null){     
     this.setPosition(this.physicsObject.bodyX, this.physicsObject.bodyY, 1);
   }
  }
  
  void set color(num color) {
    this._color = color;
    js.scoped((){
      this.material.color.setHex(this._color);
    });
  }
  
  num get color{
    return this._color;
  }
  
  void set x(num x) {
    this._x = x;
    js.scoped((){
      this.mesh.position.x = this._x;
    });
  }
  
  num get x{
    return this._x;
  }
  
  void set y(num y) {
    this._y = y;
    js.scoped((){
      this.mesh.position.y = this._y;
    });
  }
  
  num get y{
    return this._y;
  }
  
  void set z(num z) {
    this._z = z;
    js.scoped((){
      this.mesh.position.z = this._z;
    });
  }
  
  num get z{
    return this._z;
  }
}
