  import java.util.ArrayList;  //<>//
  import processing.sound.*;
  square[][] squares;
  String[] mode = new String[]{ "regular", "normal"}; //add more modes
  String[] state = new String[]{ "start", "game", "lose"};
  String currentMode;
  String currentState = state[0];
  SoundFile file;
  PVector dir; // to keep track of direction to know in which direction to combine squares
  public int score = 0;
  //represents the several possible modes
  //PUT START AND END IN SEPARATE CLASSES and make non-draw methods that invoke a draw function like rect
  //ADD A RULES PAGE IN THE START MENU AS WELL
  //IMPLEMENT TIMED MODE WHERE YOU HAVE A CERTAIN TIME TO REACH A CERTAIN SCwORE AND ALSO IMPLEMENT A LEVEL PAGE TO CHOOSE THOSE TIMES OR A TIME CHOOSING OPTION
  //add a reset method for when "try again" is clicked
  void setup(){
    size(800, 800);
    file = new SoundFile(this, "intro.mp3");
    file.loop();
    //file.playFor(100.0);
    //initial 4x4 grid size
    squares = new square[4][4];
    randomSquare(2);
    randomSquare(2);
  }
  
  void draw(){
    if(currentState.equals("start")){
      drawStartScreen();
    }
    else if(currentState.equals("game")){
      background(#f3f0ed);
      drawSquares();
      System.out.println(score);
    }
    else if(currentState.equals("lose")){
      drawEndScreen();
    }
    //if(isLoop){
    //  System.out.print("noloop");
    //}
  }
  
  void drawStartScreen(){
    PImage bkg = loadImage("background.jpeg");
    background(bkg);
    String[] numbers = new String[]{"4", "0", "9", "6"};
    color[] colors = new color[]{#25FF2A, #25FFF5, #FF5F1F, #9D00FF};
    PFont font;
    font = loadFont("Skia-Regular_Bold-48.vlw");
    for(int i = 0; i < 4; i++){
      stroke(#3B3334);
      strokeCap(ROUND);
      strokeJoin(ROUND);
      strokeWeight(10);
      fill(colors[i]);
      square(170+120*i,100,100);
      textFont(font, 90);
      fill(255,255,255);
      text(numbers[i], 192 + 120*i , 175);
    }
    stroke(#FFFF33);
    strokeCap(ROUND);
    strokeJoin(ROUND);
    strokeWeight(20);
    fill(#FFFF33);
    rect(275,575,250,75);
    textFont(font,75);
    fill(0,0,0);
    text("START", 282, 638);
  }
  void drawEndScreen(){
    //ADD A "YOUR SCORE: X" at the top
    //ADD a loss noise
    //CHANGE BACKGROUND IMAGE
    PImage bkg = loadImage("gameOver.jpeg");
    background(bkg);
    PFont font;
    font = loadFont("Skia-Regular_Bold-48.vlw");
    stroke(#FFFF33);
    strokeCap(ROUND);
    strokeJoin(ROUND);
    strokeWeight(20);
    fill(#FFFF33);
    rect(225,650,350,75);
    textFont(font,75);
    fill(0,0,0);
    text("Try Again", 230, 713);
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
      currentState = "lose";
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
  }
  
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
  }
  
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
  }
  
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
  }
  
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
    }
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
    }
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
  }
  void randomSquare(int givenInt){
    int[] numbers;
    int randomNumber;
    if(givenInt == 0){
      numbers = new int[]{2,2,4,2};
      randomNumber = numbers[(int)(Math.random()*4)];
    }
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
    }
    return !(notLoss);
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
   
   void mouseClicked(){
     if(currentState.equals("start") && ((mouseX >= 275 && mouseX <= 525) && (mouseY >= 575 && mouseY <= 650))){
       currentState = "game";
       file.stop();
     }
     if(currentState.equals("lose") && ((mouseX >= 275 && mouseX <= 525) && (mouseY >= 650 && mouseY <= 725))){
       currentState = "start";
       file.play();
     }
     //add more for when other modes are in play if needed, as needed
   }
