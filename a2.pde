System sys;
final color OFF = color(176, 224, 230);
final color ON = color(65, 105, 225);
final float MIN_ENERGY = 0.0001;
Boolean interacted = false;

void setup() {
  size(640, 480);
  surface.setResizable(true);
  selectInput("Choose a file", "parseData");
}

void draw() {
  background(color(255, 255, 255));
  if (sys != null) {
    mouseOver();
    if (sys.totalEnergy > MIN_ENERGY || interacted) {
      sys.updateForces();
      sys.commitNodes();
      interacted = false;
    }
    sys.draw();
  }
}

// need to add -1 len edges for nodes not conencted by springs
void parseData(File file) {
  if (file == null) {
    println("No file was selected.");
  } else {
    System s = new System(ON, OFF);
    
    HashMap<Integer, Node> nodesHash = new HashMap<Integer, Node>();
    
    String[] lines = loadStrings(file.getAbsolutePath());
    int numNodes = Integer.valueOf(lines[0]);
    
    for (int i = 1; i <= numNodes; i++) {
      String[] currLine = lines[i].split(",");
      int id = Integer.valueOf(currLine[0]);
      int mass = Integer.valueOf(currLine[1]);
      nodesHash.put(id, s.makeNode(id, mass));
    }
    
    int numEdges = Integer.valueOf(lines[numNodes + 1]);
    for (int i = numNodes+2; i < numNodes + 2 + numEdges; i++) {
       String[] currLine = lines[i].split(",");
       Node n1 = nodesHash.get(Integer.valueOf(currLine[0]));
       Node n2 = nodesHash.get(Integer.valueOf(currLine[1]));
       s.makeEdge(n1, n2, Integer.valueOf(currLine[2]));
    }
    
    sys = s;
  }
}

void mouseOver() {
  for (Node n : sys.nodes) {
    if (n.isOver()) {
      n.onOver();
    } else {
      n.onOff();
    }
  }
}

void mousePressed() {
  interacted = true;
  ArrayList<Node> nodesCopy = new ArrayList<Node>(sys.nodes);
  for (Node n : nodesCopy) {
    if (n.isOver()) n.onPress();
  }
  sys.onPress();
}

void mouseReleased() {
  interacted = true;
  for (Node n : sys.nodes) {
    n.onRelease();
  }
  sys.onRelease();
}

void mouseDragged() {
  interacted = true;
  for (Node n : sys.nodes) {
    if (n.dragged) n.onDrag();
  }
}

void mouseClicked() {
  interacted = true;
  ArrayList<Node> nodesCopy = new ArrayList<Node>(sys.nodes);
  for (Node n : nodesCopy) {
    if (n.isOver()) n.onClick();
  }
}