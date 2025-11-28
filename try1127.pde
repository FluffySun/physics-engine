//these are not sure
/*
 float distSq=dx*dx+dy*dy;
  float hitR=15+25;
  if(distSq<hitR*hitR){
    fill(255); 
*/

//Ema Sun
//Derpy sports game

import fisica.*;

color blue= color(29,178,242);
color brown= color(166,120,24);
color green= color(74,163,57);
color red= color(224,80,61);
color yellow= color(242,215,16);

PImage redBird;
PImage boxImg;

FWorld world;
FPoly floor;

//player ball+target=fbodies
FCircle ballBody;
FCircle targetBody;
boolean ballMoving=false;

int mode=0;      //0=intro,1=game
boolean charging=false;
int chargeFrames=0;
int maxChargeFrames=60;

void setup(){
  size(1000,800);

  redBird=loadImage("red-bird.png");
  boxImg=loadImage("boxImg.png");
  boxImg.resize(40,40);

  makeWorld();
  makeFloor();
  makeBallAndTarget();

  mode=0;
}

void makeWorld(){
  Fisica.init(this);
  world=new FWorld();
  world.setGravity(0,900);
}

void makeFloor(){
  floor=new FPoly();
  floor.vertex(0,800);
  floor.vertex(0,700);
  floor.vertex(50,710);
  floor.vertex(75,745);
  floor.vertex(110,760);
  floor.vertex(125,690);
  floor.vertex(200,680);
  floor.vertex(200,700);
  floor.vertex(300,730);
  floor.vertex(315,670);
  floor.vertex(350,650);
  floor.vertex(400,600);
  floor.vertex(420,555);
  floor.vertex(500,550);
  floor.vertex(560,450);
  floor.vertex(660,600);
  floor.vertex(680,600);
  floor.vertex(750,470);
  floor.vertex(785,670);
  floor.vertex(800,770);
  floor.vertex(900,600);
  floor.vertex(1000,600);
  floor.vertex(1000,800);

  floor.setStatic(true);
  floor.setFillColor(green);
  floor.setFriction(0.6);

  world.add(floor);
}

void makeBallAndTarget(){
  ballBody=new FCircle(15);
  ballBody.setPosition(100,500);
  ballBody.setDensity(1);
  ballBody.setFriction(0.8);
  ballBody.setRestitution(0.4);
  ballBody.setFillColor(yellow);
  world.add(ballBody);
  ballMoving=false;

  targetBody=new FCircle(25);
  targetBody.setPosition(750,480); //right hill area
  targetBody.setStatic(true);
  targetBody.setFillColor(red);
  world.add(targetBody);
}

void draw(){
  background(blue);

  if(mode==0){
    drawIntro();
  }else if(mode==1){
    drawGame();
  }
}

void drawIntro(){
  println("x:"+mouseX+" y:"+mouseY);
  fill(255);
  textAlign(CENTER,CENTER);
  textSize(36);
  text("Derpy Golf Game",width/2,height/2-40);
  textSize(18);
  text("Aim with MOUSE/Hold SPACE to charge/Release SPACE to shoot/Press ENTER to start",
       width/2,height/2+40);
}

void drawGame(){
  world.step();
  world.draw();

  if(ballMoving==true){
    float vx=ballBody.getVelocityX();
    float vy=ballBody.getVelocityY();
    if(vx<0.5 && vx>-0.5 && vy<0.5 && vy>-0.5){
      ballMoving=false;
      ballBody.setVelocity(0,0);
    }
  }

  if(ballMoving==false && charging==false){
    stroke(255,200,0);
    float bx=ballBody.getX();
    float by=ballBody.getY();
    line(bx,by,mouseX,mouseY);
  }

  if(charging==true){
    chargeFrames=chargeFrames+1;
    fill(0,0,0,80);
    rect(20,20,200,20);
    float powerRatio=(float)chargeFrames/maxChargeFrames;
    powerRatio=constrain(powerRatio,0,1);
    fill(255,200,0);
    rect(20,20,200*powerRatio,20);
    fill(255);
    textAlign(LEFT,CENTER);
    textSize(14);
    text("Power",230,30);
  }

  if(frameCount%80==0){
    makeCircle();
    makeBlob();
    makeBox();
    makeBird();
  }
}

void keyPressed(){
  if(key==ENTER || key==RETURN){
    if(mode==0){
      mode=1;
    }
  }
  if(mode==1 && key==' ' && ballMoving==false && charging==false){
    charging=true;
    chargeFrames=0;
  }
}

void keyReleased() {
  if (mode==1 && key==' ' && charging==true && ballMoving==false) {
    charging=false;

    float power=map(chargeFrames,0,maxChargeFrames,5,20);
    power=constrain(power,5,20);

    float vx=power; 
    float vy=-power;  

    ballBody.setVelocity(vx,vy);
    ballMoving=true;
  }
}
void makeCircle(){
  FCircle circle=new FCircle(30);
  circle.setPosition(random(100,width-100),-20);
  circle.setFillColor(red);
  circle.setFriction(1);
  circle.setRestitution(0.8);
  world.add(circle);
}

void makeBlob(){
  FBlob blob=new FBlob();
  blob.setAsCircle(random(100,width-100),-20,25);
  blob.setFillColor(yellow);
  blob.setFriction(1);
  blob.setRestitution(0.4);
  world.add(blob);
}

void makeBox(){
  FBox box=new FBox(40,40);
  box.setPosition(random(100,width-100),-20);
  box.attachImage(boxImg);
  box.setFriction(1);
  box.setRestitution(0.3);
  world.add(box);
}

void makeBird(){
  FCircle bird=new FCircle(24);
  bird.setPosition(random(100,width-100),-20);
  bird.attachImage(redBird);
  bird.setFriction(1);
  bird.setRestitution(0.5);
  world.add(bird);
}
