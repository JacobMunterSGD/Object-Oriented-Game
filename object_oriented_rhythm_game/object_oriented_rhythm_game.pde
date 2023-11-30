import processing.sound.*;
SoundFile file;    // the sound file
Amplitude amp;     // how the sound file is analyzed
AudioIn in;        // what audio is going into the amplitude

float loudness;    // how loud the audio is at the moment
int test = 0;      // test variable to see how many times the audio has spiked - not using in the final program

boolean gameOver;  // this will become false when the game starts
boolean titleScreen; // this will also become false when the game starts, this is to know what state we're in during the start of the program

ArrayList<Notes> notesP1 = new ArrayList<Notes>(); //An arraylist for the notes for each player
ArrayList<Notes> notesP2 = new ArrayList<Notes>();


// this song stores all the times in the song when the notes should drop, this is always going to be static, it simply stores the data to be called on later
float[] song1Array = {4, 6, 8, 10, 12, 14, 15, 16, 
                      16.75, 17.25, 17.75, 18, 18.75, 19.25, 20.5, 20.75, 21, 21.5, 21.75, 22, 22.75, 23.5, 24.75, 25, 25.37, 25.75, 26, 27, 27.12, 27.25, 27.37, 27.75, 28, 29.5, 29.75, 30, 31,
                      32, 32.25, 33.25, 33.5, 34, 34.25, 35, 35.25, 35.5, 35.75, 36, 36.25, 37.25, 37.5, 38, 38.25, 38.75, 39.25, 39.5, 39.75, 40, 40.25, 41.25, 41.5, 42, 42.25, 43, 43.25, 43.5, 43.75, 44, 44.25, 45.25, 45.5, 46, 46.25, 46.75, 47.25, 47.5, 47.75,
                      48, 48.12, 48.25, 48.37, 48.5, 48.75, 49, 49.37, 49.75, };



float timeToNextNote = 60;  // the time until the first note
float timeElapsed = 0;      // how much time has passed since the program has started. This will be subtracted from the array of timing for the song, to tell how much time there is between notes
int spotInArray = 0;        // this tells us where we are in the array. This is increased by one every time a note is dropped.

Player player1;             // objects for the player controllers
Player player2;

void setup(){
  
  size(1280, 1024);
  background(255);      // maybe I'll replace this with some kind of fancy image, that would be fun
  
  for (int i = song1Array.length - 1; i >= 0; i--){      // this for loop goes through every spot in the array, and changes the array from seconds to frames, which is easier for processing to handle
    //print(song1Array[i] + "    " );
    song1Array[i] = (song1Array[i] * 60) - 60;
    //print(song1Array[i] + "   ");
  }
  
  //println(song1Array);
  
  player1 = new Player(1);
  player2 = new Player(2);

  gameOver = true;      // the game hasn't started yet, so game over is true
  titleScreen = true;   // we want to start in the title screen
  
}

