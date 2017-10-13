class Edge {
  final float len;
  Node n1, n2;
  
  Edge(Node n1, Node n2, float len) {
    this.n1 = n1;
    this.n2 = n2;
    this.len = len;
  }
  
  void useTheForce() {
    this.n1.stageChange(this.n1.calcSpringForce(this.n2, this.len));
    this.n2.stageChange(this.n2.calcSpringForce(this.n1, this.len));
  }
  
  void draw() {
    line(this.n1.pos.x, this.n1.pos.y,
         this.n2.pos.x, this.n2.pos.y);
  }
}