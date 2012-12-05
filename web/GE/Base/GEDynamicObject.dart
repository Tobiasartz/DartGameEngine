part of GE;

class GEDynamicObject extends GEStaticObject {
  GEDynamicObject(String name) : super(name);
  
  void onUpdate(num time){
    if(this.physicsObject != null){     
      this.setPosition(this.physicsObject.bodyX, this.physicsObject.bodyY, 1);
      this.mesh.rotation.z = this.physicsObject.bodyAngle;
    }
  }
}