part of GE;

class GEDisplayObject extends GEObject {
  THREE.Geometry geometry;
  THREE.MeshBasicMaterial material;
  THREE.Mesh mesh;
  THREE.Color color = new THREE.Color();

  num width;
  num height;
  num depth;
  num radius;
  
  num _x;
  num _y;
  num _z;

  String geometryType;
  
  GEPhysicObject physicsObject;
  
  GEDisplayObject(String name) : super(name);
  
  void setAsRectangle(num width, num height, num depth) {
    this.width = width;
    this.height = height;
    this.depth = depth;
    
    this.geometry = new THREE.PlaneGeometry( this.width, this.height, 1 , 1 );
    this.geometryType = 'rectangle';
    this._createAnimatedMaterial();
    this._createMesh();
    this.mesh.properties['self'] = this;
  }
  
  void setAsSphere(num radius) {
    this.radius = radius;
    
    this.geometry = new THREE.SphereGeometry( radius );
    this.geometryType = 'sphere';
    this._createMaterial();
    this._createMesh();
    this.mesh.properties['self'] = this;    
  }
  
  void _createMaterial() {
    this.material = new THREE.MeshBasicMaterial();
    this.material.wireframe = true;
    this.color.setHex(0xFF0000);
    this.material.color = this.color; 
  }
  
  void _createAnimatedMaterial() {
    THREE.Texture spriteSheet = THREEImageUtils.loadTexture( 'assets/images/run.png');
    
    this.material = new THREE.MeshBasicMaterial(map:spriteSheet);
    this.material.wireframe = false;
  }
  
  void _createMesh(){
    this.mesh = new THREE.Mesh( this.geometry, this.material ); 
  }
  
  void setPosition(num x, num y, num z){
    this.x = x;
    this.y = y;
    this.z = z;
  }
  
  // GETTERS AND SETTERS
  void set x(num x) {
    //this._x = (x - (SETTINGS.canvasWidth / 2)) + (this.width / 2);
    
    this._x = x;
    this.mesh.position.setX(this._x);
  }
  
  num get x{
    return this._x;
  }
  
  void set y(num y) {
    //this._y = -((y - (SETTINGS.canvasHeight / 2)) + (this.height / 2));
    this._y = y;
    this.mesh.position.setY(this._y);
  }
  
  num get y{
    return this._y;
  }
  
  void set z(num z) {
    this._z = z;
    this.mesh.position.setZ(this._z);
  }
  
  num get z{
    return this._z;
  }
}
