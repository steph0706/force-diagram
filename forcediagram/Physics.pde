abstract class Physics {
  final float HOOKES = 2;
  final float COULOMB = 3;
  
  PVector hookes(PVector dpos) {
    return dpos.mult(HOOKES);
  }
  
  PVector coulombs(PVector distance) {
    float[] arr = distance.array();
    arr[0] *= arr[0];
    arr[1] *= arr[1];
    return new PVector(COULOMB / arr[0], COULOMB / arr[1]);
  }  
  
  PVector acceleration(PVector force, float mass) {
    return force.div(mass);
  }
  
  PVector velocity(PVector v0, PVector a, int time) {
    return v0.add(a.mult(time));
  }
  
  PVector displacement(PVector s0, PVector v, PVector a, int time) {
    return s0.add(v.mult(time)).add(a.mult(0.5*time*time));
  }
  
  float kineticEnergy(float mass, PVector v0) {
    return 0.5 * mass * v0.dot(v0);
  }
  
  
  float calcDCoeff(float k, float mass) {
    return 2 * sqrt(mass * k);
  }
  
  PVector damping(float c, PVector v) {
    return v.mult(-c); 
  }
}