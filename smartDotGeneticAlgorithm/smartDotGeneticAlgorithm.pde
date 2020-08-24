//---------------------------------------------------------------------------------------//
//this is obstacle class that holds the parameters of obstacle position, height and width
//this could be used to further train the creatures at different settings
//---------------------------------------------------------------------------------------//
class obstacle{
  PVector pos = new PVector(0, 0);
  PVector param = new PVector(0, 0);
  boolean active;
  
  obstacle(int x, int y, int wd, int ht, boolean bool){
    pos.x = x;
    pos.y = y;
    param.x = wd;
    param.y = ht;
    this.active = bool; 
  }
  void show(){
    if(this.active){
      stroke(#C9FA08);
      fill(#C9FA08);
      rect(pos.x, pos.y, param.x, param.y);
      noStroke();
      noFill();
    }
  }
}



int count=0;
int totalPopulation=500;
PVector target = new PVector(1000, 250);
int forceCount=0, index=0, maxfitness=0, totalScore=0;;
population p =new population();
obstacle ob0 = new obstacle(200, 140, 50, 200, false);

void setup(){
  size(1300,500);
  //frameRate(20);
}

void draw(){
  if(count==0)p.evaluate( );
  if(count<1000){
    p.display( );
    ob0.show();
    ellipseMode(CENTER);
    fill(#24EA46);
    ellipse(target.x, target.y, 30, 30);
    stroke(0);
    line(1100, 0, 1100, 500);
    fill(0);
    textSize(15);
    ++count;
    text("max Fitness=", 1110, 100);
    text(maxfitness, 1110+textWidth("max Fitness="), 100);
  }
  if(count>=1000){
    p.makeNewGen();
    p.mutate();
    totalScore=0;
    count=0;
  }
}
