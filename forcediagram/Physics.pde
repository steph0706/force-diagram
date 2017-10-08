static abstract class Physics {
  static final float HOOKES = 0.000001;
  static final float COULOMB = 0.005;
  
  static PVector hookes(PVector pos1, PVector pos2, float len) {
    float dx = pos2.x - pos1.x;    
    float dy = pos2.y - pos1.y;
    float xDiff = pow(dx, 2);
    float yDiff = pow(dy, 2);
    //float c = sqrt(xDiff + yDiff) - len;
    //float x = sqrt((xDiff/ (xDiff + yDiff)) * pow(c, 2)) * (dx < 0 ? -1 : 1);
    //float y = sqrt((yDiff/ (xDiff + yDiff)) * pow(c, 2)) * (dy < 0 ? -1 : 1);
    //return PVector.mult(new PVector(x, y), HOOKES);
    
  }
  
  static PVector coulombs(PVector pos1, PVector pos2) {
    // deal with 0?
    float xDiff = pos2.x - pos1.x;
    float yDiff = pos2.y - pos1.y;
    float cX = COULOMB / pow(xDiff, 2) * (xDiff < 0 ? 1 : -1);
    float cY = COULOMB / pow(yDiff, 2) * (yDiff < 0 ? 1 : -1);
    return new PVector(cX, cY);
  }
  
  static PVector acceleration(PVector force, float mass) {
    return PVector.div(force, mass);
  }
  
  static PVector velocity(PVector v0, PVector a, int time) {
    return PVector.add(v0, PVector.mult(a, time));
  }
  
  static PVector displacement(PVector s0, PVector v, PVector a, int time) {
    return PVector.add(s0, PVector.add(PVector.mult(v, time), PVector.mult(a, 0.5 * time * time)));
  }
  
  static float kineticEnergy(float mass, PVector v) {
    return 0.5 * mass * pow(v.mag(), 2);
  }
  
  
  static float calcDCoeff(float k, float mass) {
    return 2 * sqrt(mass * k);
  }
  
  static PVector damping(float c, PVector v) {
    return PVector.mult(v, -c);
  }
}