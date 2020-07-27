int count=0;
int totalPopulation=500;
PVector target = new PVector(1000, 250);
int forceCount=0, index=0, maxfitness=0;
population p =new population();

void setup(){
  size(1300,500);
  //frameRate(20);
}

void draw(){
  if(count==0)p.evaluate();
  if(count<1000){
    p.display();
    ellipseMode(CENTER);
    fill(#24EA46);
    ellipse(target.x, target.y, 20, 20);
    stroke(0);
    line(1100, 0, 1100, 500);
    fill(0);
    textSize(15);
    ++count;
    text("max Fitness=", 1110, 100);
    text(maxfitness, 1110+textWidth("max Fitness="), 100);
  }
  if(count>999)count=0;
}
