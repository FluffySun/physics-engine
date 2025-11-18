//Ema Sun
//1-4
//Programming 12

import fisica.*;

//palette
color blue= color(29, 178, 242);
color brown= color(166, 120, 24);
color green= color(74, 163, 57);
color red= color(224, 80, 61);
color yellow= color(242, 215, 16);

//assets
PImage redBird;
PImage boxImg;

FPoly leftPlatform; 
FPoly bottomPlatform;

//fisica
FWorld world;

boolean generateOn = true; 
boolean gravityOff = false;  

//buttons
Button gravityButton;
Button newFBodiesButton;

float cloudx=-200, cloudy=120;
float cloud2x=-260, cloud2y=220;
float cloudspeed=2;
float cloud2speed=3;

void setup() {
  size(800, 600);
  
  redBird = loadImage("red-bird.png");
  boxImg = loadImage ("boxImg.png");
  boxImg.resize (40,40);
  
  //initialize world
  makeWorld();

  //add terrain to world
  makeLeftPlatform();
  makeBottomPlatform();
  
  gravityButton= new Button("Gravity", 80, 550, 120, 40, yellow, red);
  newFBodiesButton= new Button("New Bodies", 600, 50,  140, 40, green, yellow);
}

//===========================================================================================

void makeWorld() {
  Fisica.init(this);
  world=new FWorld();
  world.setGravity(0, 900);
}

//===========================================================================================

void makeLeftPlatform() {
  leftPlatform = new FPoly(); 

  leftPlatform.vertex(250, 180);
  leftPlatform.vertex(250, 360);
  leftPlatform.vertex(530, 360);
  leftPlatform.vertex(530, 180);
  leftPlatform.vertex(510, 180);
  leftPlatform.vertex(510, 340);
  leftPlatform.vertex(270, 340);
  leftPlatform.vertex(270, 180);

  leftPlatform.setStatic(true);
  leftPlatform.setFillColor(brown);
  leftPlatform.setFriction(0.1);
 
  world.add(leftPlatform);
}

//===========================================================================================

void makeBottomPlatform() {
  bottomPlatform= new FPoly();

  bottomPlatform.vertex(900, 350);
  bottomPlatform.vertex(300, 500);
  bottomPlatform.vertex(300, 600);
  bottomPlatform.vertex(900, 450);

  bottomPlatform.setStatic(true);
  bottomPlatform.setFillColor(brown);
  bottomPlatform.setFriction(0);

  world.add(bottomPlatform);
}

//===========================================================================================

void draw() {
  println("x: "+mouseX+"y:"+mouseY);
  background(blue);
  
  //behind cloud
  drawCloud(cloudx, cloudy);
  cloudx+=cloudspeed;
  if (cloudx>width+200){
    cloudx=-200;
  }

  world.step();
  world.draw();
  
  if (generateOn && frameCount % 50 == 0) {
    makeCircle();
    makeBlob();
    makeBox();
    makeBird();
  }

  //front cloud
  drawCloud(cloud2x, cloud2y);
  cloud2x+=cloud2speed;
  if (cloud2x>width+200) {
    cloud2x=-200;
  }  

  //buttons
  gravityButton.show();
  newFBodiesButton.show();

  //currently, the generate buttons are not controlling whether the Fbodies will keep on generating or stop (need to do this)
  if (newFBodiesButton.click()) {
    generateOn=!generateOn; 
  }
  
  //currently, the gravity buttons are not working for some reason
  
  if (gravityButton.click()) {
    gravityOff=!gravityOff; 
    gravityOnOff();         
  }
}

//===========================================================================================

//makecircle

void makeCircle() {
  FCircle circle = new FCircle(50);
  circle.setPosition(random(100,width-100),-5);
  circle.setStroke(0);
  circle.setStrokeWeight(2);
  circle.setFillColor(red);
  circle.setDensity(0.2);
  circle.setFriction(1);
  circle.setRestitution(1);
  world.add(circle);
}

//===========================================================================================

void makeBlob() {
  FBlob blob = new FBlob();

  blob.setAsCircle(random(100,width-100), -5, 50);
  blob.setStroke(0);
  blob.setStrokeWeight(2);
  blob.setFillColor(yellow);

  blob.setDensity(0.2);
  blob.setFriction(1);
  blob.setRestitution(0.25);

  world.add(blob);
}

//===========================================================================================

void makeBox() {
  FBox box = new FBox(40, 40);
  box.setPosition(random(100, width-100), -5);

  box.attachImage(boxImg);

  box.setDensity(0.2);
  box.setFriction(1);
  box.setRestitution(0.25);
  world.add(box);
}

//===========================================================================================

void makeBird() {
  FCircle bird = new FCircle(48);
  bird.setPosition(random(100,width-100), -5);

  bird.attachImage(redBird);

  bird.setDensity(0.8);
  bird.setFriction(1);
  bird.setRestitution(0.5);
  world.add(bird);
}

//===========================================================================================

void drawCloud(float x, float y) {
  noStroke();
  fill(255,255,255,230);
  ellipse(x+40,y+20,80,60);
  ellipse(x+80,y+10,90,70);
  ellipse(x+120,y+20,70,60);
  ellipse(x+10,y+30,70,50);
  ellipse(x+95,y+35,100,60);
}

//===========================================================================================

void gravityOnOff() {
  if (gravityOff == true) {
    world.setGravity(0, 0); 
  } else {
    world.setGravity(0, 900); 
  }
}

class Button {
  String label;
  float x, y, w, h;
  color normal;
  color hover;
  
  Button(String label,float x,float y,float w,float h,color normal,color hover) {
    this.label=label;
    this.x=x;
    this.y=y;
    this.w=w;
    this.h=h;
    this.normal=normal;
    this.hover=hover;
  }
  
  void show() {
    if (over(mouseX, mouseY)) { //mouse control hover codes
      fill(hover);
    } else {
      fill(normal);
    }
    stroke(0);
    rect(x, y, w, h, 8);

    fill(0);
    textAlign(CENTER, CENTER);
    textSize(14);
    text(label,x+w/2,y+h/2);
  }

//change

  boolean click() {
    return (mousePressed && !mousePressed && over(mouseX, mouseY));
  }
  
  boolean over(float mx, float my) {
    return (mx>x && mx<x+w && my>y && my<y+h);
  }
}
