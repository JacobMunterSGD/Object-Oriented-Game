/*Constructor
    Add this note to the array of notes

  Function to display
  
  Function to check position of a note
    Checks where it is, when this function is ran in draw, it will run it for each note in
    the array

Particle Class

  Constructor
    Add the array of particles

  Move
    Move the arrays with some sort of physics thing - fly outwards, then slowly fade out    */


class Notes{
  
  PVector pos;
  float speed;
  int whichPlayer;
  int column;
  boolean toBeDeleted = false;
  
  int size = 30;

  Notes(int x, float s, int p){
    
    pos = new PVector((x * 200) - 80, 0);
    whichPlayer = p;
    speed = s;
    column = x;
    println(column);
  
  }
  
  void update(){
  
    pos.y += speed;
  
  }
  
  void display(){
    
    fill(0);
    ellipse(pos.x, pos.y, size, size);
  
  }


}
