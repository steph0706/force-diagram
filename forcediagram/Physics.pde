class Physics {
  final float hConstant = 2;
  final float cConstant = 3;
  
  PVector hookes(PVector dx) {
    return dx.mult(hConstant);
  }
  
  PVector coulombs(PVector distance) {
    return distance.mult(1/cConstant);
  }  
  
  PVector acceleration(PVector force, float mass) {
    return force.mult(1/mass);
  }
  
  PVector velocity(PVector v0, PVector a, int time) {
    return v0.add(a.mult(time));
  }
  
  PVector displacement(PVector s0, PVector v, PVector a, int time) {
    PVector temp = s0.add(v.mult(time));
    temp.add(a.mult(0.5*time*time));
    return temp;
  }
  
  float kineticEnergy(float mass, PVector v0) {
    float temp = v0.dot(v0);
    return temp * 0.5 * mass;
  }
  
  
  float calcDCoeff(float k, float mass) {
    return 2 * sqrt(mass * k);
  }
  
  PVector damping(float c, PVector v) {
    return v.mult(-c); 
  }


}