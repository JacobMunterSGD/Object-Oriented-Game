import processing.sound.*;

/*        Credits

          All of the code was written by me, with these exceptions
            - Some of the code to set up and use the sound library was copied from the processing documentation here - https://processing.org/reference/libraries/sound/index.html
            - You (Prof. Barry) helped me in class at some points. The code is all my own, but you provided assistance in figuring out some issues, such as further instruction on how to use switch statements. The code is still all my own, but you helped me understand some key ideas.

*/
SoundFile file;    // the sound file
Amplitude amp;     // how the sound file is analyzed
AudioIn in;        // what audio is going into the amplitude

float loudness;    // how loud the audio is at the moment
int test = 0;      // test variable to see how many times the audio has spiked - not using in the final program
float test2;       // another testing function

boolean gameOver;  // this will become false when the game starts
boolean titleScreen; // this will also become false when the game starts, this is to know what state we're in during the start of the program
boolean oneTimeThrough; // this will become true when the game finishes for the first time. After this is true, the previous games player scores will appear on screen

ArrayList<Notes> notesP1 = new ArrayList<Notes>(); //An arraylist for the notes for each player
ArrayList<Notes> notesP2 = new ArrayList<Notes>();

ArrayList<Particle> particles = new ArrayList<Particle>(); // array list that stores the particles

PImage noteImage;      // loading all the images in
PImage playerButtonP1;
PImage playerButtonP2;
PImage bg;
PImage title;

PFont font;

// this song stores all the times in the song when the notes should drop, this is always going to be static, it simply stores the data to be called on later
float[] song1Array = {4, 6, 8, 10, 12, 14, 15, 16, 
                      16.75, 17.25, 17.75, 18, 18.75, 19.25, 20.5, 20.75, 21, 21.5, 21.75, 22, 22.75, 23.5, 24.75, 25, 25.37, 25.75, 26, 27, 27.12, 27.25, 27.37, 27.75, 28, 29.5, 29.75, 30, 31,
                      32, 32.25, 33.25, 33.5, 34, 34.25, 35, 35.25, 35.5, 35.75, 36, 36.25, 37.25, 37.5, 38, 38.25, 38.75, 39.25, 39.5, 39.75, 40, 40.25, 41.25, 41.5, 42, 42.25, 43, 43.25, 43.5, 43.75, 44, 44.25, 45.25, 45.5, 46, 46.25, 46.75, 47.25, 47.5, 47.75,
                      48, 48.12, 48.25, 48.37, 48.5, 48.75, 49, 49.37, 49.75, 50.25, 50.5, 50.75, 51, 51.12, 51.25, 51.5, 51.62, 51.75, 52, 52.5, 53, 53.25, 53.5, 53.75, 54.25, 54.75, 55, 55.25, 55.5, 55.75, 
                      56, 56.12, 56.25, 56.37, 56.5, 56.75, 57, 57.37, 57.75, 58.25, 58.5, 58.75, 59, 59.12, 59.25, 59.5, 59.62, 59.75, 60, 60.5, 61, 61.25, 61.5, 61.75, 62.25, 62.75, 63, 63.25, 63.5, 63.75, 
                      64, 64.12, 64.25, 64.37, 64.5, 64.75, 65, 65.37, 65.75, 66.25, 66.5, 66.75, 67, 67.12, 67.25, 67.5, 67.62, 67.75, 68, 68.5, 69, 69.25, 69.5, 69.75, 70.25, 70.75, 71, 71.25, 71.5, 71.75,
                      72.5, 73, 73.5, 74.5, 75, 75.5, 76.5, 77, 77.5, 78.5, 79, 79.5, 80.5, 81, 81.5, 82.5, 83, 83.5, 84.5, 85, 85.5, 86.5, 87, 87.5, 
                      88, 88.75, 89.25, 89.75, 90, 90.75, 91.25, 92.5, 92.75, 93, 93.5, 93.75, 94, 94.75, 95.5, 96.75, 97, 97.37, 97.75, 98, 99, 99.12, 99.25, 99.37, 99.75, 100, 101.5, 101.75, 102, 103, 104, 110, 111};



float timeToNextNote;  // the time until the first note
float timeElapsed;      // how much time has passed since the program has started. This will be subtracted from the array of timing for the song, to tell how much time there is between notes
int spotInArray;        // this tells us where we are in the array. This is increased by one every time a note is dropped.

Player player1;             // objects for the player controllers
Player player2;

void setup(){
  
  frameRate(30);
  
  size(1280, 1024);
  
  title = loadImage("title screen.png");    // loading the title screen image
  
  image(title, 0, 0, 1280, 1024);    // displaying the title screen on the very first frame
  
  noteImage = loadImage("music-note.png");          // loading the various images in the game
  playerButtonP1 = loadImage("player button.png");
  playerButtonP2 = loadImage("player button p2.png");
  bg = loadImage("bg.png");
  
  font = createFont("MekanikStd", 30);
  textFont(font);
  
  for (int i = song1Array.length - 1; i >= 0; i--){      // this for loop goes through every spot in the array, and changes the array from seconds to frames, which is easier for processing to handle
    //print(song1Array[i] + "    " );
    song1Array[i] = (song1Array[i] * 30) - 60;
    //print(song1Array[i] + "   ");
  }
  
  //println(song1Array);
  
  player1 = new Player(1);
  player2 = new Player(2);

  gameOver = true;      // the game hasn't started yet, so game over is true
  titleScreen = true;   // we want to start in the title screen
  oneTimeThrough = false;    // we haven't played the game yet, so this starts as false
  
}

