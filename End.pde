class end {

  ////represents win / loss screen at the end of the game and either a potential
  //// "try again" button or simply bringing you back to the front page after several seconds (up to 10-15)
  //// potentially with a "reset" method
  
  void draw(){
    int ms = 0;
    if (ms > 5000) reset();
    else ms +=1;
  }
  //void win(){}
  
  //void loss(){}
  
  void reset(){
    start startScreen = new start();
    startScreen.screen();// call start screen method to return to main screen
  }

}
