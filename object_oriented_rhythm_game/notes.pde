class Notes{
  
  PVector pos;
  float speed;
  int whichPlayer;
  int column;
  boolean toBeDeleted = false;
  float r;
  float t;
  
  PVector size = new PVector (30, 30);

  Notes(int x, float s, int p){      // the constructor just sets up a bunch of the variables for the note. It probably won't change, but it can be easily changed just in case
    
    pos = new PVector((x * 200) - 80, 0);
    whichPlayer = p;
    speed = s;
    column = x;
    //println(column);
    r = spotInArray;
    t = song1Array[spotInArray];
    
    if (whichPlayer == 1){
      pos = new PVector((x * 200) - 80, 0);      // the note will start in a different spot for each player
    }
    
    if (whichPlayer == 2){
      pos = new PVector((x * 200) + 560, 0);
    }
    
  
  }
  
  void update(){
  
    pos.y += speed;      // move it down the screen, by the speed we set earlier
  
  }
  
  void display(){
    
    fill(0, 0, 0, 100);
    image(noteImage, pos.x - 15, pos.y - 60, 60, 80);    // displays the actual image of the note
    //ellipse(pos.x, pos.y, size.x, size.y);      // display it on the screen
    //text(r + "  " + t, pos.x - 30, pos.y - 80);
    

  
  }


}
