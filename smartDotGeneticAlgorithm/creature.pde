class creature{
  PVector pos=new PVector(10, 250);
  PVector vel=new PVector(0, 0);
  PVector acel= new PVector(0, 0);
  PVector[] force=new PVector[1000];
  int fitness, steps;
  float prob;
  boolean alive=true, goal=false;
  
  creature(){
    vel.limit(5);
    fitness= 0;
    prob= 0.0;
    steps=1000;
    for(int i=0; i<1000; i++)force[i]= PVector.random2D();
  }
  
  void calVelocity(){
    acel= force[count].copy();
    acel.div(10);
    vel.add(acel);
    acel.set(0,0);
  }
}
