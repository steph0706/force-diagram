import java.util.LinkedList;
import java.util.Queue;

class Node {
   final int mass, r, id;
   System parent;
   PVector v0, s0, a0, pos;
   Queue<PVector> q;
   
   Node(int mass, int id, System parent) {
     this.mass = mass;
     this.r = 10;  //change this later??
     this.parent = parent;
     this.id = id;
     this.v0 = new PVector(0, 0);
     this.s0 = new PVector(0, 0);
     this.a0 = new PVector(0, 0);
     //this.pos = new PVector(random(0, width), random(0, height));
     if (id == 1) this.pos = new PVector(250, 250);
     if (id == 2) this.pos = new PVector(500, 500);
     this.q = new LinkedList<PVector>();
   }
   
   PVector calcForce(Node other, float edgeLength) {
     float c = Physics.calcDCoeff(Physics.kineticEnergy(this.mass, this.v0), this.mass);
     PVector damping = Physics.damping(c, v0);
     return Physics.hookes(this.pos, other.pos, edgeLength);
     //return Physics.coulombs(this.pos, other.pos);
     //return Physics.hookes(this.pos, other.pos, edgeLength).add(Physics.coulombs(this.pos, other.pos)).add(damping);
   }
   
   void stageChange(PVector chg) {
     q.add(chg);
   }
   
   void makeChanges() {
     PVector a1 = new PVector(0, 0);
     PVector v1 = new PVector(0, 0);
     PVector s1 = new PVector(0, 0);
     
     while (!q.isEmpty()) {
       PVector chg = q.remove();
       a1.add(Physics.acceleration(chg, this.mass));
       v1.add(Physics.velocity(this.v0, a1, parent.TIME));
       s1.add(Physics.displacement(this.s0, v1, a1, parent.TIME));
       //println(chg, a1, v1, s1);
     }
     
     this.v0 = v1;
     this.a0 = a1;
     this.s0 = s1;
     this.pos.add(s1);
   }
   
   Boolean isOver() {
     return pow(mouseX - this.pos.x, 2) + pow(mouseY - this.pos.y, 2) <= pow(this.r, 2);
   }
   
   void onDrag() {
   
   }
   
   void draw() {
     makeChanges();
     ellipseMode(CENTER);
     fill(0);
     ellipse(this.pos.x, this.pos.y, this.r * 2, this.r * 2);
   }
}