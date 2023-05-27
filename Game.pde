  import java.util.ArrayList;
  //add variable to keep track of which screen to start on, use start boolean for setyp or use ints
  //IMPORTANT: THE CODE BREAKS WHEN THE MOVE WORKS IN ONLY ONE DIRECTION AND YOU MOVE IN THE WRONG DIRECTION
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
    squares = new square[4][4];
    randomSquare(2);
    randomSquare(2);
    //to test the colors
    
  //  squares = new square[][]
  //{{new square(2),new square(4), new square(8) , new square(32)},
  //{new square(256), null , new square(32) , new square(4096)},
  //{new square(32), new square(128) , new square(16) , new square(64)},
  //{new square(2048) , new square(1024) , new square(32) , new square(512)}};
  //squares = new square[][]
  //{{null,new square(32),new square(32),null},
  //{null, null , new square(32) , null},
  //{null,null,new square(32),null},
  //{null,null,null,null}};
    
    //for(int i = 0; i< squares.length; i++){
    //   for (int z = 0; z< squares[0].length; z++){
    //     if (squares[i][z] != null){
    //     System.out.print(squares[i][z].getValue() + " ");
    //     }
    //     else{
    //       System.out.print("null" + " ");
    //     }
    //   }
    //   System.out.print(System.lineSeparator());
    //}
    //setup the size of the grid and the colorways
  }
  
  void draw(){
    drawSquares();
  }
  
  void drawSquares(){
    //IMPORTANT: THIS ONlY WORKS UP TO 4096 SO FAR
    color[] colorSet = new color[]
    {#d6c9bf, #E2D5BD, #EDE0C8, #f2b179, #f59563, #f67c5f, #f65e3b, #edcf72, #edcc61, #edc850, #edc53f, #edc22e, #776365};
    for (int i = 0; i < squares.length; i++){
      for (int z = 0; z < squares[0].length; z++){
        stroke(#c0ac9c);
        strokeCap(ROUND);
        strokeJoin(ROUND);
        strokeWeight(10);
        if (squares[i][z] != null && squares[i][z].getValue() != 0){
          fill(colorSet[(int)(log(squares[i][z].getValue()) / log(2))] );
          square(150 + z*125, 150 + i*125, 125);
          PFont font;
          font = loadFont("BodoniSvtyTwoITCTT-Bold-48.vlw");
          textFont(font, 40);
          fill(#3B3334);
          String stringValue = str(squares[i][z].getValue());
          text(stringValue,200 + z*125 - 11*(stringValue.length() - 1) ,225 + i*125);
        }
        else {
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
    randomSquare(0);
    
    if(checkLoss()) {
      //end Lose = new end();
      //Lose.loss();
      System.out.println();
      System.out.println("lost the game");
    }
  }
  
  void shiftLeft(){
    for (int i = 0; i < squares.length; i++){
        for(int z = 1; z <= squares[0].length - 1; z++){
            int x = z;
            while(x > 0 && squares[i][x - 1] == null){
              squares[i][x-1] = squares[i][x];
              squares[i][x] = null;
              x--;
            }
        }
      }
  } //<>//
  
  void shiftRight(){
    for (int i = 0; i < squares.length; i++){
        for(int z = squares[0].length - 2; z >= 0; z--){
            int x = z;
            while(x < squares[0].length -1 && squares[i][x + 1] == null){
              squares[i][x+1] = squares[i][x];
              squares[i][x] = null;
              x++;
            }
        }
      }
  } //<>//
  
  void shiftUp(){
    for (int i = 0; i < squares[0].length; i++){
        for(int z = 1; z <= squares.length - 1; z++){
            int x = z;
            while(x > 0 && squares[x-1][i] == null){
              squares[x-1][i] = squares[x][i];
              squares[x][i] = null;
              x--;
            }
        }
      }
  } //<>//
  
  void shiftDown(){
    for (int i = 0; i < squares[0].length; i++){
        for(int z = squares.length - 2; z >= 0; z--){
            int x = z;
            while(x < squares.length - 1 && squares[x+1][i] == null){
              squares[x+1][i] = squares[x][i];
              squares[x][i] = null;
              x++;
            }
        }
      }
  } //<>//
  
  void combineSquares(){
    //we know direction from the class
    if(dir.x == 1){
      for(int i = 0; i < squares.length; i++){
        for(int z = squares[0].length - 2; z >= 0 && squares[i][z] != null; z--){
          if(squares[i][z].isTouchingSame(squares[i][z+1])){
            squares[i][z+1].combine(squares[i][z]);
            squares[i][z] = null;
            shiftRight();
          }
        }
      }
    } //<>//
    else if(dir.x == -1){
      for(int i = 0; i < squares.length; i++){
        for(int z = 1; z < squares[0].length && squares[i][z] != null; z++){
          if(squares[i][z].isTouchingSame(squares[i][z-1])){
            squares[i][z-1].combine(squares[i][z]);
            squares[i][z] = null;
            shiftLeft();
          }
        }
      }
    }
    else if(dir.y == 1){
      for(int i = 0; i < squares[0].length; i++){
        for(int z = squares.length - 2;z >= 0 && squares[z][i] != null; z--){
          if(squares[z][i].isTouchingSame(squares[z+1][i])){
            squares[z+1][i].combine(squares[z][i]);
            squares[z][i] = null;
            shiftDown();
          }
        }
      } 
    } //<>//
    else if(dir.y == -1){
      for(int i = 0; i < squares[0].length; i++){
        for(int z = 1; z < squares.length && squares[z][i] != null; z++){
          if(squares[z][i].isTouchingSame(squares[z-1][i])){
            squares[z-1][i].combine(squares[z][i]);
            squares[z][i] = null;
            shiftUp();
          }
        }
      } 
    }
  } //<>//
  void randomSquare(int givenInt){
    int[] numbers;
    int randomNumber;
    if(givenInt == 0){
      numbers = new int[]{2,2,4};
      randomNumber = numbers[(int)(Math.random()*3)];
    } //<>//
    else randomNumber = givenInt;
    
    //find a random open space on the board
    ArrayList<PVector> openPos = new ArrayList<PVector>();
    for(int i = 0; i < squares.length; i++){
      for(int z = 0; z < squares[0].length; z++){
        if(squares[i][z] == null){
          openPos.add(new PVector(i,z));
        }
      }
    }
    if(openPos.size() != 0){
      PVector randomSpot = openPos.get((int)(Math.random() * openPos.size()));
      squares[(int)randomSpot.x][(int)randomSpot.y] = new square(randomNumber);
    }
  }
  
  boolean checkLoss(){
    boolean notLoss = false; //actually represents loss
    boolean doneChecking = false;
    while(!notLoss && !doneChecking){
      for(int i = 0; i < squares.length; i++){
        for(int z = 0; z < squares[0].length; z++){
          //check all four directions
          if (squares[i][z] != null){
            if( i - 1 >= 0){
              if(squares[i-1][z] != null){
                notLoss = notLoss || squares[i][z].isTouchingSame(squares[i-1][z]);
              }
              else{
                notLoss = true;
              }
            }
            if( i + 1 < squares.length){
              if(squares[i+1][z] != null){
                notLoss = notLoss || squares[i][z].isTouchingSame(squares[i+1][z]);
              }
              else{
                notLoss = true;
              }
            }
            if( z - 1 >= 0){
              if(squares[i][z-1] != null){
                notLoss = notLoss || squares[i][z].isTouchingSame(squares[i][z - 1]);
              }
              else{
                notLoss = true;
              }
            }
            if(z + 1 < squares[0].length){
              if(squares[i][z + 1] != null){
                notLoss = notLoss || squares[i][z].isTouchingSame(squares[i][z + 1]);
              }
              else{
                notLoss = true;
              }
            }
          }
          else{
            notLoss = true;
          }
        }
      }
      doneChecking = true;
    } //<>// //<>//
    return !(notLoss);
  }
  void keyPressed(){
    if(key == CODED){
      if(keyCode == UP){
        dir = new PVector(0, -1);
        postMove();
      } //<>//
      else if(keyCode == DOWN){
        dir = new PVector(0, 1);
        postMove();
      } //<>//
      else if(keyCode == LEFT){
        dir = new PVector(-1, 0);
        postMove();
      } //<>//
      else if(keyCode == RIGHT){
        dir = new PVector(1, 0);
        postMove();
      } //<>//
    }
   }
