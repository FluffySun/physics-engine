//Ema Sun
//Derpy sports game

//Teacher's instructions that I need to do:
//1. collisions should happen
//2. Use mouse/keyboard functions
//3. Game modes for each screen

//Notes and instructions i made myself: (below)
//->hit the ball+calculation of the angle (this you can consider to do or not to do) (ufo similar aim calculation)
//add in some features/fun objects
//i kind of wanna make the ball bounce and release like a bullet based on how long the player presses "space" key
//and also i want to make the terrain very creative later
//also we need game modes like intro+multiple game screens (2 to 3 screens)+gameover/win screen+probably lives function
//reset the position of the golf ball every time to the original place when a player loses their life if they throw too far (off the screen)
//you can set that they have 3 tries/lives for each game screen

/*

"object"isTouchingBody."otherobject"
here is the code from my ufo project you can learn from and use:
class UFO extends GameObject {
  float w;
  float h;

  int shootCooldown;
  int shootGapMin=30;
  int shootGapMax=70;

  UFO(){
    //spawns offscreen->left/right & horizontal move & randm shoot cooldown
    dead=false;
    w=40;
    h=20;

    if(random(1)<0.5){
      float ly=random(40,height-40);
      loc=new PVector(-w,ly);
      float vx=random(1.0,2.5);
      vel=new PVector(vx,0);
    }else{
      float ly=random(40,height-40);
      loc=new PVector(width+w,ly);
      float vx=random(-2.5,-1.0);
      vel=new PVector(vx,0);
    }

    shootCooldown=int(random(shootGapMin,shootGapMax));
  }

  void act(){
    //moves it+disappear+countdown+fires->player when ready
    loc.x+=vel.x;
    loc.y+=vel.y;

    if(loc.x<-w*2||loc.x>width+w*2) {
      dead=true;
    }

    shootCooldown--;
    if(shootCooldown<0) {
      shootCooldown=0;
    }

    if(shootCooldown==0 && !dead){
      float dx=player1.loc.x-loc.x;
      float dy=player1.loc.y-loc.y;
      float m=dist(0,0,dx,dy);
      float nx=0, ny=0;
      if(m>0){ nx=dx/m; ny=dy/m; }

      PVector v=new PVector(nx*6.0, ny*6.0);
      bullets.add(new Bullet(loc.x,loc.y,v,true));

      shootCooldown=int(random(shootGapMin,shootGapMax));
    }
  }

  void show(){
    //draw
    pushMatrix();
    translate(loc.x,loc.y);
    noStroke();
    fill(100,255,200);
    ellipse(0,0,w,h);
    fill(30);
    ellipse(0,0,w*0.5,h*0.5);
    popMatrix();
  }
}

//another file

class UfoBullet {
  PVector loc;
  PVector vel;
  boolean dead;
  int timer;

  UfoBullet(float x,float y,PVector v){
    //creates a UFO bullet @ (x,y) moving with vel=v
    loc=new PVector(x,y);
    vel=new PVector(v.x,v.y);
    dead=false;
    timer=240;
  }

  void act(){
    //moves bullet->disappear it+leaves screen=no longerX
    loc.x+=vel.x;
    loc.y+=vel.y;
    timer--;
    if(timer<=0) dead=true;

    float r=4;
    if(loc.x<-r) dead=true;
    else if(loc.x>width+r) dead=true;
    if(loc.y<-r) dead=true;
    else if(loc.y>height+r) dead=true;
  }

  void show(){
    //draw bullet
    noStroke();
    fill(255,120,120);
    ellipse(loc.x,loc.y,6,6);
  }
}

*/
