public class Path {
  String sequence;
  float pathLength;
  
  public Path() {
    sequence = new String();
    pathLength = 0;
  }
  public Path(String s) {
    sequence = s;
  }
  void addToPath(int charNumber) {
    sequence = sequence + charNumber;
  }
  void addToPath(String charNumber) {
    sequence = sequence + charNumber;
  }
  
  float getLength() {
    float partialLength = 0;
    try {
      for (int i = 0; i < sequence.length() - 1; i++) {
        String node1Name = str(sequence.charAt(i));
        String node2Name = str(sequence.charAt(i+1));
        
        for (int j = 0; j < links.size(); j++) {
          if (links.get(j).contains(node1Name, node2Name)) {
            partialLength += links.get(j).distance;
            //System.out.print(partialLength + " ");
          }
        }
      }
    } catch(ArrayIndexOutOfBoundsException e) {
      pathLength = 0;
      return 0;
    }
    pathLength = partialLength;
    return partialLength;
  }
  
  boolean hasRepeated() {
    ArrayList<String> pairs = new ArrayList<String>();
    for (int i = 0; i < sequence.length() - 1; i++) {
      pairs.add(sequence.substring(i, i+2));
    }
    
    for (int i = 0; i < pairs.size(); i++) {
      for (int j = 0; j < pairs.size(); j++) {
        //System.out.print(pairs.get(i) + " " + pairs.get(j) + " | ");
        if (i != j && pairs.get(i).equals(pairs.get(j))) {
          return true;
        }
      }
      //System.out.println();
    }
    return false;
  }
  
  String toString() {
    return sequence;
  }
}
