final float GROWTH = 1;

class System {
  final float TIME = 1;
  float totalEnergy;
  ArrayList<Edge> edges;
  ArrayList<Node> nodes;
  color on, off;
  private int nextID;
  private float newMass;
  private Boolean dragged;
  
  System(color on, color off) {
    this.edges = new ArrayList<Edge>();
    this.nodes = new ArrayList<Node>();
    this.on = on;
    this.off = off;
    this.newMass = 1;
    this.nextID = 1;
    this.dragged = false;
    this.totalEnergy = 1; // to allow over threshold on initial run
  }
  
  Node makeNode(int id, float mass, float x, float y) {
    Node n = new Node(id, mass, this, x, y, this.on, this.off);
    this.nodes.add(n);
    this.nextID++;
    return n;
  }

  
  Node makeNode(int id, float mass) {
    return makeNode(id, mass, random(0, width), random(0, height));
  }
  
  void removeNode(Node n) {
    this.nodes.remove(n);
    ArrayList<Edge> edgeCopy = new ArrayList<Edge>(this.edges);
    for (Edge e : edgeCopy) {
      if (e.n1 == n || e.n2 == n) this.edges.remove(e);
    }
  }
  
  Edge makeEdge(Node n1, Node n2, float len) {
    Edge e = new Edge(n1, n2, len);
    this.edges.add(e);
    return e;
  }

  void updateForces() {
    for (int i = 0; i < this.nodes.size()-1; i++) {
      Node n1 = this.nodes.get(i);
      for (int j = i+1; j < this.nodes.size(); j++) {
        Node n2 = this.nodes.get(j);
        n1.stageChange(n1.calcParticleForce(n2));
        n2.stageChange(n2.calcParticleForce(n1));
      }
    }
    for (Edge e : this.edges) e.useTheForce();
  }
  
  void commitNodes() {
    this.totalEnergy = 0;
    for (Node n : this.nodes) {
      n.makeChanges();
      this.totalEnergy += Physics.kineticEnergy(n.mass, n.v0);
    }
  }
  
  void onPress() {
    if (mouseButton == LEFT) {
      for (Node n : this.nodes) {
        if (n.isOver()) return;
      }
      this.dragged = true;
    }
  }
  
  void onRelease() {
    if (this.dragged) makeNode(this.nextID, this.newMass, mouseX, mouseY);
    this.newMass = 1;
    this.dragged = false;
  }
  
  void drawLabel(Node n) {
    float padding = 3;
    String mass = "Mass: " + String.valueOf(n.mass);
    String id = "ID: " + String.valueOf(n.id);
    float textW = max(textWidth(mass), textWidth(id)) + 2 * padding;
    float boxH = 2 * (textAscent() + textDescent() + 2 * padding);
    float boxX = mouseX;
    float boxY = mouseY - boxH - padding;
    fill(255);
    rect(boxX, boxY,  textW, boxH);
    fill(0);
    text(id, boxX + padding, boxY + (textAscent() + textDescent() + padding));
    text(mass, boxX + padding, boxY + 2 * (textAscent() + textDescent() + padding));
  }
  
  void draw() {
    for (Edge e : this.edges) e.draw();
    for (Node n : this.nodes) n.draw();
    
    // new mass
    if (this.dragged) {
      float newRadius = Physics.radius(this.newMass);
      ellipseMode(CENTER);
      fill(OFF);
      ellipse(mouseX, mouseY, newRadius * 2, newRadius * 2);
      this.newMass += GROWTH;
    }
    
    // tooltip
    for (Node n : this.nodes) if (n.isOver()) drawLabel(n);

    // energy output
    fill(0);
    String energyText = "Total Energy: " + String.format("%08f", this.totalEnergy);
    text(energyText, 10, 20);
  }
}