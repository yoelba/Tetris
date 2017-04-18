abstract class Tetromino {
  /*A tetromino will consists of a series of 4 squares - one will be an 'anchor' about which the others shall pivot. 
   A check can be performed on the tetromino's component squares as part of the main loop, to see if any of them have yet 'landed' on an occupied space.
   If so, the tetromino shall be deleted and it's finalize function will be overwritten to 'color in' all grid spaces where it was. Via this method
   I think everything will work out super, and I get to overwrite finalize, which is a unqiue opportunity :)
   */
  Square[] squares = new Square[4];

  public void update() {
    this.render();
    this.commands();
    //this.drop();
  }
  
  public void commands(){
    if (cmd == 'n') return;
    if ( (cmd == 'l') && (this.checkBounds() != 'l' ) && (this.checkBounds() != 'g' ))for (Square s: this.squares) s.moveLeft();
    if ( (cmd == 'r') && (this.checkBounds() != 'r' ) && (this.checkBounds() != 'g' ))for (Square s: this.squares) s.moveRight();
    if (cmd == 't'){
       if(this.checkRotation() == true) this.rotate(); 
    }

  }

  public char checkBounds(){ //l prohibits left, r prohibits right, g prohibits movement in both directions.
    for(Square s : this.squares){ 
      if( (s.xPos == 0) ) return 'l';
      if( (s.xPos == 9) ) return 'r';
      if( fillGrid[s.xPos + 1][s.yPos] ) return 'r';
      if( fillGrid[s.xPos - 1][s.yPos] ) return 'l';
    }
    return 'o';
  }
  
  private void render() {
    for (Square s : this.squares) {
      s.render();
    }
  }


  //THIS DONESN'T WORK GOOD YET
  public boolean checkRotation(){ //Candidate for optimization -- merge with rotate() probably!
    for(Square s:this.squares){
      int temp = s.xPos();
      int newX = (-1 * (s.yPos() - this.getPivot().yPos() )) + this.getPivot().xPos();
      int newY = ((temp - this.getPivot().xPos() )) + this.getPivot().yPos(); 
      if(newX < 0 || newX > 9 || newY < 0 || newY > 19) return false;
      if(fillGrid[newX][newY]) return false;
    }
    return true;
  }

  private void rotate(){
     for (Square s : this.squares) {
       int temp = s.xPos();
       int newX = -1 * (s.yPos() - this.getPivot().yPos() );
       int newY = (temp - this.getPivot().xPos() );
       s.setX(newX + this.getPivot().xPos() );
       s.setY(newY + this.getPivot().yPos() );
     }
  }

  private void drop() {
    for (Square s : this.squares) {
      s.drop();
    }
  }

  public boolean onFloor() {
    for (Square s : this.squares) {
      if (s.onFloor()) {
        return true;
      }
    }
    return false;
  }
  
  public void stamp(){
    for (Square s : this.squares) {
      s.stamp();
    }
  }
  
  public Square getPivot(){ //Returns the square which is our tetromino's pivot.
    for(Square s:this.squares){
      if(s.isPivot) return s;
    }
    return new Square(-1,-1,true); //This should never happen, so might as well crash the program with an arrayOutOfBoundsException should it occur.
  }
  
}


/*
  [0][1][2][3]
*/
class Line extends Tetromino { //The classic and beloved line piece
  public Line(int dropX) {
    super.squares[0] = new Square(dropX, 0, false);
    super.squares[1] = new Square(dropX+1, 0, true);
    super.squares[2] = new Square(dropX+2, 0, false);
    super.squares[3] = new Square(dropX+3, 0, false);
  }
}

/*
  [0][1][2]
     [3]
*/
class Tee extends Tetromino{
  public Tee(int dropX){
    super.squares[0] = new Square(dropX, 0, false);
    super.squares[1] = new Square(dropX+1, 0, true);
    super.squares[2] = new Square(dropX+2, 0, false);
    super.squares[3] = new Square(dropX+1, 1, false);
  }
}

/*
  [2][3]
  [0][1]  
*/
class Cube extends Tetromino{
  public Cube(int dropX){
    super.squares[0] = new Square(dropX, 1, false);
    super.squares[1] = new Square(dropX+1, 1, false);
    super.squares[2] = new Square(dropX, 0, true);
    super.squares[3] = new Square(dropX+1, 0, false);
  }
}

/*
     [2][3]
  [0][1]
*/
class BendOne extends Tetromino{
  public BendOne(int dropX){
    super.squares[0] = new Square(dropX, 1, false);
    super.squares[1] = new Square(dropX+1, 1, false);
    super.squares[2] = new Square(dropX+1, 0, true);
    super.squares[3] = new Square(dropX+2, 0, false);
  }
}

/*
  [2][3]
     [0][1]
*/
class BendTwo extends Tetromino{
  public BendTwo(int dropX){
    super.squares[0] = new Square(dropX+1, 1, false);
    super.squares[1] = new Square(dropX+2, 1, false);
    super.squares[2] = new Square(dropX, 0, false);
    super.squares[3] = new Square(dropX+1, 0, true);
  }
}

/*
  [0][1][2]
        [3]
*/
class EllOne extends Tetromino{
  public EllOne(int dropX){
    super.squares[0] = new Square(dropX, 0, false);
    super.squares[1] = new Square(dropX+1, 0, true);
    super.squares[2] = new Square(dropX+2, 0, false);
    super.squares[3] = new Square(dropX+2, 1, false);
  }
}

/*
  [0][1][2]
  [3]
*/
class EllTwo extends Tetromino{
  public EllTwo(int dropX){
    super.squares[0] = new Square(dropX, 0, false);
    super.squares[1] = new Square(dropX+1, 0, true);
    super.squares[2] = new Square(dropX+2, 0, false);
    super.squares[3] = new Square(dropX, 1, false);
  }
}