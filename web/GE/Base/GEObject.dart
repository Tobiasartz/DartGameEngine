part of GE;

class GEObject {
  String name;
  num ttl;
  
  GEObject(this.name);
  
  void onUpdate(num time) {
    // Extend
  }
  
  void onClick() {
   // Extend 
  }
  
  void expire() {
    EXPIREABLES.removeAt(EXPIREABLES.indexOf(this)); 
  }
}