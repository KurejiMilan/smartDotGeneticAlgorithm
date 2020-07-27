class population{
  creature[] m0;
  
  population(){
    m0= new creature[totalPopulation];
    for(int i=0; i<totalPopulation; i++){
      m0[i]= new creature();
    }
  }
  
  void display(){
    background(255);
    for(int i=0; i<totalPopulation; i++){
      if((m0[i].pos.x<0)||(m0[i].pos.x>1100)||(m0[i].pos.y<0)||(m0[i].pos.y>height))m0[i].alive=false;
      if(PVector.dist(m0[i].pos, target)<20){
            m0[i].goal=true;
            m0[i].pos.set(target.x, target.y);
      }
      if(!m0[i].goal&&m0[i].alive){
        m0[i].calVelocity();
        m0[i].pos.add(m0[i].vel);
      }
      fill(#2D6FFA);
      if(index==i){fill(#FAFF03);line(m0[i].pos.x, m0[i].pos.y, target.x, target.y);}
      ellipseMode(CENTER);
      ellipse(m0[i].pos.x, m0[i].pos.y, 10, 10);
    }
  }
  void evaluate(){
    for(count=0; count<1000; count++){
      for(int i=0; i<totalPopulation; i++){
        if((m0[i].alive)&&(!m0[i].goal)){
          m0[i].calVelocity();
          m0[i].pos.add(m0[i].vel);
          m0[i].steps--;
          if((m0[i].pos.x<0)||(m0[i].pos.x>1100)||(m0[i].pos.y<0)||(m0[i].pos.y>height))m0[i].alive=false;
          if(PVector.dist(m0[i].pos, target)<20){
            m0[i].goal=true;
            m0[i].pos.set(target.x, target.y);
          }
        }
      }
    }
    index=0;
    maxfitness=0;
    for(int i=0; i<totalPopulation; i++){
      int fit=0;
      float d= PVector.dist(target, m0[i].pos);
      fit= int(10000000/(d+1));
      if(!m0[i].alive){
        fit-=500-m0[i].steps/5-d/10;
      }else  if(m0[i].goal){
        fit+=1000;
        fit+=m0[i].steps/10;
      }else{ 
        fit+=500+(10000/d)+sqrt(m0[i].steps);
      }
      m0[i].fitness=fit;
      if(maxfitness<m0[i].fitness){
        maxfitness=m0[i].fitness;
        index=i;
      }
      print(fit,"\n");
      m0[i].pos.set(10, 250);
      m0[i].vel.set(0, 0);
      m0[i].alive=true;
      m0[i].goal=false;
      m0[i].steps=1000;
      count=0;
    }
    int totalScore=0;
    for(int i=0; i<totalPopulation; i++){
      totalScore+=m0[i].fitness;
    }
    print("totalScore=", totalScore);
    for(int i=0; i<totalPopulation; i++){
      m0[i].prob=(m0[i].fitness/totalScore)*100;
    }
  }
  
  void makeNewGen(){
    creature[] copy = new creature[totalPopulation];
    for(int i=0; i<totalPopulation; i++){
    
    }
  }
  //creature selection(){
    
  //  return;
  //}

}
