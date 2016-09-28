class Player {
  
  int curX, curY, initX, initY;
  char up, down, left, right;
  char direction, initDirection;
  boolean crash;
  int trail[][];
  color playerColor;
  String name;
  
  Player(String name, int startX, int startY, char direction, int r, int g, int b, char up, char down, char left, char right) {
    // set starting orientation
    curX = initX = startX;
    curY = initY = startY;
    this.direction = initDirection = direction;
    
    // define player keys
    this.up = up;
    this.down = down;
    this.left = left;
    this.right = right;
    
    // array which stores the players trail, intialised to 0
    trail = new int[arenaSize][arenaSize];
    resetTrail();
    
    playerColor = color(r,g,b);
    crash = false;
    this.name = name;
  }
  
  // getters
  
  public String getName(){
    return name;
  }
  
  public int getX(){
    return curX;
  }
  
  public int getY(){
    return curY;
  }
  
  public boolean getCrash(){
    return crash;
  }
  
  public int getTrail(int x, int y){
    return trail[x-borderWidth][y-borderWidth];
  }
  
  void resetTrail(){
    for(int i=0;i<arenaSize;i++){
      for(int j=0;j<arenaSize;j++){
        trail[i][j] = 0;
      }
    }
  }
  
  void reset(){
    curX = initX;
    curY = initY;
    direction = initDirection;
    resetTrail();
  }
  
  // draw the player
  public void display(){
    update();
    fill(playerColor);
    noStroke();
    rect(curX,curY,1,1); 
  }
  
  // check for collision with arena, self and other player
  boolean checkCollision(Player other){
    if(curX-borderWidth == 0 || curX-borderWidth == arenaSize || curY-borderWidth == 0 || curY-borderWidth == arenaSize){
      return true;
    }
    if(trail[curX-borderWidth][curY-borderWidth] == 1){
      return true;
    }
    if(other.getTrail(curX,curY) == 1){
      return true;
    }
      return false;
  }
  
  void update(){
    // print current coordinates relative to arena
    //println((curX-borderWidth) + "," + (curY-borderWidth));
    
    // update the players heading and trail
    trail[curX-borderWidth][curY-borderWidth] = 1;
    if(direction == up){
      curY--;
    }else if(direction == down){
      curY++;
    }else if(direction == left){
      curX--;
    }else if(direction == right){
      curX++;
    }
  }
  
  void collide(){
    crash = true;
  }
  
  // this is called when a key is pressed, it changes the current direction
  // of the  player, but does not update the player
  public void changeDirection(char input){
    // check for valid input
    if(input == up || input == down || input == left || input == right) {
      // check it's no a repeated input
      if(input != direction){
        if(input == up && direction != down){
          this.direction = input;
        }else if(input == down && direction != up){
          this.direction = input;
        }else if(input == left && direction != right){
          this.direction = input;
        }else if(input == right && direction != left){
          this.direction =input;
        }
      }
    }
  }
  
  
}
