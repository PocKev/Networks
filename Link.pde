public class Link {
  Node n1, n2;
  float distance;
  boolean highlighted;
  
  public Link(Node n1, Node n2) {
    this.n1 = n1;
    this.n2 = n2;
    
    highlighted = false;
    distance = sqrt(pow(n2.position.x - n1.position.x, 2) + pow(n2.position.y - n1.position.y, 2));
  }
  
  void drawLink() {
    strokeWeight(2);
    if (!highlighted) {
      stroke(59, 107, 124);
    }
    else {
      stroke(245, 66, 114);
    }
    line(n1.position.x, n1.position.y, n2.position.x, n2.position.y);
    //text(distance, (n1.position.x + n2.position.x) / 2, (n1.position.y + n2.position.y) / 2);
  }
  
  boolean contains(String nodeA, String nodeB) {
    if (nodeA.equals(n1.name) && nodeB.equals(n2.name)) {
      return true;
    }
    else if (nodeB.equals(n1.name) && nodeA.equals(n2.name)) {
      return true;
    }
    return false;
  }
  
  public String toString() {
    return n1 + " " + n2;
  }
}
