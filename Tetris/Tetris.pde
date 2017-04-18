//Global Vars:
boolean fillGrid[][] = new boolean[10][20];
boolean loss;
Tetromino tet;
char cmd = 'n';
int dropTimer = 30;
int timerMax = dropTimer;


void setup() {
  for (int i = 0; i<10; i++) { //Probably inegeleant, didn't have access to ref because on flight
    for (int j = 0; j<20; j++) {
      fillGrid[i][j] = false; //Grid is initially empty
    }
  }
  size(200, 400);

  tet = new Line(4); //delete l8r
  loss = false;
}

void draw() {

  background(0);

  if (loss == false) {
    drawGrid();

    if (dropTimer == 0) {
      dropTimer = timerMax;
      tet.drop();
      print("Debug on drop");
    }
    dropTimer--;
    print(dropTimer, "\n");
    tet.update();
    //delay(400);
    if (tet.onFloor()) { //Time to kill and renew our active tetromino, and check for any 'fills' that have occured.
      tet.stamp();
      checkFill();
      //tet = new Line((int)random(7));
      tet = newTet();
    }
  }else{
    background(0);
    textSize(20);
    for(int i = 0; i < 30; i++){
      fill( 255, 0, 0, 100 - (10*i));
      text("You LOSE, Nerd!", 20, 20+(30*i));
      fill( 0, 0, 255, 100 - (10*i));
      text("You LOSE, Nerd!", 20, 380-(30*i));
    }
  }
}

public Tetromino newTet() {
  int blk = (int)random(7)+1;
  switch (blk) {
  case 1: 
    return new Line(4);
  case 2: 
    return new Tee(4);
  case 3: 
    return new BendOne(4);
  case 4: 
    return new BendTwo(4);
  case 5: 
    return new EllOne(4);
  case 6: 
    return new EllTwo(4);
  case 7: 
    return new Cube(4);
  }
  print("Am I an idiot?? I SURE AM!");
  return new Line(-1);
}

public void keyPressed() {
  if (key == CODED && keyCode == LEFT) cmd = 'l';
  if (key == CODED && keyCode == RIGHT) cmd = 'r';
  if (key == CODED && keyCode == UP) cmd = 't';
  if (key == CODED && keyCode == DOWN) dropTimer = 0;
  tet.commands();
  cmd = 'n';
}


public void checkFill() {
  for (int i = 0; i < 20; i++) {
    if (fillGrid[0][i]) { //If the first element of the row is filled 
      if (checkLine(i)) {
        for (int k = i; k > 0; k--) { //'Bubble up' and clear things out 
          for (int j = 0; j < 10; j++) {
            //Clear line at height k
            fillGrid[j][k] = false;
            //Drop line (k-1) into line k
            if (fillGrid[j][k-1] == true) fillGrid[j][k] = true;
          }
        }
      }
    }
  }
  return;
}

public boolean checkLine(int height) {
  for (int i = 0; i<10; i++) {
    if (fillGrid[i][height] == false)
      return false;
  }
  return true;
}

public void drawGrid() { //Draw the background grid
  //stroke(0);
  fill(255, 0, 0);

  for (int i = 0; i < 11; i++) { //Lines
    line(20*i, 0, 20*i, height);
  }
  for (int i = 0; i <21; i++) {
    line(0, 20*i, 200, 20*i);
  }

  for (int i = 0; i < 10; i++) {
    for (int j = 0; j<20; j++) {
      if ( fillGrid[i][j]) {
        rect(20*i, 20*j, 20, 20);
      }
    }
  }
}