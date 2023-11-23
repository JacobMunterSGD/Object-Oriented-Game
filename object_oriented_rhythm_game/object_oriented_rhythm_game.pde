boolean gameOver; // this will become false when the game starts
//An array for the notes for each player
//Score for each player - this will be stored in the player object class

import processing.sound.*;
SoundFile file;    // the sound file
Amplitude amp;     // how the sound file is analyzed
AudioIn in;        // what audio is going into the amplitude

float loudness;    // how loud the audio is at the moment
int test = 0;      // test variable to see how many times the audio has spiked - not using in the final program

ArrayList<Notes> notesP1 = new ArrayList<Notes>();

Player player1;

void setup(){
  
  size(1280, 1024);
  background(255);
  
  player1 = new Player(1);
  
  /*Set all the variables to whatever you want them to be - this will be a different function, for
  when the game gets reset after finishing a level.    */

  gameOver = true;
  
}

void draw(){
  
  background(255);

  if (gameOver == true){
    
    setUpGame("song1-justmelody.wav");
    
  }
  
  else if (gameOver == false){
    
    player1.display();
    

    loudness = amp.analyze();    
    //testingFunction();
    
    
    
    cooldown(player1.button1Cooldown);
    
    updateNotes(notesP1);
    
    text(player1.score, 100, 100);
    
    collision(notesP1);
    
    for (int i = notesP1.size() - 1; i >= 0; i--){
      
      if (notesP1.get(i).toBeDeleted == true){
      
        notesP1.remove(notesP1.get(i));
        
      }
      
    }
    
    
    
    
  }

}

void updateNotes(ArrayList n){

  for (int i = n.size() - 1; i >= 0; i--){
      
    if (n == notesP1){
      notesP1.get(i).update();
      notesP1.get(i).display();
      
      if (notesP1.get(i).pos.y > height){
        //notesP1.remove(notesP1.get(i));
        notesP1.get(i).toBeDeleted = true;
      }
    
    }
  }

}

void collision(ArrayList n){

  for (int i = n.size() - 1; i >= 0; i--){
    if (notesP1.get(i).column == 1 && player1.button1Down == true && dist(notesP1.get(i).pos.x, notesP1.get(i).pos.y, 110, float(840)) < 40 + notesP1.get(i).size / 2){
        
        //notesP1.remove(notesP1.get(i));
        notesP1.get(i).toBeDeleted = true;
        player1.score ++;
        player1.button1Cooldown = 30;
        
      
      }
      
    if(notesP1.get(i).column == 1 && player1.button1Down == true && !(dist(notesP1.get(i).pos.x, notesP1.get(i).pos.y, 110, float(840)) < 40 + notesP1.get(i).size / 2) && player1.button1Cooldown <= 0){
    
      player1.score --;
      player1.button1Cooldown = 30;
      
    }
  }
}

void cooldown(float x){

  if (x > 0){
    player1.button1Cooldown --;
  }

}

void setUpGame(String song){

    file = new SoundFile(this, song);
    amp = new Amplitude(this);
    in = new AudioIn(this, 0);
    
    in.start();
    amp.input(file);
    file.rate(1);
    
    file.play();
    gameOver = false;
    
    player1.score = 0;

}

void testingFunction(){
  
    fill(0);
    text(loudness, 100, 100);
    
    // note reference song
    fill(loudness * 500);
    rect(100, 100, 300, 300);
    
    
    if (loudness > .8){
      
      println(test);
      println(file.positionFrame());
      test ++;
    
    }    

}

void keyPressed(){

  if (key == 'd'){
  
    notesP1.add(new Notes(int(random(1, 4)), 5, 1));
  
  }
  
  if (key == player1.button1){
  
    player1.button1Down = true;
    
  
  }
  
  if (key == player1.button2){
  
    player1.button2Down = true;
  
  }
  if (key == player1.button3){
  
    player1.button3Down = true;
  
  }
}


void keyReleased(){

  if (key == player1.button1){
    player1.button1Down = false;
  }
  
  if (key == player1.button2){
    player1.button2Down = false;
  }
  
  if (key == player1.button3){
    player1.button3Down = false;
  }

}




/*
If gameOver is true
  if they’re in the title screen
    Draw the title screen and all the necessary things there
  If they’re in the level end screen
    Draw the level end screen

If gameOver is false
  If the game just started
    Setup up the game
      The song
when the notes are going to fall
    Add all the notes in the level to an array, and then we can target
all of them at once. Then duplicate it for the other player.
The player scores get reset
Draw all the graphics on the screen
Create the player button objects

  If the game hasn’t just started
    Update the game
      Move all the notes
        If there’s a note getting dropped at this time, select a random
location (of the three possible slots) for it to fall to
      Check for player input
        If they correctly “captured” a note, add score
          Draw particle effects to give feedback to the player
        If they failed in capturing a note, remove score
      Update the score display
      Check if the song has ended
      Update any other visuals

*/
