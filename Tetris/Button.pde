//If there's one thing I dislike about processing, it's having to implement by own buttons.

class Button{
  String text;
  int centerX;
  int centerY;
  int w;
  int h;
  
  Button(String text, int centerX, int centerY, int w, int h){
    this.text = text;
    this.centerX = centerX;
    this.centerY = centerY;
    this.w = w;
    this.h = h;
  }
  
  void render(){
    fill(125);
    strokeWeight(5);
    stroke(0);
    rectMode(CENTER);
    rect(centerX, centerY, w, h, 20, 20, 20, 20);
    textSize(14);
    fill(0);
    text(text, centerX - (float)w/2 + 10, centerY-10);
  }
}