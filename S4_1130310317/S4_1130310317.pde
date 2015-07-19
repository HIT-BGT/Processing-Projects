class Ball{
  final int rad = 50;  //a fixed radius of 50 px
  int x, y;            //center's position of the ball
  color c;             //color of the ball
  
  //constructor for initialization
  Ball(){
    x = y = width/4;
    c = this.getRandomColor();
  }
  //display the ball
  void display(){
    noStroke();
    fill(c);
    ellipse(x, y, 2*rad, 2*rad);
  }
  //get a random color
  color getRandomColor(){
    return color((int)random(0, 256), (int)random(0, 256), (int)random(0, 256));  //randomize the color
   }
  //when the ball is being dragged
  void beingDragged(int x_dis, int y_dis){
    x = mouseX - x_dis;
    y = mouseY - y_dis;
    //this.display();
  }
  //when the ball is released
  void isReleased(int original_x, int original_y){
      if (mouseY > 0 && mouseY < height/2){  //if when released, the mouse is in the first two quadrants
        if (mouseX > width/2 && mouseX < width){  //if when released, the mouse is in the 1st quadrant
          x = width/4 * 3;
          y = height/4;
        }else if(mouseX > 0 && mouseX < width/2){  //if when released, the mouse is in the 2nd quadrant
          x = width/4;  
          y = height/4;
        }else{
          x = original_x; y = original_y;
        }
      }else if(mouseY > height/2 && mouseY < height){
        if(mouseX > 0 && mouseX < width/2){  //if when released, the mouse is in the 3rd quadrant
          x = width/4;
          y = height/4 * 3;
        }else if(mouseX > width/2 && mouseX < width){  //if when released, the mouse is in the 4th quadrant
          x = width/4 * 3;
          y = height/4 * 3;
        }else{
          x = original_x; y = original_y;
        }
      }else{
        x = original_x; y = original_y; 
      }
      c = this.getRandomColor();
      //this.display();
    }
}
Ball ball;
int x_dis, y_dis;
int original_x, original_y;
boolean mouseinball;
void setup(){
  size(400, 400);  //draw a square window of 400px wide and 400 px high
  background(255);  //with a white background
  ball = new Ball();  //instantiate an instance of class "Ball"
  x_dis = y_dis = 0;  //x_dis and y_dis records the distance between the mouse and the ball center on x direction
                      //and y direction respectively
  original_x = original_y = 0;  //original_x and original_y records the original coordinates of ball center
  mouseinball = false;  //represents whether the mouse pointer in inside the ball or not
  smooth();
}
void draw(){
  background(255);  //clear the screen
  stroke(0);  //the lines should be black
  line(0, height/2, width, height/2);  //draw a horizontal line
  line(width/2, 0, width/2, height);  //draw a 
  if (mousePressed && mouseinball) ball.beingDragged(x_dis, y_dis);
  ball.display();
}
void mousePressed(){
  if (dist(ball.x, ball.y, mouseX, mouseY) < ball.rad){
    original_x = ball.x;  //records the original position of ball center
    original_y = ball.y;
    x_dis = mouseX - original_x;  //update x_dis and y_dis  
    y_dis = mouseY - original_y;
    mouseinball = true;  //update mouseinball
  }  
}
void mouseReleased(){
  if (mouseinball) ball.isReleased(original_x, original_y);
  mouseinball = false;
}
