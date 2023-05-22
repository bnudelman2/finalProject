  square[][] squares;
  String[] mode = new String[]{ "regular", "normal"}; //add more modes
  String[] state = new String[]{ "start", "game", "lose"};
  String currentMode;
  String currentState;
  PVector dir; // to keep track of direction to know in which direction to combine squares
  // represents the several possible modes
  
  void setup(){
    background(#f3f0ed);
    size(800, 800);
    //initial 4x4 grid size
    //squares = new int[4][4];
    //squares = new square[4][4];
    //to test the colors
    squares = new square[][]
  {{new square(2),new square(4), new square(8) , new square(32)},
  {new square(256), new square(0) , new square(32) , new square(4096)},
  {new square(32), new square(128) , new square(16) , new square(64)},
  {new square(2048) , new square(1024) , new square(32) , new square(512)}};
    
    
    //setup the size of the grid and the colorways
  }
  
  void draw(){
    drawSquares();
  }
  
  void drawSquares(){
    color[] colorSet = new color[]
    {#d6c9bf, #E2D5BD, #EDE0C8, #f2b179, #f59563, #f67c5f, #f65e3b, #edcf72, #edcc61, #edc850, #edc53f, #edc22e, #776365};
    for (int i = 0; i < squares.length; i++){
      for (int z = 0; z < squares[0].length; z++){
        stroke(#c0ac9c);
        strokeCap(ROUND);
        strokeJoin(ROUND);
        strokeWeight(10);
        if (squares[i][z] != null && squares[i][z].getValue() != 0){
          fill(colorSet[(int)(log(squares[i][z].getValue()) / log(2))] - 1);
          square(150 + z*125, 150 + i*125, 125);
          PFont font;
          font = loadFont("BodoniSvtyTwoITCTT-Bold-48.vlw");
          textFont(font, 40);
          fill(#3B3334);
          String stringValue = str(squares[i][z].getValue());
          text(stringValue,200 + z*125 - 11*(stringValue.length() - 1) ,225 + i*125);
        }
        else if (squares[i][z] != null){
          fill(colorSet[0]);
          square(150 + z*125, 150 + i*125, 125);
        }
      }
    }
  }
  
  void postMove(){
    if(dir.x == 1){
      shiftRight();
    }
    else if(dir.x == -1){
      shiftLeft();
    }
    else if(dir.y == 1){
      shiftDown();
    }
    else if(dir.y == -1){
      shiftUp();
    }
    combineSquares();
  }
  
  void shiftLeft(){
    for (int i = 0; i < squares.length; i++){
        for(int z = 1; z <= squares[0].length - 2; z++){
            int x = z;
            while(x > 0 && squares[i][x - 1] == null){
              squares[i][x-1] = squares[i][x];
              squares[i][x] = null;
              x--;
            }
        }
      }
  }
  
  void shiftRight(){
    for (int i = 0; i < squares.length; i++){
        for(int z = squares[0].length - 2; z >= 0; z--){
            int x = z;
            while(x < squares.length -1 && squares[i][x + 1] == null){
              squares[i][x+1] = squares[i][x];
              squares[i][x] = null;
              x++;
            }
        }
      }
  }
  
  void shiftUp(){
    for (int i = 0; i < squares[0].length; i++){
        for(int z = 1; z <= squares.length - 2; z++){
            int x = z;
            while(x > 0 && squares[x-1][i] == null){
              squares[x-1][i] = squares[x][i];
              squares[x][i] = null;
              x--;
            }
        }
      }
  }
  
  void shiftDown(){
    for (int i = 0; i < squares[0].length; i++){
        for(int z = squares.length - 2; z >= 0; z--){
            int x = z;
            while(x < squares[0].length - 1 && squares[x+1][i] == null){
              squares[x+1][i] = squares[x][i];
              squares[x][i] = null;
              x++;
            }
        }
      }
  }
  
  void combineSquares(){
    //we know direction from the class
    if(dir.x == 1){
      for(int i = 0; i < squares.length; i++){
        for(int z = squares[0].length - 2; squares[i][z] != null && z >= 0; z--){
          if(squares[i][z].isTouchingSame(squares[i][z+1])){
            squares[i][z+1].combine(squares[i][z]);
            squares[i][z] = null;
            shiftRight();
          }
        }
      }
    }
    else if(dir.x == -1){
      for(int i = 0; i < squares.length; i++){
        for(int z = 1; squares[i][z] != null && z < squares[0].length; z++){
          if(squares[i][z].isTouchingSame(squares[i][z-1])){
            squares[i][z-1].combine(squares[i][z]);
            squares[i][z] = null;
            shiftLeft();
          }
        }
      }
      
    }
    else if(dir.y == 1){
      
    }
    else if(dir.y == -1){
      
    }
  }
  void removeSquare(){
    //remove the square from the array
  }
  
  void keyPressed(){
    if(key == CODED){
      if(keyCode == UP){
        dir = new PVector(0, -1);
        postMove();
      }
      else if(keyCode == DOWN){
        dir = new PVector(0, 1);
        postMove();
      }
      else if(keyCode == LEFT){
        dir = new PVector(-1, 0);
        postMove();
      }
      else if(keyCode == RIGHT){
        dir = new PVector(1, 0);
        postMove();
      }
    }
   }
