/* Created by Bai Guangtong, 2015/7/8
  1. Draw a window of 500 pixel by 500 pixel with a white background
  2. Once mouse is clicked, a circle with a random diameter and random color is drawn in the window.
     The circle's center is where the mouse is clicked.*/
     
int dia, R_value, G_value, B_value;
void setup(){
  smooth();
  size(500, 500);
  background(255);
}
void draw(){
}
void mouseClicked(){
  dia = (int) random (width/4, width/2);  //produce a random diameter between a quarter and a half of the width of the window
  R_value = (int) random (0, 255);
  G_value = (int) random (0, 255);
  B_value = (int) random (0, 255);
  fill(R_value, G_value, B_value);  //produce a random RGB formed color
  ellipse(mouseX, mouseY, dia, dia);
}
