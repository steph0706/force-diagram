import java.util.LinkedList;
import java.util.Queue;

class Node {
  final int id;
  final float r, mass;
  System parent;
  PVector v0, pos;
  Queue<PVector> q;
  Boolean dragged;
  color on, off;
  private color c;
  
  Node(int id, float mass, System parent, float x, float y, color on, color off) {
    this.mass = mass;
    this.r = Physics.radius(this.mass);
    this.parent = parent;
    this.id = id;
    this.v0 = new PVector(0, 0);
    this.pos = new PVector(x, y);
    this.q = new LinkedList<PVector>();
    this.dragged = false;
    this.on = on;
    this.off = off;
    this.c = off;
  }
  
  PVector calcParticleForce(Node other) {
    PVector fc = Physics.coulombs(this.pos, other.pos);
    PVector fd = Physics.damping(this.v0);
    return PVector.add(fc, fd);
  }
  
  PVector calcSpringForce(Node other, float len) {
    return Physics.hookes(this.pos, other.pos, len);
  }
  
  void stageChange(PVector chg) {
    q.add(chg);
  }
  
  void makeChanges() {
    if (dragged) {
      q.clear();
      return;
    }
    PVector total = new PVector(0, 0);
    while (!q.isEmpty()) total.add(q.remove());
    PVector a = Physics.acceleration(total, this.mass);
    PVector v1 = Physics.velocity(this.v0, a, this.parent.TIME);
    PVector s = Physics.displacement(this.v0, a, this.parent.TIME);
    this.v0 = v1;
    this.pos.add(s);
  }
  
  void onClick() {
    if (mouseButton == RIGHT) {
      parent.removeNode(this);
    }
  }
  
  void onPress() {
    this.dragged = true;
  }
  
  void onRelease() {
    for (Node n : this.parent.nodes) {
      if (n != this && this.dragged && mouseButton == RIGHT && n.isOver()) {
        parent.makeEdge(n, this, PVector.sub(n.pos, this.pos).mag());
        break;
      }
    }
    this.dragged = false;
  }
  
  Boolean isOver() {
    return pow(mouseX-this.pos.x, 2) + pow(mouseY-this.pos.y, 2) <= pow(this.r, 2);
  }
  
  void onDrag() {
    // move using displacement
    if (mouseButton == LEFT) {
      PVector s1 = new PVector(mouseX - this.pos.x, mouseY - this.pos.y);
      s1.div(2);
      this.v0 = PVector.div(s1, this.parent.TIME);
      this.pos.add(s1);
    }
  }
  
  void onOver() {
    this.c = this.on;
    
  }
  
  void onOff() {
    this.c = this.off;
  }

  void draw() {
    // new line
    if (this.dragged && mouseButton == RIGHT) line(mouseX, mouseY, this.pos.x, this.pos.y);
    
    // node
    ellipseMode(CENTER);
    fill(this.c);
    ellipse(this.pos.x, this.pos.y, this.r * 2, this.r * 2);
  }
}