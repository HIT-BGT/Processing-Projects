class Ball {
  int rad;    // radius
  int x,y;    // center's position of the ball
  int speedx; // for horizontal speed
  int speedy; // for vertical speed
  color c;    // color of the ball
  
  // constructor for initialization
  Ball() { 
     rad = (int)random(20, 41);  //randomize the radius
     x = (int)random(0+rad, width-rad);  //radomize the x coordinate
     y = (int)random(0+rad, height-rad); //radomize the x coordinate
     c = color((int)random(0, 256), (int)random(0, 256), (int)random(0, 256));  //randomize the color
     speedx = (int)random(-5, 6);  //random the speed on x direction
     speedy = (int)random(-5, 6);  //random the speed on y direction
  }
 
  // display a ball with the given x, y and rad, filled with c
  void display() { 
    fill(c);    //fill the circle with the random color
    noStroke();
    ellipse(x, y, rad*2, rad*2);
  }
  
  // set the new position according to speedx and speedy 
  // and check if a bounce happens
  void moveBall() { 
    // write some code
    x += speedx;  
    y += speedy;
    if ((x <= rad) || (x >= width-rad)){  //if the ball reach the left of right border of the window
      speedx = -speedx;
    }
    if ((y <= rad) || (y >= height-rad)){ //if the ball reach the up of down border of the window
      speedy = -speedy;
    }
  }
  // dispaly a ball and let it move
  void play() { 
    display();
    moveBall();
  }
  
  // check if collision happens
  // returns true two balls collide; otherwise returns false
  boolean collideWith(Ball other) {  
    float gap = dist(x, y, other.x, other.y);
    if (gap <= rad + other.rad)
      return true;
    else
      return false;
  }
}
// don't change anything below
Ball b1, b2;

void setup() {
  size(400, 400);
  b1 = new Ball();
  b2 = new Ball();
  smooth();
}

void draw() {
  background(255);
 
  if (b1.collideWith(b2)) {
    b1.display();
    b2.display();
  }
  else {
    b1.play();
    b2.play();
  }
}

