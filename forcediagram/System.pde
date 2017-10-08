class System {
  final int TIME = 1;
  float totalEnergy;
  ArrayList<Edge> edges;
  ArrayList<Node> nodes;
  
  System(ArrayList<Edge> edges, ArrayList<Node> nodes) {
     this.edges = edges;
     this.nodes = nodes;
  }
  
  void updateEnergy() {
    // go over all edges/nodes to get energy
  }

  void updateForces() {
    for (Edge e : this.edges) e.useTheForce();
  }
  
  void draw() {
    for (Node n : this.nodes) n.draw();
    for (Edge e : this.edges) e.draw();
  }
}