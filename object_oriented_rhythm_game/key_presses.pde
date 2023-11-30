void keyPressed(){      // all the button inputs

  if (key == 'd'){
    notesP1.add(new Notes(int(random(1, 4)), 5, 1));    // add more notes artificially
  }
  
  // player one controles
  
  /*if (keyCode == SHIFT){
    player1.button1Down = true;
  }*/
  
  switch(keyCode){
  
    case SHIFT:
      player1.button1Down = true;
      break;
    
  }
  
  switch(key){
    case 'z':
      player1.button2Down = true;
      break;
    case 'x':
      player1.button3Down = true;
      break;
      
      // player two
      
    case 'm':
      player2.button1Down = true;
      break;
    case ',':
      player2.button2Down = true;
      break;
    case '.':
      player2.button3Down = true;
      break;
      
  }
  
  /*if (key == 'z'){
    player1.button2Down = true;
  }
  
  if (key == 'x'){
    player1.button3Down = true;
  }
  
  // player two controls
  
  if (key == 'm'){
    player2.button1Down = true;
  }
  
  if (key == ','){
    player2.button2Down = true;
  }
  
  if (key == '.'){
    player2.button3Down = true;
  }*/
  
  //start game
  
  if (key == ' ' && gameOver == true){
    
    setUpGame("song1.wav");
  
  }
}


void keyReleased(){

  // player one controls
  
  if (keyCode == SHIFT){
    player1.button1Down = false;
  }
  
  switch (key){
  
    case 'z':
      player1.button2Down = false;
      break;
    case 'x':
      player1.button3Down = false;
      break;
      
      // player two
      
    case 'm':
      player2.button1Down = false;
      break;
    case ',':
      player2.button2Down = false;
      break;
    case '.':
      player2.button3Down = false;
      break;
  
  
  }
  
  /*if (key == 'z'){
    player1.button2Down = false;
  }
  
  if (key == 'x'){
    player1.button3Down = false;
  }
  
  // player two controls
  
  if (key == 'm'){
    player2.button1Down = false;
  }
  
  if (key == ','){
    player2.button2Down = false;
  }
  
  if (key == '.'){
    player2.button3Down = false;
  }*/
}
