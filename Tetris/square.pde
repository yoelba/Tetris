class Square {
  private int xPos;
  private int yPos;
  private boolean isPivot;

  public Square(int x, int y, boolean pivot) {
    this.xPos = x;
    this.yPos = y;
    this.isPivot = pivot;
  }

  public int xPos(){
    return this.xPos;
  }
  
  public int yPos(){
    return this.yPos;
  }
  
  public void setX(int x){
    this.xPos = x;
  }
  
  public void setY(int y){
    this.yPos = y;
  }

  public void drop() {
    this.yPos++;
  }
  
  public void moveLeft(){
    this.xPos--;
  }
  
  public void moveRight(){
    this.xPos++;
  }
  
  public void render() {
    noStroke();
    rectMode(CORNER);
    fill(0, 255, 0);
    rect(20*this.xPos, 20*this.yPos, 20, 20);
  }
  
  public boolean onFloor(){
    if(this.yPos == 19){
      return true;
    }
    print("Square at "+this.xPos+" "+this.yPos+" ");
    if(fillGrid[this.xPos][this.yPos+1]){
      if (this.yPos == 0) loss = true; 
      return true;
    }
    return false;
  }
  
  public void stamp(){
    fillGrid[this.xPos][this.yPos] = true;
  }
  
}