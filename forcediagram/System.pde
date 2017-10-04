class System {
  float totalEnergy;
  float time = 1;
  ArrayList<Edge> edges;
  ArrayList<Node> nodes;
  
  System(float energy, ArrayList<Edge> edges, ArrayList<Node> nodes) {
     totalEnergy = energy;
     this.edges = edges;
     this.nodes = nodes;
  }
  
  void updateEnergy(float e) {
    totalEnergy += e;
  }
  
  void stageNodes() {
    
  }
  
  void updateNodes() {
    
  }
  
  void updateEdges() {
    
  }
  
  void draw() {
    
  }
}