final int side = 20;
color[][] grid_colors;  //each array element stores the color of a grid cell
void reset(){
  for (int i=0; i<30; i++)
    for (int j=0; j<30; j++)  //assign each cell with a totoally random color
      grid_colors[i][j] = color((int)random(0, 256), (int)random(0, 256), (int)random(0, 256));
}
void setup(){
  size(600, 600);  //assign the size of the window
  background(255);  //make the background white
  grid_colors = new color[30][30];  //allocate memory for the array
  rectMode(CENTER);  //assign the rectangle mode
  reset();
}
void draw(){
  for (int i=0; i<30; i++){
    for (int j=0; j<30; j++){
      fill(grid_colors[i][j]);  //fill every cell with its color which is stored in the array
      rect(j*side+side/2, i*side+side/2, side, side);
    }
  }
}
void keyPressed(){  //when any key is pressed, reset the color of the grid  
  reset();
}
