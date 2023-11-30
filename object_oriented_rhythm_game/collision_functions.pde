void collision(ArrayList n, Player x, float b1pos, float b2pos, float b3pos){    // this function checks if there has been a collision with each player button and each note
  //println(n[0]);
  
  ArrayList<Notes> tempNotes = new ArrayList<Notes>();
  tempNotes = n;
  
  for (int i = tempNotes.size() - 1; i >= 0; i--){    // every note in the array is checked
    // button 1
    if (tempNotes.get(i).column == 1 && x.button1Down == true && dist(tempNotes.get(i).pos.x, tempNotes.get(i).pos.y, b1pos, float(840)) < 40 + tempNotes.get(i).size.y / 2  /*&& x.button1Cooldown <= 0*/){    // the cooldown makes it more difficult in some spots, when you have to capture notes quickly, which isn't great
        
        tempNotes.get(i).toBeDeleted = true;
        x.score ++;
        x.button1Cooldown = 30;
        
        for (int j = 0; j < 10; j++){
          particles.add(new Particle(120, 840));
        }


      }
 
    // button 2
    if (tempNotes.get(i).column == 2 && x.button2Down == true && dist(tempNotes.get(i).pos.x, tempNotes.get(i).pos.y, b2pos, float(840)) < 40 + tempNotes.get(i).size.y / 2  /*&& x.button2Cooldown <= 0*/){
        
        tempNotes.get(i).toBeDeleted = true;
        x.score ++;
        x.button2Cooldown = 30;
        
      }
      
    
    // button 3
    if (tempNotes.get(i).column == 3 && x.button3Down == true && dist(tempNotes.get(i).pos.x, tempNotes.get(i).pos.y, b3pos, float(840)) < 40 + tempNotes.get(i).size.y / 2  /*&& x.button3Cooldown <= 0*/){
        
        tempNotes.get(i).toBeDeleted = true;
        x.score ++;
        x.button3Cooldown = 30;
        
      }
      
      
  }
}

void missCollision(ArrayList n, Player x){    // this function checks if the player has pressed a button, but has missed the player. For some reason this breaks when it's done in the same function as the collision function
  
  ArrayList<Notes> tempNotes = new ArrayList<Notes>();
  tempNotes = n;

  for (int i = n.size() - 1; i >= 0; i--){
    
     if (x.button1Down == true && dist(tempNotes.get(i).pos.x, tempNotes.get(i).pos.y, 110, float(840)) > 40 + tempNotes.get(i).size.y / 2 && x.button1Cooldown <= 0){
    
      //println("button down" + player1.button1Cooldown);
       
      x.score --;
      x.button1Cooldown = 30;
      
      }
      
     if (x.button2Down == true && dist(tempNotes.get(i).pos.x, tempNotes.get(i).pos.y, 320, float(840)) > 40 + tempNotes.get(i).size.y / 2 && x.button2Cooldown <= 0){
    
      x.score --;
      x.button2Cooldown = 30;
      
      }
      
     if (x.button3Down == true && dist(tempNotes.get(i).pos.x, tempNotes.get(i).pos.y, 520, float(840)) > 40 + tempNotes.get(i).size.y / 2 && x.button3Cooldown <= 0){
    
      x.score --;
      x.button3Cooldown = 30;
      
      }
  }
}
