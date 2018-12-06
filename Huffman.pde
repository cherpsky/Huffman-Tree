String[] lines;
ArrayList<Character> chars;
ArrayList<Node> nodes;
ArrayList<Node> originalNodes;
ArrayList<Node> finalNodes;
int x = width/2;
int y = 40;

int ascii;
int compressed;

import java.util.Set;
import java.util.HashSet;

void setup() {
  frameRate(2);
  size(800, 600);
  rectMode(CENTER);
  lines = loadStrings("Cartillas.txt");
  chars = new ArrayList<Character>();
  nodes = new ArrayList<Node>();
  finalNodes = new ArrayList<Node>();
  originalNodes = new ArrayList<Node>();

  for (String line : lines) {
    for (int i = 0; i < line.length(); i++) {
      chars.add(Character.toLowerCase(line.charAt(i)));
    }
  }

  Set<Character> uniqueChars = new HashSet<Character>(chars);
  println(uniqueChars);

  for (Character u : uniqueChars) {
    int frequency = 0;
    for (Character c : chars) {
      if (u == c) {
        frequency++;
      }
    }
    Node temp = new Node(u, frequency);
    nodes.add(temp);
    finalNodes.add(temp);
    originalNodes.add(temp);
  }

  createHuffmanTree(nodes);
  
  ascii = chars.size() * 8;
  println("Tamaño :" + ascii);
}





void draw() {
  background(255);
  drawTable(originalNodes);
  for (Node n : finalNodes) {
    if (!n.isLeaf()) {
      //right is red
      stroke(255, 0, 0);
      fill(255, 0, 0);
      line(n.x, n.y, n.left.x, n.left.y);
      text("0", (n.x+n.left.x)/2, (n.y+n.left.y)/2);

      //left is blue
      stroke(0, 0, 255);
      fill(0, 0, 255);
      line(n.x, n.y, n.right.x, n.right.y);
      text("1", (n.x+n.right.x)/2, (n.y+n.right.y)/2);
    }

    n.draw();
  }

  for (Node n : finalNodes) {
    if (n.hasParent()) { 
      if (n.right()) {
        n.x = n.parent.x+50;
        n.y = n.parent.y +70;
        n.code= n.parent.code + "1";
      } else {
        n.code= n.parent.code + "0";
        n.x = n.parent.x-50;
        n.y = n.parent.y +50;
      }
    }
  }
}










void createHuffmanTree(ArrayList<Node> nodes) {
  //index used to delete the element picked
  //to be the least frequen one
  int index = 0;

  //just the nodes that will be left and right, 
  //kinda null nodes
  Node left = new Node(new Character('*'), 0);
  Node right = new Node(new Character('*'), 0);
  double smallestFrequency = Double.POSITIVE_INFINITY;

  for (int i = 0; i < nodes.size(); i++) {
    Node node = nodes.get(i);
    if (node.frequency < smallestFrequency) {
      smallestFrequency = node.frequency;
      left = node;
      index = i;
    }
  }
  //delete the element
  nodes.remove(index);

  smallestFrequency = Double.POSITIVE_INFINITY;
  for (int i = 0; i < nodes.size(); i++) {
    Node node = nodes.get(i);    
    if (node.frequency < smallestFrequency) {
      smallestFrequency = node.frequency;
      right = node;
      index = i;
    }
  }
  //delete the 2nd least frequent element
  nodes.remove(index);

  //println("Izquierda:" + left.c + ".");
  //println("Derecha:" + right.c + ".");
  right.isRight = true;
  Node temp = new Node(left, right);

  right.parent = temp;
  left.parent = temp;

  finalNodes.add(temp);
  nodes.add(temp);

  if (nodes.size() > 1) {
    createHuffmanTree(nodes);
  }
}

void drawTree(Node parent) {
  parent.draw();
  if (parent.isLeaf()) {
    parent.left.x = parent.x-50;
    parent.left.y = parent.y+30;    
    parent.right.x = parent.x+50;
    parent.right.y = parent.y+30;
    parent.left.draw();
    parent.right.draw();

    stroke(0, 255, 0);
    line(parent.x, parent.y, parent.right.x, parent.right.y);
    textSize(20);
    stroke(255, 0, 0);
    line(parent.x, parent.y, parent.left.x, parent.left.y);

    drawTree(parent.right);
  }
}

void drawTable(ArrayList<Node> nodes) {
  int x = 20;
  int y = 20;
  stroke(0);
  text("x: ", x, y-10);
  text("f: ", x+30, y-10);

  for (Node n : nodes) {
    text("'"+n.c+"': ", x, y);
    text("   " +n.frequency, x+10, y);
    y+=15;
  }
}
