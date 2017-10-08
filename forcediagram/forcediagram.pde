System sys = null;

void setup() {
  size(1024, 768);
  background(color(255, 255, 255));
  surface.setResizable(true);
  
  //selectInput("Select a file to process: ", "parseData");
  parseData(new File("/home/charlw/Comp/comp177/a2/forcediagram/data3.csv"));
}

void draw() {
  background(255);
  if (sys != null) {
    sys.updateForces();
    sys.draw();
  }
}

void parseData(File file) {
  if (file == null) {
    println("No file was selected.");
  } else {
    ArrayList<Edge> edges = new ArrayList<Edge>();
    ArrayList<Node> nodes = new ArrayList<Node>();
    System s = new System(edges, nodes);
    
    HashMap<Integer, Node> nodesHash = new HashMap<Integer, Node>();
    
    String[] lines = loadStrings(file.getAbsolutePath());
    int numNodes = Integer.valueOf(lines[0]);
    
    for (int i = 1; i <= numNodes; i++) {
      String[] currLine = lines[i].split(",");
      int id = Integer.valueOf(currLine[0]);
      int mass = Integer.valueOf(currLine[1]);
      nodesHash.put(id, new Node(mass, id, s));
    }
    
    int numEdges = Integer.valueOf(lines[numNodes + 1]);
    for (int i = numNodes+2; i < numNodes + 2 + numEdges; i++) {
       String[] currLine = lines[i].split(",");
       Node n1 = nodesHash.get(Integer.valueOf(currLine[0]));
       Node n2 = nodesHash.get(Integer.valueOf(currLine[1]));
       Edge e = new Edge(n1, n2, Integer.valueOf(currLine[2]));
       edges.add(e);
    }
    
    nodes.addAll(nodesHash.values());
    sys = s;
  }
}