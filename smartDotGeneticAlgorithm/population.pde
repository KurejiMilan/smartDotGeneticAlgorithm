//population class is used to manipulate the population 
//used to evaluate, make new generation and does the selecton


class population{
  creature[] m0;
  float mutationRate = .01;
  
  population(){
    m0= new creature[totalPopulation];
    for(int i=0; i<totalPopulation; i++){
      m0[i]= new creature();
    }
  }
  
  //this just handles the display motion of the creatures
  //this is called after the fitness and selection probability is evaluated
  void display(){
    background(255);
    for(int i=0; i<totalPopulation; i++){
      if((m0[i].pos.x<0)||(m0[i].pos.x>1100)||(m0[i].pos.y<0)||(m0[i].pos.y>height))m0[i].alive=false;
      if(ob0.active){
        if((m0[i].pos.x<(ob0.pos.x+ob0.param.x))&&(m0[i].pos.x>ob0.pos.x)&&(m0[i].pos.y<ob0.pos.y+ob0.param.y)&&(m0[i].pos.y>(ob0.pos.y)))m0[i].alive=false;;
      }
      if(PVector.dist(m0[i].pos, target)<20){
            m0[i].goal=true;
            m0[i].pos.set(target.x, target.y);
      }
      if(!m0[i].goal&&m0[i].alive){
        m0[i].calVelocity();
        m0[i].pos.add(m0[i].vel);
      }
      fill(#2D6FFA);
      if(index==i){noFill();stroke(#FF0505);line(m0[i].pos.x, m0[i].pos.y, target.x, target.y);ellipse(m0[i].pos.x, m0[i].pos.y, 80, 80);stroke(0);fill(#FAFF03);}
      ellipseMode(CENTER);
      ellipse(m0[i].pos.x, m0[i].pos.y, 10, 10);
    }
  }
  
  //--------------------------------------------------------------------------------------------------------------------------------------------------------------//
  //--------------------------------------------------------------------------------------------------------------------------------------------------------------//
  //--------------------------------------------------------------------------------------------------------------------------------------------------------------//
  //--------------------------------------------------------------------------------------------------------------------------------------------------------------//
  //this function evaluates the fitness and probability of
  //selection of each sample based on the fitness of the sample
  void evaluate( ){
    for(count=0; count<1000; count++){
      for(int i=0; i<totalPopulation; i++){
        if((m0[i].alive)&&(!m0[i].goal)){
          m0[i].calVelocity();
          m0[i].pos.add(m0[i].vel);
          m0[i].steps--;
          if((m0[i].pos.x<0)||(m0[i].pos.x>1100)||(m0[i].pos.y<0)||(m0[i].pos.y>height))m0[i].alive=false;
          if(ob0.active){
            if((m0[i].pos.x<(ob0.pos.x+ob0.param.x))&&(m0[i].pos.x>ob0.pos.x)&&(m0[i].pos.y<ob0.pos.y+ob0.param.y)&&(m0[i].pos.y>(ob0.pos.y)))m0[i].alive=false;;
          }
          if(PVector.dist(m0[i].pos, target)<20){
            m0[i].goal=true;
            m0[i].pos.set(target.x, target.y);
          }
        }
      }
    }
    
    //calculating which sample has the maximum fitness
    //while evaluating the fitness of each sample
    //looping through each sample and compare
    //index stores which sample has the maximum fitness
    maxfitness=0;
    index=0;
    for(int i=0; i<totalPopulation; i++){
      int fit=0;
      float d= PVector.dist(target, m0[i].pos);
      //print("dist=",d," ----- ");
      fit= int(5000000/(d+1));
      
      if(!m0[i].alive){
        fit=fit-500-floor(m0[i].steps/5)+floor(10000/d)+floor(1000/(m0[i].steps+1));     //reduce fitness because it's not alive
      }else  if(m0[i].goal){
        fit+=50000+sq(m0[i].steps/10);   // increase fitness because it reached goal the less step it takes to reach the goal the more fit is and more reward
      }else{ 
        fit+=500+(500/d)+sqrt(m0[i].steps); // increasing fitness just because it's not dead
      }
      if(fit<0)fit=1;
      else fit /= 100;
      m0[i].fitness=fit;
      if(maxfitness<m0[i].fitness){
        maxfitness=m0[i].fitness;
        index=i;
      }
      
      //print(fit,"\n");
      //resetting some parameters for the display routine
      m0[i].pos.set(10, 250);
      m0[i].vel.set(0, 0);
      m0[i].alive=true;
      m0[i].goal=false;
      m0[i].steps=1000;
      count=0;
    }
    
    for(int i=0; i<totalPopulation; i++){
      totalScore+=m0[i].fitness;
    }
    //print("totalScore=", totalScore, "\n");
    ////finding out the probability
    //for(int i=0; i<totalPopulation; i++){
    //  m0[i].prob=(m0[i].fitness*1000)/totalScore;
    //  //print("probability=", m0[i].prob," ------ ");
    //}
  }
  
  //--------------------------------------------------------------------------------------------------------------------------------------------------------------//
  //--------------------------------------------------------------------------------------------------------------------------------------------------------------//
  //--------------------------------------------------------------------------------------------------------------------------------------------------------------//
  //--------------------------------------------------------------------------------------------------------------------------------------------------------------//
  
  void makeNewGen(){
    creature[] copiedPopulation = new creature[totalPopulation];
    for(int i=0; i<totalPopulation; i++){
      creature c0 = selection();
      creature c1 = selection();
      copiedPopulation[i] = crossover(c0, c1);
    }
    for(int i=0; i<totalPopulation; i++){
      m0[i] = copiedPopulation[i].cpy();
    }
  }
  
  creature selection(){
    int prob = int(random(totalScore));
    if(prob>(totalScore-1))prob-=1;
    int c=0;
    do{
      prob -=m0[c].fitness;
      c++;
      //overflow++;
    }while(prob>0);
    c--;
    //if(overflow>=1000)print("overflow");
    creature temp = m0[c].cpy(); 
    return temp;
  }
  
  //simple crossOver function
  //no fancy algorithm is used for the crossover function
  creature crossover(creature c0, creature c1){
    creature temC = new creature();
    for(int i=0; i<1000; i++){
      if(i< 500)temC.force[i]=c0.force[i];
      else temC.force[i]=c1.force[i];    
    }
    return temC;
  }
  
  void mutate(){
      for(int i=0; i<totalPopulation; i++){
        for(int j=0; j<1000;j++){
          if(random(1)<mutationRate)m0[i].force[j]=PVector.random2D();
        }
      }
  }
}
