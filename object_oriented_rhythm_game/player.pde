class Player{
  
  int whichPlayer;
  
  //char button1;
  boolean button1Down = false;
  float button1Cooldown = 30;
  
  //char button2;
  boolean button2Down = false;
  float button2Cooldown = 30;
  
  //char button3;
  boolean button3Down = false;
  float button3Cooldown = 30;
  
  float score;

  Player(){   // if a player object is created without passing an argument, the player is just set to 1
  
    whichPlayer = 1;
  
  }
  
  Player(int wp){
    
    whichPlayer = wp;     // we only really need to know which player we're talking about
   
  }
  
  void display(){
  
    if (whichPlayer == 1){
      
      
      //rect(40, 800, 160, 80);
      //for(int i = 0; i < 600; i += 200){
      

      fill(0, 0, 0,  player1.button1Cooldown * 5);
      image(playerButtonP1, 40, 800, 160, 80);
      rect(40, 800, 160, 80);

      fill(0, 0, 0, player1.button2Cooldown * 5);
      image(playerButtonP1, 240, 800, 160, 80);
      rect(240, 800, 160, 80);
      
      fill(0, 0, 0, player1.button3Cooldown * 5);
      image(playerButtonP1, 440, 800, 160, 80);  
      rect(440, 800, 160, 80);
        
    }  
    
   if (whichPlayer == 2){
      
      fill(0, 0, 0,  player2.button1Cooldown * 5);
      image(playerButtonP2, 680, 800, 160, 80);
      rect(680, 800, 160, 80);

      fill(0, 0, 0, player2.button2Cooldown * 5);
      image(playerButtonP2, 880, 800, 160, 80);
      rect(880, 800, 160, 80);
      
      fill(0, 0, 0, player2.button3Cooldown * 5);
      image(playerButtonP2, 1080, 800, 160, 80);  
      rect(1080, 800, 160, 80); 
     
     /*
      if (button1Down == true){ 
          fill(0, 0, 0,  100 + player2.button1Cooldown * 5);
        } else {
          fill(0, 0, 0,  100 + player2.button1Cooldown);
        }  
      rect(680, 800, 160, 80);
      
      if (button2Down == true){ 
          fill(0, 0, 0, 100 + player2.button2Cooldown * 5);
        } else {
          fill(0, 0, 0, 100 + player2.button2Cooldown);
        }  
      rect(880, 800, 160, 80);
      
       if (button3Down == true){ 
          fill(0, 0, 0, 100 + player2.button3Cooldown * 5);
        } else {
          fill(0, 0, 0, 100 + player2.button3Cooldown);
        }  
      rect(1080, 800, 160, 80);*/
        
    }  
  }
}
