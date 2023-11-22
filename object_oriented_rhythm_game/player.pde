/*    Player buttons class
  
  Constructor
    Is this player one or two?
      Set up the player accordingly
    
  Input
    Check which of the 3 inputs the player has done, then check the distance from the notes in that column, and update accordingly

  Display
    Draw the buttons    */
    
class Player{
  
  int whichPlayer;
  
  char button1;
  boolean button1Down = false;
  
  char button2;
  boolean button2Down = false;
  
  char button3;
  boolean button3Down = false;
  
  float score;

  Player(int wp){
    
    whichPlayer = wp;
    
    if (whichPlayer == 1){
      button1 = 'z';
      button2 = 'x';
      button3 = 'c';
    }
  
      
  }
  
  void collision(int c){
  
    
  
  }
  
  void display(){
  
    if (whichPlayer == 1){
      
      
      //rect(40, 800, 160, 80);
      //for(int i = 0; i < 600; i += 200){
      
      if (button1Down == true){ 
          fill(0, 0, 0, 150);
        } else {
          fill(0, 0, 0, 100);
        }  
      rect(40, 800, 160, 80);
      
      if (button2Down == true){ 
          fill(0, 0, 0, 150);
        } else {
          fill(0, 0, 0, 100);
        }  
      rect(240, 800, 160, 80);
      
       if (button3Down == true){ 
          fill(0, 0, 0, 150);
        } else {
          fill(0, 0, 0, 100);
        }  
      rect(440, 800, 160, 80);
        
    }  
  }


}