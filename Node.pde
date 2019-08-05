public class Node {
  Vec2 position;
  boolean highlighted;
  boolean isStart, isEnd; //can only have 1 of each per time in a network
  float weight; //the shortest path distance to this Node
  String name;
  
  public Node(float x, float y) {
    position = new Vec2(x, y);
    highlighted = false;
    isStart = false;
    isEnd = false;
    weight = 10000; //arbitrary large number (by default not shortest path)
  }
  
  public boolean adjacentTo(Node n) { //tests if Node n shares a Link with this Node
    for (int i = 0; i < links.size(); i++) {
      if (links.get(i).n1.position.x == this.position.x && links.get(i).n1.position.y == this.position.y) {
        if (n.equals(links.get(i).n2)) {
          return true;
        }
      }
      if (links.get(i).n2.position.x == this.position.x && links.get(i).n2.position.y == this.position.y) {
        if (n.equals(links.get(i).n1)) {
          return true;
        }
      }
    }
    return false;
  }
  
  void drawNode() {
    noStroke();
    if (highlighted) 
      fill(207, 209, 83);
    else if (!highlighted)
      fill(97, 47, 104);
    if (isStart)
      fill(53, 158, 22);
    if (isEnd)
      fill(193, 9, 9);
    ellipse(position.x, position.y, 10, 10);
    text(name + ": " + weight, position.x, position.y - 10);
  }
  
  public String toString() {
    return position.x + ", " + position.y;
  }
}
