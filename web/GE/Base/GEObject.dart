part of GE;

class GEObject {
  String name;
  num ttl;
  
  GEObject(this.name);
  
  void expire() {
    EXPIREABLES.removeAt(EXPIREABLES.indexOf(this)); 
  }
}