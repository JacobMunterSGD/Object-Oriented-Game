import processing.sound.*;
SoundFile file;    // the sound file
Amplitude amp;     // how the sound file is analyzed
AudioIn in;        // what audio is going into the amplitude

float loudness;    // how loud the audio is at the moment
int test = 0;      // test variable to see how many times the audio has spiked - not using in the final program

boolean gameOver;  // this will become false when the game starts

ArrayList<Notes> notesP1 = new ArrayList<Notes>(); //An arraylist for the notes for each player
ArrayList<Notes> notesP2 = new ArrayList<Notes>();

//float[] song1Array = new float[100];

float[] song1Array = {4, 6, 8, 10, 12, 14, 15, 16, 
                      16.75, 17.25, 17.75, 18, 18.75, 19.25, 20.5, 20.75, 21, 21.5, 21.75, 22, 22.75, 23.5, 24.75, 25, 25.37, 25.75, 26, 27, 27.12, 27.25, 27.37, 27.75, 28, 29.5, 29.75, 30, 31,
                      32, 32.25, 33.25, 33.5, 34, 34.25, 35, 35.25, 35.5, 35.75, 36, 36.25, 37.25, 37.5, 38, 38.25, 38.75, 39.25, 39.5, 39.75, 40, 40.25, 41.25, 41.5, 42, 42.25, 43, 43.25, 43.5, 43.75, 44, 44.25, 45.25, 45.5, 46, 46.25, 46.75, 47.25, 47.5, 47.75,
                      48, 48.12, 48.25, 48.37, 48.5, 48.75, 49, 49.37, 49.75, };



float timeToNextNote = 60;
float timeElapsed = 0;
int spotInArray = 0;

Player player1;
Player player2;

void setup(){
  
  size(1280, 1024);
  background(255);
  
  for (int i = song1Array.length - 1; i >= 0; i--){
    //print(song1Array[i] + "    " );
    song1Array[i] = (song1Array[i] * 60) - 60;
    //print(song1Array[i] + "   ");
  }
  
  println(song1Array);
  
  player1 = new Player(1);
  
  player2 = new Player(2);
  
  
  
  /*Set all the variables to whatever you want them to be - this will be a different function, for
  when the game gets reset after finishing a level.    */

  gameOver = true;
  
}

void draw(){
  
  background(255);

  if (gameOver == true){
    
    fill(0);
    textAlign(CENTER);
    textSize(20);
    text("press space to start", width/2, height/2);
    
  }
  
  else if (gameOver == false){
    
    player1.display();
    player2.display();

    loudness = amp.analyze();    
    //testingFunction();
    
    cooldown(player1.button1Cooldown, player1);
    cooldown(player1.button2Cooldown, player1);
    cooldown(player1.button3Cooldown, player1);
    
    cooldown(player2.button1Cooldown, player2);
    cooldown(player2.button2Cooldown, player2);
    cooldown(player2.button3Cooldown, player2);
    
    updateNotes(notesP1);
    updateNotes(notesP2);
    
    text(player1.score, 100, 100);
    text(player2.score, 900, 100);
    
    //Notes[] ntemp = notesP1.toArray();
    //player1.score = collision(notesP1);
    collision(notesP1, player1, 120, 320, 520);
    missCollision(notesP1, player1);
    
    collision(notesP2, player2, 760, 960, 1160);
    missCollision(notesP2, player2);
    
    
    dropNotes();
    //println("asdsda" + timeToNextNote);
    timeToNextNote --;
    timeElapsed ++;
    
    //println(player1.button1Cooldown);
    
    for (int i = notesP1.size() - 1; i >= 0; i--){
      
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

void dropNotes(){
  
  if (timeToNextNote <= 0){
    if (spotInArray < song1Array.length - 1){
      int c = int(random(1, 4));
      //println(c);
      notesP1.add(new Notes(c, 13.3, 1));
      notesP2.add(new Notes(c, 13.3, 2));
      timeToNextNote = (song1Array[spotInArray] - timeElapsed);
      //println(timeToNextNote);
      spotInArray ++;
    }
  }
}

void updateNotes(ArrayList n){

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

void collision(ArrayList n, Player x, float b1pos, float b2pos, float b3pos){
  //println(n[0]);
  
  ArrayList<Notes> tempNotes = new ArrayList<Notes>();
  tempNotes = n;
  
  for (int i = tempNotes.size() - 1; i >= 0; i--){
    // button 1
    if (tempNotes.get(i).column == 1 && x.button1Down == true && dist(tempNotes.get(i).pos.x, tempNotes.get(i).pos.y, b1pos, float(840)) < 40 + tempNotes.get(i).size / 2  /*&& x.button1Cooldown <= 0*/){    // the cooldown makes it more difficult in some spots, when you have to capture notes quickly, which isn't great
        
        tempNotes.get(i).toBeDeleted = true;
        x.score ++;
        x.button1Cooldown = 30;
        //return 1;

      }
 
    // button 2
    if (tempNotes.get(i).column == 2 && x.button2Down == true && dist(tempNotes.get(i).pos.x, tempNotes.get(i).pos.y, b2pos, float(840)) < 40 + tempNotes.get(i).size / 2  /*&& x.button2Cooldown <= 0*/){
        
        tempNotes.get(i).toBeDeleted = true;
        x.score ++;
        x.button2Cooldown = 30;
        //return 1;
        
      }
      
    
    // button 3
    if (tempNotes.get(i).column == 3 && x.button3Down == true && dist(tempNotes.get(i).pos.x, tempNotes.get(i).pos.y, b3pos, float(840)) < 40 + tempNotes.get(i).size / 2  /*&& x.button3Cooldown <= 0*/){
        
        tempNotes.get(i).toBeDeleted = true;
        x.score ++;
        x.button3Cooldown = 30;
        //return 1;
        
      }
      
      
  }
}

void missCollision(ArrayList n, Player x){
  
  ArrayList<Notes> tempNotes = new ArrayList<Notes>();
  tempNotes = n;

  for (int i = n.size() - 1; i >= 0; i--){
    
     if (x.button1Down == true && dist(tempNotes.get(i).pos.x, tempNotes.get(i).pos.y, 110, float(840)) > 40 + tempNotes.get(i).size / 2 && x.button1Cooldown <= 0){
    
      //println("button down" + player1.button1Cooldown);
       
      x.score --;
      x.button1Cooldown = 30;
      
      }
      
     if (x.button2Down == true && dist(tempNotes.get(i).pos.x, tempNotes.get(i).pos.y, 320, float(840)) > 40 + tempNotes.get(i).size / 2 && x.button2Cooldown <= 0){
    
      x.score --;
      x.button2Cooldown = 30;
      
      }
      
     if (x.button3Down == true && dist(tempNotes.get(i).pos.x, tempNotes.get(i).pos.y, 520, float(840)) > 40 + tempNotes.get(i).size / 2 && x.button3Cooldown <= 0){
    
      x.score --;
      x.button3Cooldown = 30;
      
      }
  }
}

void cooldown(float c, Player x){

  if (c > 0 && c == x.button1Cooldown){
    x.button1Cooldown --;
  }
  if (c > 0 && c == x.button2Cooldown){
    x.button2Cooldown --;
  }
  if (c > 0 && c == x.button3Cooldown){
    x.button3Cooldown --;
  }

}

void setUpGame(String song){

    file = new SoundFile(this, song);
    amp = new Amplitude(this);
    in = new AudioIn(this, 0);
    
    in.start();
    amp.input(file);
    file.rate(1);
    
    player1.score = 0;
    player2.score = 0;
    
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

void keyPressed(){

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
