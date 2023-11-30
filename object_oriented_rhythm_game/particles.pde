class Particle{
  
  PVector pos = new PVector();
  PVector size = new PVector();
  
  PVector acceleration = new PVector();
  PVector velocity = new PVector(1, 1);
  
  float timeAlive;
  
  Particle(float x1, float y1){
    
    size.x = 10;
    size.y = 10;
    
    acceleration.x = random(-.5, .5);
    acceleration.y = random(-.5, .5);
    
    pos.x = x1;
    pos.y = y1;
    
    timeAlive = 100;
    
  }
  
  void display(){
  
    fill(200, 100, 100, timeAlive);
    //noStroke;
    
    ellipse(pos.x, pos.y, size.x, size.y);
    ellipse(100, 100, 300, 300);
    
    timeAlive -= 5;
    
    velocity.x += acceleration.x;
    velocity.y += acceleration.y;
    
    pos.x += velocity.x;
    pos.y += velocity.y;
    
  
  }

}
