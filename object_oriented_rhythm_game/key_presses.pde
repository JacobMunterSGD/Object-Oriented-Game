void keyPressed(){      // all the button inputs

  if (key == 'd'){
    notesP1.add(new Notes(int(random(1, 4)), 5, 1));    // add more notes artificially
  }
  
  // player one controls
  
  /*if (keyCode == SHIFT){
    player1.button1Down = true;
  }*/
  
  switch(keyCode){    // if the button is down, the corresponding button down variable is set to true
  
    case SHIFT:
      player1.button1Down = true;
      break;
    
  }
  
  switch(key){
    case 'z':
    case 'Z':
      player1.button2Down = true;
      break;
     
    case 'x':
    case 'X':
      player1.button3Down = true;
      break;
      
      // player two
      
    case 'm':
    case 'M':
    case 'w':
    case 'W':
      player2.button1Down = true;
      break;
      
    case ',':
    case '<':
    case 'e':
    case 'E':
      player2.button2Down = true;
      break;
      
    case '.':
    case '>':
    case '[':
    case '{':
      player2.button3Down = true;
      break;
      
  }
  
  //start game
  
  if (((key == ' ') || (key == '1')) && gameOver == true){    // starts the game when either of these buttons are pressed, and game over is true
    
    setUpGame("song1.wav");
  
  }
}

void keyReleased(){    // if the button is not down, the corresponding button is set to false

  // player one controls
  
  switch(keyCode){
  
    case SHIFT:
      player1.button1Down = false;
      break;
    case ALT:
      player1.button2Down = false;
      break;
  }
  
  
  switch (key){
  
    case 'z':
    case 'Z':
      player1.button2Down = false;
      break;
      
    case 'x':
    case 'X':
      player1.button3Down = false;
      break;
      
      // player two
      
    case 'm':
    case 'M':
    case 'w':
    case 'W':
      player2.button1Down = false;
      break;
      
    case ',':
    case '<':
    case 'e':
    case 'E':
      player2.button2Down = false;
      break;
      
    case '.':
    case '>':
    case '[':
    case '{':
      player2.button3Down = false;
      break;
  }
}
