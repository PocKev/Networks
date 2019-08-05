public class PathFinder {
  int stepCounter;
  float finalDistance;
  Path finalPath;
  
  public PathFinder() {
    stepCounter = 0;
    finalPath = new Path();
    
    for (int i = 0; i < links.size(); i++) {
      links.get(i).highlighted = false;
    }
    
    for (int i = 0; i < nodes.size(); i++) {
      if (nodes.get(i).isStart == true) {
        nodes.get(i).weight = 0;
        Path path = new Path();
        step(nodes.get(i), path, nodes.get(i));
      }
    }
    System.out.println("======FINAL========\nDistance: " + finalDistance);
    System.out.println("Path: " + finalPath);
    highlightPath(finalPath);
  }
  
  void step(Node n, Path p, Node last) { //step(this Node, from last Node)
    stepCounter++;
    ArrayList<Node> nextNodes = new ArrayList<Node>();
    ArrayList<Path> nextPaths = new ArrayList<Path>();
    p.addToPath(n.name);
    System.out.println("This path sequence: " + p + " with length: " + p.getLength());
    
    for (int i = 0; i < nodes.size(); i++) {
      Path temporaryPath = new Path();
      temporaryPath.addToPath(p.toString()); //copy p to tempraryPath
      temporaryPath.addToPath(i); //add new node to temporaryPath
      
      if (!n.equals(nodes.get(i)) && !temporaryPath.hasRepeated() && !nodes.get(i).equals(last) && n.adjacentTo(nodes.get(i))) { 
        System.out.println("temporary path: " + temporaryPath);
        
        float temporaryWeight = n.weight + new Link(n, nodes.get(i)).distance;
        
        if (temporaryWeight < nodes.get(i).weight) {
          nodes.get(i).weight = temporaryWeight;
        }
        if (!nodes.get(i).isEnd && temporaryWeight <= nodes.get(i).weight) { //if the adjacent node to n is not the end
          nextNodes.add(nodes.get(i));
          nextPaths.add(new Path(p.toString()));
          //nextPaths.get(nextPaths.size() - 1).pathLength += temporaryWeight;
        }
        else if (nodes.get(i).isEnd) { //if the adjacent node to n is the end
          System.out.println("Current distance: " + temporaryPath.getLength());
          System.out.println("Current path: " + temporaryPath);
          
          if (temporaryPath.pathLength <= finalPath.pathLength || finalPath.pathLength == 0) {
            finalPath = temporaryPath;
            finalDistance = temporaryPath.pathLength;
          }
          //System.out.println(temporaryPath);
        }
        //System.out.print("add " + nextNodes.size());
      }
    }
    
    System.out.print(nextNodes.size() + " Next Nodes: ");
    for (int i = 0; i < nextNodes.size(); i++) {
      System.out.print(nextNodes.get(i).name + " ");
    } System.out.println();
    
    for (int i = 0; i < nextNodes.size(); i++) {
      //Path newPath = new Path();
      //newPath.addToPath(p.toString());
      //newPath.pathLength += nextNodes.get(i).weight;
      step(nextNodes.get(i), nextPaths.get(i), n);
    }
  }
}
