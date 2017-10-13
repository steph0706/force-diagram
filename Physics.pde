static abstract class Physics {
  static final float HOOKES = 0.0007;
  static final float COULOMBS = 800;
  static final float DAMP = 0.005;
  
  static PVector hookes(PVector pos1, PVector pos2, float relaxed) {
    PVector spring = PVector.sub(pos2, pos1);
    float stretched = spring.mag();
    if (stretched < 0) return new PVector(0, 0);
    float factor = -(relaxed / stretched);
    if (factor < -1) factor = -1;
    return PVector.mult(spring, HOOKES * sqrt(1 + factor));
  }
  
  static PVector coulombs(PVector pos1, PVector pos2) {
    PVector spring = PVector.sub(pos1, pos2);
    float distance = spring.mag();
    if (distance < 0) return new PVector(0, 0);
    spring.normalize(); // now unit vector
    return PVector.mult(spring, COULOMBS / pow(distance, 2));
  }

  static PVector damping(PVector v0) {
    return PVector.mult(v0, -DAMP);
  }
  
  static PVector acceleration(PVector f, float mass) {
    return PVector.div(f, mass);
  }
  
  static PVector velocity(PVector v0, PVector a, float t) {
    return PVector.add(v0, PVector.mult(a, t));
  }
  
  static PVector displacement(PVector v0, PVector a, float t) {
    return PVector.add(PVector.mult(v0, t), PVector.mult(a, 0.5 * pow(t, 2)));
  }
  
  static float kineticEnergy(float mass, PVector v0) {
    return pow(v0.mag(), 2) * 0.5 * mass;
  }
  
  static float radius(float mass) {
    return sqrt(mass) + 5;
  }
}