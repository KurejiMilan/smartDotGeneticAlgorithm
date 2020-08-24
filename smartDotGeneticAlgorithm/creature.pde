//creature class and the necessary function class
//this class inclues property of positon and dynamic characteristics
//useing PVector class to represent the vector data types that holds the 
//positonal, force, velocity, acceleration properties that are vector in real life

class creature{
  PVector pos=new PVector(10, 250);
  PVector vel=new PVector(0, 0);
  PVector acel= new PVector(0, 0);
  PVector[] force=new PVector[1000];
  int fitness, steps;
  double prob;
  boolean alive=true, goal=false;
  
  //this is the creature class constructor used to initialize the vector properties
  //of the creature class
  creature(){
    vel.limit(5);
    fitness= 0;
    prob= 0.0;
    steps=1000;
    for(int i=0; i<1000; i++)force[i]= PVector.random2D();
  }
  
  //calculate the velocity
  void calVelocity(){
    acel= force[count].copy();
    acel.div(10);
    vel.add(acel);
    acel.set(0,0);
  }
  
  //used to cpoy the creature objets so create it's own separate copy
  //this doesn't refrence the same copy of the object
  creature cpy(){
    creature cp = new creature();
    for(int i=0; i<1000; i++){
        cp.force[i] = new PVector(force[i].x, force[i].y);
    }
    cp.prob= prob;
    return cp;
  }
} 
