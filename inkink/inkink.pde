class Point{
  int x, y;
}
int num;
Point[] circle_centers;
void setup(){
  size(500, 500);
  background(255);
  num = 0; 
  circle_centers = new Point[100];
  initializeArr();
}
void draw(){
  frameRate(60);
  background(255);
  addmousepointer();
  drawCircles();
}
void initializeArr(){
  for (int i=0; i<100; i++) {
    circle_centers[i] = new Point();
    //circle_centers[i].x = mouseX;
    //circle_centers[i].y = mouseY;
  }
}
void addmousepointer(){
  if (num < 100) num++;
  for (int i=100-num; i<100; i++){
    if (i==0) continue;
    circle_centers[i-1].x = circle_centers[i].x;
    circle_centers[i-1].y = circle_centers[i].y;
  } 
  circle_centers[99].x = mouseX;
  circle_centers[99].y = mouseY;
}
void drawCircles(){
  for (int i=100-num; i<100; i++){
    noStroke();
    fill(100-i);
    ellipse(circle_centers[i].x, circle_centers[i].y, i, i);
    print(circle_centers[i].x);
    print(",");
    println(circle_centers[i].y);
  }  
}
