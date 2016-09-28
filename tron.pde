Player player1, player2;
int borderWidth = 100;
int arenaSize = 400;
boolean gameOver = false;
boolean pause = false;
PFont f;
String winner;
int p1Score,p2Score;

void setup(){
  // create arena
  size(600,600);
  // frameRate 120 is default
  frameRate(120);
  background(0);
  fill(200);
  rect(borderWidth,borderWidth,arenaSize,arenaSize);
  
  // initialise font
  f = createFont("Arial",16,true);
  
  // draw initial score
  fill(200);
  textFont(f,30);
  text("Player 1: " + p1Score,10,30);
  text("Player 2: " + p2Score,arenaSize+30,30);
  
  // create players
  // start in middle
  player1 = new Player("Player 1",borderWidth + (arenaSize / 2) - 20,borderWidth + arenaSize/2,'a',256,0,0, 'w', 's', 'a', 'd');
  player2 = new Player("Player 2",borderWidth + (arenaSize / 2) + 20,borderWidth + arenaSize/2,';',0,0,256,'o', 'l', 'k', ';');
  
  // start at opposite corners
  //player1 = new Player("Player 1",borderWidth + 10,borderWidth + 10,'s',256,0,0, 'w', 's', 'a', 'd');
  //player2 = new Player("Player 2",borderWidth + arenaSize - 10,borderWidth + arenaSize - 10,'o',0,0,256,'o', 'l', 'k', ';');
}

void draw(){
  if(!pause){
    if(gameOver == false){
      // check if player has crashed into itself or gone out of bounds
      // if not, draw the player
      
      if(!player1.getCrash() && !player1.checkCollision(player2)){
        player1.display();
      }else{
        gameOver = true;
        winner = player2.getName();
        p2Score++;
      }
      
      if(!player2.getCrash() && !player2.checkCollision(player1)){
        player2.display();
      }else{
        gameOver = true;
        winner = player1.getName();
        p1Score++;
      }
    }else{
      // game over, update score
      //background(0);
      fill(0);
      rect(0,0,arenaSize+2*borderWidth,borderWidth);
      fill(0,150,0);
      textFont(f,36);
      //text("GAME OVER\n" + winner + " Wins!",arenaSize/2-20,arenaSize/2 + borderWidth-20);
      text("GAME OVER\n" + winner + " Wins!",arenaSize/2-20,40);
      fill(200);
      textFont(f,30);
      text("Player 1: " + p1Score,10,30);
      text("Player 2: " + p2Score,arenaSize+30,30);
    }
  }
  
}

void keyPressed(){
  player1.changeDirection(key);
  player2.changeDirection(key);
  if(key == 'r'){
    background(0);
    fill(200);
    rect(borderWidth,borderWidth,arenaSize,arenaSize);
    textFont(f,30);
    text("Player 1: " + p1Score,10,30);
    text("Player 2: " + p2Score,arenaSize+30,30);
    player1.reset();
    player2.reset();
    gameOver = false;
  }
  if(key == 'p'){
    if(pause == true){
      pause = false;
    }else{
      pause = true;
    }
  }
}