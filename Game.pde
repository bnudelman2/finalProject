  import java.util.ArrayList;  //<>//
  import processing.sound.*;
  square[][] squares;
  String[] state = new String[]{ "start", "settings", "game", "lose"};
  String currentState = state[0];
  SoundFile file;
  PVector dir; // to keep track of direction to know in which direction to combine squares
  public int score = 0;
  int bestScore = 0;
  int startTime = 0;
  int currentBarrierTime = 1000;
  int currentTime = 0;
  int lossTime = 0;
  color[] norm = new color[]{#d6c9bf, #E2D5BD, #EDE0C8, #f2b179, #f59563, #f67c5f, #f65e3b, #edcf72, #edcc61, #edc850, #edc53f, #edc22e, #776365};
  color[] colorSet = new color[]{#d6c9bf, #E2D5BD, #EDE0C8, #f2b179, #f59563, #f67c5f, #f65e3b, #edcf72, #edcc61, #edc850, #edc53f, #edc22e, #776365};
  color[] blueSet = new color[]{#d6c9bf, #e4f0f6, #bcd9ea, #8bbdd9, #5ba4cf, #298fca, #0079bf, #026aa7, #055a8c, #094c72, #0c3953, #5F9EA0, #088F8F};
  color[] pinkSet = new color[]{#d6c9bf, #fef2f9, #fcdef0, #fac6e5, #ffb0e1, #ff95d6, #ff80ce, #FF00FF, #FF00FF, #e76eb1, #cd5a91, #b44772, #96304c};
  
  void setup(){
    size(800, 800);
    file = new SoundFile(this, "intro.mp3");
    file.loop();
    squares = new square[4][4];
    randomSquare(2);
    randomSquare(2);
  }
  
  void draw(){
    if(currentState.equals("start")){
      drawStartScreen();
    }
    if(currentState.equals("settings")){
      drawSettingsScreen();
    }
    else if(currentState.equals("game")){
      background(#f3f0ed);
      drawSquares();
      drawScore();
      drawTime();
    }
    else if(currentState.equals("lose")){
      drawEndScreen();
    }
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
    PImage settingsIcon = loadImage("settings.png");
    fill(255,255,255);
    strokeWeight(10);
    stroke(0,0,0);
    rect(700,25,75,75);
    image(settingsIcon, 700, 25, 75, 75);
  }
  
  void drawEndScreen(){
    PImage bkg = loadImage("gameOver.jpeg");
    background(bkg);
    fill(#FFFF33);
    rect(615, 30, 150, 45);
    rect(143, 30, 150, 45);
    rect(400, 100, 150, 45);
    PFont font1;
    font1 = loadFont("Skia-Regular_Bold-48.vlw");
    textFont(font1, 40);
    text("SCORE", 475, 65);
    text("BEST", 30, 65);
    text("TIME", 283, 135);
    font1 = loadFont("BodoniSvtyTwoITCTT-Bold-48.vlw");
    fill(#3B3334);
    text(score, 678 - 11.5 * (int)(log(score) / log(10)), 61);
    if(score > bestScore){
      text(score, 206 - 11.5 * (int)(log(score) / log(10)), 61);
    }
    else{
      text(bestScore, 206 - 11.5 * (int)(log(bestScore) / log(10)), 61);
    }
    text(lossTime, 466 - 11.5 * (int)(log(lossTime) / log(10)), 131);
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
  
  void drawSettingsScreen(){
    background(#f3f0ed);
    PFont font = loadFont("Skia-Regular_Bold-48.vlw");
    textFont(font,75);
    fill(0,0,0);
    text("Help", 310, 75);
    PImage rule1 = loadImage("rule1.png");
    image(rule1, 30, 125, 150, 150);
    PFont font1 = loadFont("BanglaMN-48.vlw");
    textFont(font1, 25);
    text("Use the arrow keys to move all the squares\non the board in a specific direction. It is\npossible for some squares to move and\nothers to have no spaces to move to.", 205, 150);
    PImage rule2 = loadImage("rule2.png");
    image(rule2, 30, 305, 150, 150);
    text("Your objective is to combine like squares\nto get the highest number possible, all the\nwhile increasing your points in the smallest\ntime possible.", 205, 330);
    textFont(font1, 25);
    text("C\nO\nL\nO\nR\nW\nA\nY", 30, 515);
    PImage pink = loadImage("pinkPalette.png");
    PImage blue = loadImage("bluePalette.png");
    strokeWeight(2);
    rect(300, 500, 450, 100);
    image(pink, 300, 500, 450, 100);
    rect(300, 650, 450, 100);
    image(blue, 300, 650, 450, 100);
    fill(#ffffe4);
    stroke(#ffffe4);
    strokeCap(ROUND);
    strokeJoin(ROUND);
    strokeWeight(15);
    rect(125,530,100,50);
    rect(125,680,100,50);
    rect(25,25,175,50);
    fill(#FF0000);
    stroke(#FF0000);
    rect(690, 25, 80, 80);
    textFont(font, 25);
    fill(0,0,0);
    text("Pink", 148, 565);
    text("Blue", 148, 715);
    textFont(font, 35);
    text("GO BACK", 35, 63);
    textFont(font, 25);
    text("RESET", 693, 75);
  }
  
  void drawSquares(){
    //IMPORTANT: THIS ONlY WORKS UP TO 4096
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
  
  void drawScore(){
    fill(#d6c9bf);
    rect(615, 30, 150, 45);
    PFont font;
    font = loadFont("Skia-Regular_Bold-48.vlw");
    textFont(font, 40);
    text("SCORE", 475, 65);
    font = loadFont("BodoniSvtyTwoITCTT-Bold-48.vlw");
    fill(#3B3334);
    if(score == 0){
      text(score, 678, 61);
    }
    else{
      text(score, 678 - 11.5 * (int)(log(score) / log(10)), 61);
    }
    
    fill(#d6c9bf);
    rect(143, 30, 150, 45);
    font = loadFont("Skia-Regular_Bold-48.vlw");
    textFont(font, 40);
    text("BEST", 30, 65);
    font = loadFont("BodoniSvtyTwoITCTT-Bold-48.vlw");
    fill(#3B3334);
    if(bestScore == 0){
      text(bestScore, 206, 61);
    }
    else{
      text(bestScore, 206 - 11.5 * (int)(log(bestScore) / log(10)), 61);
    }
  }
  
  void drawTime(){
    int time = millis() - startTime;
    fill(#d6c9bf);
    rect(385, 675, 200, 75);
    fill(#3B3334);
    PFont font;
    font = loadFont("Skia-Regular_Bold-48.vlw");
    textFont(font, 60);
    text("TIME", 220, 730);
    font = loadFont("BodoniSvtyTwoITCTT-Bold-48.vlw");
    fill(#3B3334);
    if (time > currentBarrierTime){
      currentTime = currentBarrierTime / 1000;
      currentBarrierTime += 1000;
    }
    if(currentBarrierTime == 1000){
      text("0", 465, 730);
    }
    else{
      text(currentTime, 465 - 11.5 * (int)(log(currentTime) / log(10)), 730);
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
      lossTime = currentTime;
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
  
  void reset(){
    if(score > bestScore){
      bestScore = score;
    }
    score = 0;
    currentBarrierTime = 1000;
    squares = new square[4][4];
    randomSquare(2);
    randomSquare(2);
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
       startTime = millis();
     }
     if(currentState.equals("start") && ((mouseX >= 700 && mouseX <= 775) && (mouseY >= 25 && mouseY <= 100))){
       currentState = "settings";
       file.stop();
     }
     if(currentState.equals("settings") && ((mouseX >= 25 && mouseX <= 200) && (mouseY >= 25 && mouseY <= 75))){
       currentState = "start";
       file.play();
     }
     if(currentState.equals("settings") && ((mouseX >= 690 && mouseX <= 770) && (mouseY >= 25 && mouseY <= 105))){
       colorSet = norm;
     }
     if(currentState.equals("settings") && ((mouseX >= 125 && mouseX <= 225) && (mouseY >= 530 && mouseY <= 580))){
       colorSet = pinkSet;
     }
     if(currentState.equals("settings") && ((mouseX >= 125 && mouseX <= 225) && (mouseY >= 680 && mouseY <= 730))){
       colorSet = blueSet;
     }
     if(currentState.equals("lose") && ((mouseX >= 275 && mouseX <= 525) && (mouseY >= 650 && mouseY <= 725))){
       reset();
       currentState = "start";
       file.play();
     }
   }
