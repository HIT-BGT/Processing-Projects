final int CELL_SIZE = 40;  //the size of every cell
final int ROW_NUM = 15, COL_NUM = 15;  //the number of rows and columns

//get a random color
color getRandomColor() {
  return color((int)random(0, 256), (int)random(0, 256), (int)random(0, 256));  //randomize the color
}
class Cell {
  final int size = CELL_SIZE;    //the size of each cell
  int col_index, row_index;      //the row and col index of the cell 
  boolean hasBall;  //represents whether the cell has a ball in it
  boolean hasSquare;  //represents whether the cell has a ball in it
  Ball ball;  //the ball which belongs to the cell
  Square square;  //the square which belongs to the cell
  //constructor for initialization
  Cell(int _col_index, int _row_index) {
    col_index = _col_index; 
    row_index = _row_index;
    hasBall = hasSquare = false;  //initialize the cell without a ball or square in it
    ball = null;  
    square = null;
  }
  //display the cell and what's in it
  void display() {
    stroke(0);  //the borders of the cell should be black
    noFill();
    rect(col_index*CELL_SIZE+CELL_SIZE/2, row_index*CELL_SIZE+CELL_SIZE/2, CELL_SIZE, CELL_SIZE);
    if (hasBall) ball.display();
    if (hasSquare) square.display();
  }
}
class Ball {
  final int rad = (int)(CELL_SIZE * 0.9 / 2);  //the radius of every ball
  int x, y;                             //center's position of the ball
  color c;                              //color of the ball

  //constructor for initialization
  Ball(int _x, int _y, color _c) {
    x = _x; 
    y = _y; 
    c = _c;
  }
  //display the ball
  void display() {
    noStroke();
    fill(c);
    ellipse(x, y, 2*rad, 2*rad);
  }
  //when the ball is being dragged
  void beingDragged(int x_dis, int y_dis) {
    x = mouseX - x_dis;
    y = mouseY - y_dis;
    this.display();
  }
  //when the ball is released
  boolean isReleased() {
    int col_index = (int)(mouseX/CELL_SIZE);  //which column the mouse is in when released
    int row_index = (int)(mouseY/CELL_SIZE);  //which row the mouse is in when released
    if (col_index >= 0 && col_index <= 14 && row_index >= 1 && row_index <= 13) {
      //if when released, the mouse is in the grid
      x = col_index*CELL_SIZE+CELL_SIZE/2;
      y = row_index*CELL_SIZE+CELL_SIZE/2;
      grid[row_index][col_index].hasSquare = false;  //if there's a square in the cell, replace it
      grid[row_index][col_index].hasBall = true;
      grid[row_index][col_index].ball = this;  
      return true;
    }
    return false;
  }
}
class Square {
  final int side = (int)(CELL_SIZE * 0.8);  //the side of every square
  int x, y;                          //center's position of the square
  color c;                           //the color of the square
  //constructor for initialization
  Square(int _x, int _y, color _c) {
    x = _x; 
    y = _y; 
    c = _c;
  }
  //display the square
  void display() {
    noStroke();
    fill(c);
    rect(x, y, side, side);
  }
  //when the square is being dragged
  void beingDragged(int x_dis, int y_dis) {
    x = mouseX - x_dis;
    y = mouseY - y_dis;
    this.display();
  }
  //when the square is released
  boolean isReleased() {
    int col_index = (int)(mouseX/CELL_SIZE);  //which column the mouse is in when released
    int row_index = (int)(mouseY/CELL_SIZE);  //which row the mouse is in when released
    if (col_index >= 0 && col_index <= 14 && row_index >= 1 && row_index <= 13) {
      //if when released, the mouse is in the grid
      x = col_index*CELL_SIZE+CELL_SIZE/2;
      y = row_index*CELL_SIZE+CELL_SIZE/2;
      grid[row_index][col_index].hasSquare = true;
      grid[row_index][col_index].square = this;  
      grid[row_index][col_index].hasBall = false;  //if there's a ball in the cell, replace it
      return true;
    }
    return false;
  }
}
int x_dis, y_dis;
boolean mouseinball, mouseinsquare;
Cell grid[][];
Ball ball;
Square square;
color rem;
//initialize the grid
void initializeGrid() {
  for (int j=0; j<15; j++) {
    for (int i=0; i<15; i++) {
      grid[i][j] = new Cell(i, j);
      if (i == 0) {  //fill the cells of the first row with random-colored squares 
        rem= getRandomColor();  
        grid[i][j].hasSquare = true;
        grid[i][j].square = new Square(j*CELL_SIZE + CELL_SIZE/2, i*CELL_SIZE + CELL_SIZE/2,rem);
    } else if (i == 14) {  //fill the cells of the last row with random-colored balls 
        grid[i][j].hasBall = true;
        grid[i][j].ball = new Ball(j*CELL_SIZE + CELL_SIZE/2, i*CELL_SIZE + CELL_SIZE/2, rem);
      }
    }
  }
}
void setup() {
  size(COL_NUM*CELL_SIZE, ROW_NUM*CELL_SIZE);  //specify the window size
  background(255);  //make the background white
  rectMode(CENTER);  //specify the align mode of rectangles
  x_dis = y_dis = 0 ; //x_dis and y_dis records the distance between the mouse and the shape center on x direction
  grid = new Cell[ROW_NUM][COL_NUM];  //allocate memory for the grid
  initializeGrid();
  smooth();
}
void draw() {
  background(255);  //refresh the background
  if (mousePressed)
  {
    if (mouseinball) ball.beingDragged(x_dis, y_dis);  //show the ball if it is being dragged
    else if (mouseinsquare) square.beingDragged(x_dis, y_dis);   //show the square if it is being dragged
  }
  for (int i=0; i<15; i++)
    for (int j=0; j<15; j++)
      grid[i][j].display();  //display the grid
}
void mousePressed() {
  int col_index = (int)(mouseX/CELL_SIZE);  //which column the mouse is in when released
  int row_index = (int)(mouseY/CELL_SIZE);  //which row the mouse is in when released
  if (grid[row_index][col_index].hasBall) {
    Ball tempBall = grid[row_index][col_index].ball;
    if (dist(tempBall.x, tempBall.y, mouseX, mouseY) < tempBall.rad){
      ball = new Ball(tempBall.x, tempBall.y, tempBall.c);  //update "ball"
      x_dis = mouseX - ball.x;    //update the distances
      y_dis = mouseY - ball.y;
      mouseinball = true;
    }
  } else if (grid[row_index][col_index].hasSquare) {
    Square tempSquare = grid[row_index][col_index].square;
    if (mouseX>(tempSquare.x-tempSquare.side/2) && mouseX<(tempSquare.x+tempSquare.side/2)
        && mouseY>(tempSquare.y-tempSquare.side/2) && (mouseY<tempSquare.y+tempSquare.side/2)){
      square = new Square(tempSquare.x, tempSquare.y, tempSquare.c);  //update "square"
      x_dis = mouseX - square.x; //update the distance 
      y_dis = mouseY - square.y;
      mouseinsquare = true;
    }
  }
}
void mouseReleased() {
  if (mouseinball) {
    ball.isReleased();  //release the ball
    ball = null;
    mouseinball = false; 
  } else if (mouseinsquare) {
    square.isReleased();  //release the square
    square = null;
    mouseinsquare = false;
  }
}
void keyPressed() {
  if (key == ' ')  //if the pressed key is space, restart to show the grid
    initializeGrid();
    if (mouseinball) mouseinball = false;
    else if (mouseinsquare) mouseinsquare = false;
}

