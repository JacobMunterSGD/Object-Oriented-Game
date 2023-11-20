boolean gameOver; // this will become false when the game starts
//An array for the notes for each player
//Score for each player - this will be stored in the player object class
import processing.sound.*;
SoundFile file;
BeatDetector beat;
Amplitude amp;
AudioIn in;

float loudness;

boolean isBeat;

void setup(){
  
  size(1280, 1024);
  
  /*Set all the variables to whatever you want them to be - this will be a different function, for
when the game gets reset after finishing a level.    */

  gameOver = false;
  
  file = new SoundFile(this, "cabprerec.mp3");
  file.play();
  
  beat = new BeatDetector(this);
  
  amp = new Amplitude(this);
  
  in = new AudioIn(this, 0);
  in.start();
  amp.input(in);

  
  
}

void draw(){
  
  background(255);

  if (gameOver == true){
  
  
  }
  
  else if (gameOver == false){
    
    int i = 0;
    if (file.isPlaying()) {
      i++;
      //println("File is still playing after " + i + " seconds");
    }
    
    //println(beat.isBeat());
    println(amp.analyze());
    loudness = amp.analyze();
    
    
   /* if (beat.isBeat()){
      println("yes");
      loudness = 0;
    
    } else{
      println("no");
    
      loudness = 100;
    
    }
    */
    fill(loudness);
    rect(100, 100, 300, 300);
    
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