void draw(){
  
  background(255);

  if (gameOver == true){    // this is what's happening when the game isn't running
    
    if (titleScreen){    // if we're in the starting title screen, some text is displayed that explains what is going on
      
      fill(0);
      textAlign(CENTER);
      textSize(50);
      text("Object Oriented Rhythm Game", width/2, height/2 - 200);
      textSize(30);
      text("Press Space to Start", width/2, height/2 - 50);
      
      text("player one uses shift, z, and x", width/4, height/2 + 100);
      text("player two uses m, comma, and period", width/4*3, height/2 + 100);
    
    }
    
    
  }
  
  else if (gameOver == false){    // this is what's happening when the game is running
    
    player1.display();      // both of the players buttons are displayed
    player2.display();

    //loudness = amp.analyze();    
    //testingFunction();
    
    cooldown(player1.button1Cooldown, player1);      // this section adds a "miss" cooldown for the button. The player is penalized when they don't successfuly capture a note,
    cooldown(player1.button2Cooldown, player1);      // but there's a cooldown, so they don't lose points every frame the button is pressed down
    cooldown(player1.button3Cooldown, player1);
    
    cooldown(player2.button1Cooldown, player2);
    cooldown(player2.button2Cooldown, player2);
    cooldown(player2.button3Cooldown, player2);
    
    updateNotes(notesP1);    // this updates the position of the notes for both players
    updateNotes(notesP2);
    
    textSize(50);
    text(int(player1.score), 0 + 100, 100);      // this displays the score for each player
    text(int(player2.score), width - 100, 100);
    
    //Notes[] ntemp = notesP1.toArray();
    //player1.score = collision(notesP1);
    collision(notesP1, player1, 120, 320, 520);      // these functions check if the player has either collided, or missed the notes
    missCollision(notesP1, player1);
    
    collision(notesP2, player2, 760, 960, 1160);
    missCollision(notesP2, player2);
      
    dropNotes();      // this is the code that places the note, from the song time array, into the game
    
    timeToNextNote --;    // when this variable reaches zero, the next note is dropped
    timeElapsed ++;       // this variables keeps track of the amount of time since the game started, kind of like frameCount, but it only starts after gameOver is false
    
    //println(player1.button1Cooldown);
    
    for (int i = notesP1.size() - 1; i >= 0; i--){    // this checks if any notes have been marked to be removed, and removes them. This is all done in the same spot because there are arrayList issues when objects are just removed whenever
      
      if (notesP1.get(i).toBeDeleted == true){
      
        notesP1.remove(notesP1.get(i));
        
      }
    }
    
    for (int i = notesP2.size() - 1; i >= 0; i--){
      
      if (notesP2.get(i).toBeDeleted == true){
      
        notesP2.remove(notesP2.get(i));
        
      }
    }
  }
}

void dropNotes(){    // this the function that drops the notes into the game
  
  if (timeToNextNote <= 0){                        // is it time to drop a note?
    if (spotInArray < song1Array.length - 1){      // are we at the end of the array?
      int c = int(random(1, 4));                   // this random position variable determines in which of the three spots the note will be dropped. This is a variable so it can be consistent for both players
      notesP1.add(new Notes(c, 13.3, 1));          // this actually adds a new note for both players
      notesP2.add(new Notes(c, 13.3, 2));
      timeToNextNote = (song1Array[spotInArray] - timeElapsed);      // this resets the time to next note, to however long it is until the next note needs to be dropped
      spotInArray ++;    // we're now in the next spot in the array
    }
  }
}

void updateNotes(ArrayList n){        // this function updates the location of the notes on each side of the screen, and checks if they were missed by the player and exited the screen, at which point they will be deleted

  ArrayList<Notes> tempNotes = new ArrayList<Notes>();
  tempNotes = n;
  
  for (int i = tempNotes.size() - 1; i >= 0; i--){
      
    //if (tempNotes == notesP1){
      tempNotes.get(i).update();
      tempNotes.get(i).display();
      
      if (tempNotes.get(i).pos.y > height){
        //notesP1.remove(notesP1.get(i));
        tempNotes.get(i).toBeDeleted = true;
        
      }
   // }
   
  }
}



void cooldown(float c, Player x){    // this function keeps track of the button cooldown

  if (c > 0 && c == x.button1Cooldown){    // if the cooldown is above 0, subtract one from the variable
    x.button1Cooldown --;
  }
  if (c > 0 && c == x.button2Cooldown){
    x.button2Cooldown --;
  }
  if (c > 0 && c == x.button3Cooldown){
    x.button3Cooldown --;
  }

}

void setUpGame(String song){      // this sets up the game

    file = new SoundFile(this, song);    // this sets up the sound file with the processing sound library
    amp = new Amplitude(this);
    in = new AudioIn(this, 0);
    
    in.start();
    amp.input(file);
    file.rate(1);
    
    player1.score = 0;    // both of the players scores are set to zero
    player2.score = 0;
    
    file.play();    // the file starts playing
    
    notesP1.add(new Notes(30, 0, 1));    // this just makes it so there's always at least one note in each array, so things that check for notes never break
    notesP2.add(new Notes(30, 0, 2));
    
    titleScreen = false;    // we're no longer in the title screen
    gameOver = false;       // the game is now ON
    
    
    
}

void testingFunction(){    // this was used to check if things were working, when getting the amplitude realtime from the audio
  
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

*/
