boolean gameOver; // this will become false when the game starts
//An array for the notes for each player
//Score for each player - this will be stored in the player object class

import processing.sound.*;
SoundFile file;    // the sound file
Amplitude amp;     // how the sound file is analyzed
AudioIn in;        // what audio is going into the amplitude

float loudness;    // how loud the audio is at the moment
int test = 0;


void setup(){
  
  size(1280, 1024);
  background(255);
  
  
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
    

    loudness = amp.analyze();    
    testingFunction();
    
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

Player buttons class
  
  Constructor
    Is this player one or two?
      Set up the player accordingly
    
  Input
    Check which of the 3 inputs the player has done, then check the distance from the notes in that column, and update accordingly

  Display
    Draw the buttons

Notes class

Constructor
    Add this note to the array of notes

  Function to display
  
  Function to check position of a note
    Checks where it is, when this function is ran in draw, it will run it for each note in
    the array

Particle Class

  Constructor
    Add the array of particles

  Move
    Move the arrays with some sort of physics thing - fly outwards, then slowly fade out
*/
