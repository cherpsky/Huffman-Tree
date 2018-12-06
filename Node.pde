class Node {
  String c;
  int frequency;
  float x = width/2;
  float y = 40;
  String code = "";
  boolean isRight = false;
  
  Node left;
  Node right;
  Node parent;
  
  Node(Node left, Node right){
    frequency = left.frequency + right.frequency;
    this.left = left;
    this.right = right;
    c = String.valueOf(frequency);
  }
  
  Node(char _c, int _frequency){
    c = Character.toString(_c);
    frequency = _frequency;
  }
  
  
  
  void draw(){
    pushMatrix();
    stroke(#1DA722);
    fill(#42F249);
    rect(x, y, 100, 35);
    fill(0);
    text("x: " + c, x-40, y-5);
    text("f: " + frequency, x-40, y+5);
    text("code: " + code, x-40, y+15);
    popMatrix();
  }
  
  boolean isLeaf(){
    if(left == null || right == null){
      return true;
    }
    
    return false;
  }
  
  boolean hasParent(){
    if(parent != null){
      return true;
    }
    
    return false;
  }
  
  boolean right(){
    return isRight;
  }


}
