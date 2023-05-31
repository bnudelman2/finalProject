class square{
  private int value = 0;
  public square(int value){
    this.value = value;
  }
  int getValue(){
    return this.value;
  }
  void combine(square second){
    value += second.getValue();
    score += value;
  }
  boolean isTouchingSame(square second){
    return second.getValue() == value;
  }
  
}
