  int[][] squares;
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
    squares = new int[][]{{2,4,16,32},{256,0,32,64},{32,128,16,64},{2048,1024,32,512}};
    
    
    //setup the size of the grid and the colorways
  }
  
  void draw(){
    drawSquares();
  }
  
  void drawSquares(){
    color[] colorSet = new color[]
    {#C4B8AE, #d6c9bf, #f2b179, #f59563, #f67c5f, #f65e3b, #edcf72, #edcc61, #edc850, #edc53f, #edc22e, #494949, #776365};
    for (int i = 0; i < squares.length; i++){
      for (int z = 0; z < squares[0].length; z++){
        stroke(#c0ac9c);
        strokeCap(ROUND);
        strokeJoin(ROUND);
        strokeWeight(10);
        if (squares[i][z] != 0){
          fill(colorSet[(int)(log(squares[i][z]) / log(2))] - 1);
          square(150 + z*125, 150 + i*125, 125);
          PFont f;
          f = createFont("Arial", 40);
          textFont(f);
          fill(#636363);
          String stringValue = str(squares[i][z]);
          text(stringValue,200 + z*125 - 10*(stringValue.length() - 1) ,225 + i*125);
        }
        else{
          fill(colorSet[0]);
          square(150 + z*125, 150 + i*125, 125);
        }
      }
    }
  }
