color[]rainbow_colors = {#ff0000, #ff7f00, #ffff00, #00ff00, #00ffff, #0000ff, #8b00ff}; //rainbow colors
int diameter, left;  //diameter controls the diameter of rainbow circles, left stores the left border of bus
int bus_width = 40, bus_height = 15, wheel_diameter = 7;  
void setup(){
  size(600, 600);  //a 600 pixel by 600 pixel window
  background(255);
  left = width;  //initialize left with width, so that the bus is on the right side of the window
}
void draw(){
  background(255);  //refresh the background
  draw_Rainbow(); 
  draw_Bus(left);
  left--;          //left border shift right every time when draw() is called
  if(left < -bus_width)
    left = width;  //when the bus disappears from the window, make it restart from the right side
}
void draw_Rainbow(){
  diameter = width;//the biggest circle has a diameter of width
  strokeWeight(20);
  for (int i=0; i<7; i++){
    stroke(rainbow_colors[i]);  //set the stroke's color according to i
    ellipse(width, height, 2*(diameter-20*i), 2*(diameter-20*i));  //adapt the diameter of the rainbow circle
  }
}
void draw_Bus(int left){
  strokeWeight(0);  //get rid of stroke
  fill(0);  //fill the bus with black color
  rect(left, height - bus_height - wheel_diameter/2, bus_width, bus_height);  //draw the body of the bus
  ellipse(left + bus_width/4, height - wheel_diameter/2, wheel_diameter, wheel_diameter);  //draw a wheel
  ellipse(left + 3*bus_width/4, height - wheel_diameter/2, wheel_diameter, wheel_diameter);//draw the other wheel
  noFill();  //to avoid fill the innermost rainbow circle with black color
}
