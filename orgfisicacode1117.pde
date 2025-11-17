//Ema Sun
//1-4
//Programming 12

//PImage bird=loadImage("bird.png");

import fisica.*;

//palette
color blue   = color(29, 178, 242);
color brown  = color(166, 120, 24);
color green  = color(74, 163, 57);
color red    = color(224, 80, 61);
color yellow = color(242, 215, 16);

//assets
PImage redBird;
PImage boxImg;

FPoly leftPlatform; 
FPoly bottomPlatform;

//fisica
FWorld world;

boolean generateOn = true;
boolean gravityOn = true;

boolean mouseReleased;
boolean WasPressed;

Button[] myButtons;

//NEW ADDED 11.17
boolean newLivesOn;
boolean gravityOff;
button gravityButton;
button newFBodiesButton;
//NEW

float cloudx=-200, cloudy=120;
float cloud2x=-260, cloud2y=220;
float cloudspeed=2;
float cloud2speed=3;

boolean mouseIsPressed=false;

void setup() {
  //make window
  size(800, 600);
  
  //load resources
  redBird = loadImage("red-bird.png");
  boxImg = loadImage ("boxImg.png");
  boxImg.resize (40,40);
  
  //initialise world
  makeWorld();

  //add terrain to world
  makeLeftPlatform();
  makeBottomPlatform();
  
  //NEW 11.17
  gravityButton= new Button ("gravity", 80, 550, 80, 80, yellow, red);
  newFbodiesButton= new Button ("new", 700, 50, 80, 80, green, yellow);
  //NEW 11.17

}

//===========================================================================================

void makeWorld() {
  Fisica.init(this);
  world = new FWorld();
  world.setGravity(0, 900);
}

//===========================================================================================

void makeLeftPlatform() { //this is the brown thing
  leftPlatform = new FPoly(); 
  //add some extra vertixes

  //plot the vertices of this platform
  leftPlatform.vertex(250, 180);
  //leftPlatform.vertex(270, 180);
  //leftPlatform.vertex(270, 360);
  leftPlatform.vertex(250, 360);
  leftPlatform.vertex(530, 360);
  leftPlatform.vertex(530, 180);
  leftPlatform.vertex(510, 180);
  leftPlatform.vertex(510, 340);
  leftPlatform.vertex(270, 340);
  leftPlatform.vertex(270, 180);

  // define properties
  leftPlatform.setStatic(true);
  leftPlatform.setFillColor(brown);
  leftPlatform.setFriction(0.1);
 
  //put it in the world
  world.add(leftPlatform);
}

//===========================================================================================

void makeBottomPlatform() {
  bottomPlatform = new FPoly();

  //plot the vertices of this platform
  bottomPlatform.vertex(900, 350);
  bottomPlatform.vertex(300, 500);
  bottomPlatform.vertex(300, 600);
  bottomPlatform.vertex(900, 450);

  // define properties
  bottomPlatform.setStatic(true);
  bottomPlatform.setFillColor(brown);
  bottomPlatform.setFriction(0);

  //put it in the world
  world.add(bottomPlatform);
}


//===========================================================================================

void draw() {
  click();
  int i = 0;
  while (i<4) {
    myButtons[i].show(); 
    if (myButtons[i].clicked) {
      bkg = myButtons[i].normal;
    }
    i++;

  println("x: " + mouseX + " y: " + mouseY);
  background(blue);
  
  world.step();
  world.draw();
  
  drawCloud(cloudx, cloudy);
  cloudx+=cloudspeed;
  if (cloudx>width+200){
    cloudx=-200;
  }

  if (generateOn && frameCount % 50 == 0) {
    makeCircle();
    makeBlob();
    makeBox();
    makeBird();
  }

  //in front of everything/bodies
  drawCloud(cloud2x, cloud2y);
  cloud2x=cloud2speed;
  if (cloud2x>width+200) {
    cloud2x=-200;
  }  
    if (generateOn && frameCount % 50 == 0) {
    makeCircle();
    makeBlob();
    makeBox();
    makeBird();
  }

  //in front of everything/bodies
  drawCloud(cloud2x, cloud2y);
  cloud2x += cloud2speed;
  if (cloud2x > width+200) {
    cloud2x = -200;
  }  

  if (newFBodiesButton.click()) {
    newLivesOn=!newLivesOn;
  }
  
  if (gravityButton.click()) {
    gravityOff=!gravityOff;
    gravityOff;
  }
}


//===========================================================================================

void makeCircle() {
  FCircle circle = new FCircle(50);
  circle.setPosition(random(100,width-100), -5);

  //set visuals
  circle.setStroke(0);
  circle.setStrokeWeight(2);
  circle.setFillColor(red);

  //set physical properties
  circle.setDensity(0.2);
  circle.setFriction(1);
  circle.setRestitution(1);

  //add to world
  world.add(circle);
}

//===========================================================================================

void makeBlob() {
  FBlob blob = new FBlob();

  //set visuals
  blob.setAsCircle(random(100,width-100), -5, 50);
  blob.setStroke(0);
  blob.setStrokeWeight(2);
  blob.setFillColor(yellow);

  //set physical properties
  blob.setDensity(0.2);
  blob.setFriction(1);
  blob.setRestitution(0.25);

  //add to the world
  world.add(blob);
}

//===========================================================================================

//void makeBox() {
//  FBox box = new FBox(25, 100);
//  box.setPosition(random(100,width-100), -5);

//  //set visuals
//  box.setStroke(0);
//  box.setStrokeWeight(2);
//  box.setFillColor(green);

//  //set physical properties
//  box.setDensity(0.2);
//  box.setFriction(1);
//  box.setRestitution(0.25);
//  world.add(box);
//}

void makeBox() {
  FBox box = new FBox(40, 40);
  box.setPosition(random(100, width-100), -5);

  box.attachImage(boxImg);

  //set physical properties
  box.setDensity(0.2);
  box.setFriction(1);
  box.setRestitution(0.25);
  world.add(box);
}


//===========================================================================================

void makeBird() {
  FCircle bird = new FCircle(48);
  bird.setPosition(random(100,width-100), -5);

  //set visuals
  bird.attachImage(redBird);

  //set physical properties
  bird.setDensity(0.8);
  bird.setFriction(1);
  bird.setRestitution(0.5);
  world.add(bird);
}

//back of bodies
void drawCloud(float x, float y) {
  noStroke();
  fill(255,255,255,230);
  ellipse(x+40,y+20,80,60);
  ellipse(x+80,y+10,90,70);
  ellipse(x+120,y+20,70,60);
  ellipse(x+10,y+30,70,50);
  ellipse(x+95,y+35,100,60);
}

//gravity
void gravityOff() {
  if (gravityOff==true) {
    world.setGravity(0,0);
  }
  else {
    world.setGravity (0, 900);
  }
}
