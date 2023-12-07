class Particle{
  
  PVector pos = new PVector();
  PVector size = new PVector();
  
  PVector acceleration = new PVector();
  PVector velocity = new PVector();
  
  PVector colour = new PVector();
  
  float timeAlive;
  
  Particle(float x1, float y1){    // constructor for the particle, it takes arguements for the position of the particle
    
    size.x = 15;
    size.y = 15;
    
    velocity.x = random(-4, 4);
    velocity.y = random(-4, 4);
    
    colour.x = random(1, 255);
    colour.y = random(1, 255);
    colour.z = random(1, 255);
    
    acceleration.x = random(-.3, .3);
    acceleration.y = random(-.3, .3);
    
    pos.x = x1;
    pos.y = y1;
    
    timeAlive = 255;
    
  }
  
  void display(){
  
    fill(colour.x, colour.y, colour.z, timeAlive);
    noStroke();
    
    ellipse(pos.x, pos.y, size.x, size.y);
    //ellipse(100, 100, 300, 300);
    
    timeAlive -= 10;
    
    velocity.x += acceleration.x;
    velocity.y += acceleration.y;
    
    pos.x += velocity.x;
    pos.y += velocity.y;
    
  
  }

}
