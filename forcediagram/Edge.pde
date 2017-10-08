class Edge {
  final float len;
  Node n1, n2;
  
  Edge(Node n1, Node n2, float len) {
    this.n1 = n1;
    this.n2 = n2;
    this.len = len;
  }
  
  void useTheForce() {
    this.n1.stageChange(this.n1.calcForce(this.n2, this.len));
    this.n2.stageChange(this.n2.calcForce(this.n1, this.len));
  }
  
  void draw() {
    float absX1 = this.n1.pos.x;
    float absY1 = this.n1.pos.y;
    float absX2 = this.n2.pos.x;
    float absY2 = this.n2.pos.y;
    line(absX1, absY1, absX2, absY2);
  }
  
}