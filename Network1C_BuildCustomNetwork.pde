/*
Custom Network Builder and Path Finder
 by Kevin Ge
 Tasks:
 Build any custom nondirectional network consisting of straight lines
 Find optimal path through each intersection.
 */

import org.jbox2d.common.*;
import g4p_controls.*;

ArrayList<Link> links;
ArrayList<Node> nodes;
GImageButton button_SelectNode;
GImageButton button_SelectLink;
GImageButton button_SelectPath;
GLabel label_Node;
GLabel label_Link;
GLabel label_Path;
int selectionMode;
boolean toNextEndpt;

Path testPath;

void setup() {
  size(1200, 800);

  links = new ArrayList<Link>();
  nodes = new ArrayList<Node>();

  createButtons();
  selectionMode = 0; //by default
  toNextEndpt = false;

  //testPath = new Path("111");
  //System.out.print(testPath.hasRepeated());
}

void draw() {
  background(255);
  drawNetwork();

  if (selectionMode == 1)
    testLinks();
  //if (selectionMode == 2) 
  //testEndPoints();
}

void keyPressed() {
  System.out.println(nodes.get(1).adjacentTo(nodes.get(2))); //debugger
}

void mousePressed() {
  switch(selectionMode) {
  case 0: 
    nodes.add(new Node(mouseX, mouseY));
    nodes.get(nodes.size() - 1).name = "" + (nodes.size() - 1);
    if (mouseX < 370 && mouseY > 700) nodes.remove(nodes.size() - 1);
    break;
  case 1:
    for (int i = 0; i < nodes.size(); i++) {
      if (sqrt(pow(mouseX - nodes.get(i).position.x, 2) + pow(mouseY - nodes.get(i).position.y, 2)) < 10) { //node hitbox
        if (nodes.get(i).highlighted == false) nodes.get(i).highlighted = true;
        else if (nodes.get(i).highlighted == true) nodes.get(i).highlighted = false;
      }
    }
    break;
  case 2:
    testEndPoints();
    break;
  }
}

void testLinks() {
  ArrayList<Integer> indexes = new ArrayList<Integer>();
  ArrayList<Node> tempNodes = new ArrayList<Node>();
  for (int i = 0; i < nodes.size(); i++) {
    if (nodes.get(i).highlighted == true) {
      tempNodes.add(nodes.get(i));
      indexes.add(i);

      if (tempNodes.size() >= 2) {
        links.add(new Link(tempNodes.get(0), tempNodes.get(1)));
        tempNodes = new ArrayList<Node>();

        nodes.get(indexes.get(0)).highlighted = false;
        nodes.get(indexes.get(1)).highlighted = false;
      }
    }
  }
}

void testEndPoints() {
  for (int i = 0; i < nodes.size(); i++) {
    if (sqrt(pow(mouseX - nodes.get(i).position.x, 2) + pow(mouseY - nodes.get(i).position.y, 2)) < 10) {
      if (!toNextEndpt) {
        nodes.get(i).isStart = true;
        toNextEndpt = true;
      } else if (toNextEndpt) {
        nodes.get(i).isEnd = true;
        toNextEndpt = false;
        new PathFinder();
        selectionMode = 0;
      }
    }
  }
}

void highlightPath(Path p) {
  String pathString = p.sequence;
  for (int i = 0; i < pathString.length() - 1; i++) {
    String node_1 = pathString.substring(i, i+1);
    String node_2 = pathString.substring(i+1, i+2);
    for (int j = 0; j < links.size(); j++) {
      if (links.get(j).contains(node_1, node_2)) {
        links.get(j).highlighted = true;
      }
    }
  }
}

void drawNetwork() {
  for (Node n : nodes) {
    n.drawNode();
  }
  for (Link l : links) {
    l.drawLink();
  }
}

void createButtons() {
  String[] imageFiles = new String[] {
    "blueButton0.png", "blueButton1.png", "blueButton2.png"
  };
  button_SelectNode = new GImageButton(this, 10, 742, imageFiles);
  label_Node = new GLabel(this, 38, 710, 64, 32, "NODE");
  button_SelectLink = new GImageButton(this, 124, 742, imageFiles);
  label_Link = new GLabel(this, 158, 710, 64, 32, "LINK");
  button_SelectPath = new GImageButton(this, 238, 742, imageFiles);
  label_Path = new GLabel(this, 268, 710, 64, 32, "PATH");
}

void handleButtonEvents(GImageButton button, GEvent event) {
  if (button == button_SelectNode) {
    selectionMode = 0;
  } else if (button == button_SelectLink) {
    selectionMode = 1;
  } else if (button == button_SelectPath) {
    selectionMode = 2;
    for (int i = 0; i < nodes.size(); i++) {
      nodes.get(i).isStart = false;
      nodes.get(i).isEnd = false;
    }
    toNextEndpt = false;
  }
}