void draw(){

  if (gameOver == true){    // this is what's happening when the game isn't running
    
    if (titleScreen){    // if we're in the starting title screen, some text is displayed that explains what is going on
      
      image(title, 0, 0, 1280, 1024);
      
      //println(player1.score + "   " + player2.score);
      if (oneTimeThrough){
        fill(240);
        rectMode(CENTER);
        noStroke();
        rect(175, 290, 240, 150);
        rect(width - 175, 290, 240, 150);
        fill(0);
        textSize(75);
        textAlign(CENTER);
        text("Player 1 Score", 0 + 175, 280);
        text(int(player1.score), 0 + 175, 350);
        text("Player 2 Score", width - 175, 280);
        text(int(player2.score), width - 175, 350);
      }
      //text("Player 2 Score = " + int(player2.score), width - 20, 350);

      
     /* fill(0);
      textAlign(CENTER);
      textSize(50);
      text("Object Oriented Rhythm Game", width/2, height/2 - 200);
      textSize(30);
      text("Press Space to Start", width/2, height/2 - 50);
      
      text("player one uses shift, z, and x", width/4, height/2 + 100);
      text("player two uses m, comma, and period", width/4*3, height/2 + 100);*/
    
    }
    
  }
  
  else if (gameOver == false){    // this is what's happening when the game is running
    
    image(bg, 0, 0, width, height);
    
    //fill((loudness * 255) + 100);
    //noStroke();
    //ellipse(width/2, height/2, loudness * 400, loudness * 400);
    
    player1.display();      // both of the players buttons are displayed
    player2.display();
    
    for (int i = particles.size() - 1; i >= 0; i--){    // this checks if any notes have been marked to be removed, and removes them. This is all done in the same spot because there are arrayList issues when objects are just removed whenever
      
      particles.get(i).display();
      
      if  (particles.get(i).timeAlive < 0){
         particles.remove(particles.get(i));
      }

      
    }
    
    //loudness = 1 - amp.analyze();
    //println(loudness);
    
    test2 = testingFunction();
    
    cooldown(player1.button1Cooldown, player1);      // this section adds a "miss" cooldown for the button. The player is penalized when they don't successfuly capture a note,
    cooldown(player1.button2Cooldown, player1);      // but there's a cooldown, so they don't lose points every frame the button is pressed down
    cooldown(player1.button3Cooldown, player1);
    
    cooldown(player2.button1Cooldown, player2);
    cooldown(player2.button2Cooldown, player2);
    cooldown(player2.button3Cooldown, player2);
    
    updateNotes(notesP1);    // this updates the position of the notes for both players
    updateNotes(notesP2);
    
    textSize(50);
    textAlign(CENTER);
    fill(0);
    text(int(player1.score), 320, height - 65);      // this displays the score for each player
    text(int(player2.score), 960, height - 65);
    
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
    
    for (int i = notesP2.size() - 1; i >= 0; i--){    // this checks the same thing for the other player's notes
      
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
      //println(song1Array[spotInArray] / 60);
      spotInArray ++;    // we're now in the next spot in the array
      
    }
    else{
    
    println("works");
    gameOver = true;      // if we've gotten to the last spot in the array, the game is over
    titleScreen = true;
    oneTimeThrough = true;
    
    }
  }
}

void updateNotes(ArrayList n){        // this function updates the location of the notes on each side of the screen, and checks if they were missed by the player and exited the screen, at which point they will be deleted

  ArrayList<Notes> tempNotes = new ArrayList<Notes>();    // this creates a local variable that is the given array list you wish to use
  tempNotes = n;
  
  for (int i = tempNotes.size() - 1; i >= 0; i--){      // this loop goes through all of the notes

      tempNotes.get(i).update();    // update the position
      tempNotes.get(i).display();   // show on screen
      
      if (tempNotes.get(i).pos.y > height + 30){    // if the note goes below the bottom of the screen, it is removed from the array
        //notesP1.remove(notesP1.get(i));
        tempNotes.get(i).toBeDeleted = true;
        
      }
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
    
    timeToNextNote = 0;     // this resets all the variables to start the game
    timeElapsed = 0;     
    spotInArray = 0;    
    
    file = new SoundFile(this, song);    // this sets up the processing sound library objects
    amp = new Amplitude(this);
    in = new AudioIn(this, 0);
    
    in.start();
    amp.input(file);
    file.rate(1);
    
    player1.score = 0;    // both of the players scores are set to zero
    player2.score = 0;
    
    
    
    notesP1.add(new Notes(30, 0, 1));    // this just makes it so there's always at least one note in each array, so things that check for notes never break
    notesP2.add(new Notes(30, 0, 2));
    
    titleScreen = false;    // we're no longer in the title screen
    gameOver = false;       // the game is now ON
    
    file.play();    // the file starts playing
    
    
}

float testingFunction(){    // this was used to check if things were working, when getting the amplitude realtime from the audio
  
    float c = 0;
  
    fill(0);
    //text(loudness, 100, 100);
    
    // note reference song
    fill(loudness * 500);
    //rect(100, 100, 300, 300);
    
    
    if (loudness > .8){
      
      //println(test);
      //println(file.positionFrame());
      test ++;
    
    }
    
    c = loudness;
    
    return c;
    
    
}
