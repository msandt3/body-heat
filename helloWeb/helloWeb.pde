MuscleMan_Front muscleMan_control,muscleMan_data;
MuscleMan_Back mm_control,mm_data;
void setup(){

  //Set up screen size
  size(600,600,P2D);
  
  //Set up default Chernoff Bodies.
  muscleMan_control = new MuscleMan_Front(new Pt(115,80));
  muscleMan_data = new MuscleMan_Front(new Pt(350,80)); 
  mm_control = new MuscleMan_Back(new Pt(115,350));
  mm_data = new MuscleMan_Back(new Pt(350,350));

  
}

void draw(){
  //draw background color
  background(255);
  fill(0);
  
  //Set text Font
  textSize(22);
  text("CONTROL",muscleMan_control.location.x-muscleMan_control.head_radius,muscleMan_control.location.y-30);
  text("YOU",muscleMan_data.location.x-muscleMan_data.head_radius/2.0,muscleMan_data.location.y-30);
  stroke(0);
  fill(255);
  
  muscleMan_data.relocate();
  muscleMan_control.relocate();
  muscleMan_control.show();
  muscleMan_data.show();
  mm_control.relocate();
  mm_data.relocate();
  mm_control.show();
  mm_data.show();

}

void scaleChest(float s){
  muscleMan_data._chest.scale(s);
}

void scaleBiceps(float s){
  muscleMan_data._biceps.scale(s);

}

void scaleCalves(float s){
  muscleMan_data._calves.scale(s);
}

void scaleForearm(float s){
  muscleMan_data._forearms.scale(s);
}

void scaleQuads(float s){
  muscleMan_data._quads.scale(s);
}

void scaleTriceps(float s){
  mm_data.tr.scale(s);

}
  
void scaleUpperBack(float s){
  mm_data.ub.scale(s);
}

void scaleLowerBack(float s){
  mm_data.lb.scale(s); 
}

void scaleGlutes(float s){
  mm_data.gl.scale(s);
}
  
void scaleHammies(float s){
  mm_data.hammys.scale(s);
}

void scaleShoulders(float s){
  muscleMan_data.shoulder.scale(s);
}







class MuscleMan_Back{
  Pt location;
  float head_radius;
  UpperBack ub; LowerBack lb;
  Glutes gl; Hamstrings hammys;
  Triceps tr;
 
  MuscleMan_Back(Pt loc){
    location = loc;
    head_radius = 50;
    ub = new UpperBack(new Pt(location.x-head_radius/2.0,location.y+head_radius/2.0));
    lb = new LowerBack(new Pt(location.x-head_radius/2.0,ub.location.y+ub.height));
    gl = new Glutes(new Pt(location.x-lb.width/4.0,location.y+ub.height+lb.height+head_radius/2.0),
      new Pt(location.x+lb.width/4.0,location.y+ub.height+lb.height+head_radius/2.0));
    hammys = new Hamstrings(new Pt(gl.left_l.x,gl.left_l.y+gl.height),new Pt(gl.right_l.x,gl.right_l.y+gl.height));
    tr = new Triceps(new Pt(location.x-head_radius/2.0,location.y+head_radius/2.0),new Pt(location.x+head_radius/2.0,location.y+head_radius/2.0));
    
  } 
  
  void relocate(){
    ub.location = new Pt(location.x,location.y+head_radius);
    lb.location = new Pt(location.x,ub.location.y+ub.height);
    gl.left_l= new Pt(location.x-lb.width/4.0,location.y+ub.height+lb.height+head_radius/2.0);
    gl.right_l= new Pt(location.x+lb.width/4.0,location.y+ub.height+lb.height+head_radius/2.0);
    hammys.left_l = new Pt(gl.left_l.x,gl.left_l.y+hammys.height-5);
    hammys.right_l= new Pt(gl.right_l.x,gl.right_l.y+hammys.height-5);
    tr.left = new Pt(location.x-ub.width/2.0,location.y+head_radius/2.0);
    tr.right=new Pt(location.x+ub.width/2.0,location.y+head_radius/2.0);
  }
  
  void show(){
  	//Draw Head
    ellipseMode(CENTER);
    ellipse(location.x,location.y,head_radius,head_radius);
    rectMode(CORNER);
    //location.show();
    
    //Drawing Upper Back
    ub.show();
    //Draw lower back
    lb.show();
    //Draw glutes
    gl.show();
    //draw hammys
    hammys.show();
    //Draw triceps
    tr.show();
  }

  boolean mouseOver(Pt mouse){
    return true;
  }

}


class Shoulder{
  Pt left_l, right_l;
  float width, height;
  public Shoulder(Pt l, Pt r,float w){
    left_l = l;
    right_l = r;
    width = w;
    height = 20;
  }
  boolean mouseOver() {     
    float lConX = left_l.x - (width/2);
    float lConY = left_l.y - (height/2);
    float lCon2X = left_l.x + (width/2);
    float lCon2Y = left_l.y + (height/2);
    float rConX = right_l.x - (width/2);
    float rConY = right_l.y - (height/2);
    float rCon2X = right_l.x + (width/2);
    float rCon2Y = right_l.y + (height/2);

   if(mouseX > lConX && mouseX < lCon2X && mouseY > lConY && mouseY < lCon2Y 
       || mouseX > rConX && mouseX < rCon2X && mouseY > rConY && mouseY < rCon2Y )       
      return true;     
   else
      return false;
  }
  
  void show(){
    if(mouseOver())
      fill(229,204,255);
    pushMatrix();
    translate(left_l.x,left_l.y);
    ellipseMode(CENTER);
    ellipse(0,0,width,height);
    popMatrix();
    
    pushMatrix();
    translate(right_l.x,right_l.y);
    ellipseMode(CENTER);
    ellipse(0,0,width,height);
    popMatrix();
    noFill();
    
  }
  
  void scale(float s){
   height*=s; 
  }
}

class Triceps{
  Pt left; Pt right;
  float width, arm_length,scale_factor;
  Triceps(Pt ll,Pt rr){
    left = ll;
    right = rr;
    width = 15;
    arm_length=35;
  }
  
    boolean mouseOver() {     
    float lConX = left.x - (arm_length);
    float lConY = left.y;
    float lCon2X = left.x;
    float lCon2Y = left.y + (width);
    float rConX = right.x;
    float rConY = right.y;
    float rCon2X = right.x + (arm_length);
    float rCon2Y = right.y + (width);

   if(mouseX > lConX && mouseX < lCon2X && mouseY > lConY && mouseY < lCon2Y 
       || mouseX > rConX && mouseX < rCon2X && mouseY > rConY && mouseY < rCon2Y )       
      return true;     
   else
      return false;
  } 

  void show(){
    if(mouseOver())
      fill(229,204,255);
    pushMatrix();
    translate(right.x,right.y);
    ellipseMode(CORNER);
    ellipse(0,0,arm_length,width);
    popMatrix();
    pushMatrix();
    translate(left.x-arm_length,right.y);
    ellipseMode(CORNER);
    ellipse(0,0,arm_length,width);
    popMatrix();
    noFill();
  }
  
  void scale(float newScale){
    scale_factor = newScale;
    width *= scale_factor;
  } 
}

class UpperBack{
  Pt location;
  float width,height,scale_factor;
  UpperBack(Pt l){
    location=l;
    width = 50;
    height = 50;
  }
  boolean mouseOver() {
    // Set up the container for each body part   
    float conX = location.x - (width/2);
    float conY = location.y - (height/2);
    float con2X = location.x + (width/2);
    float con2Y = location.y + (height/2);

   if(mouseX > conX && mouseX < con2X && mouseY > conY && mouseY < con2Y)       
      return true;     
   else
      return false;
  }
  void show(){
    if(mouseOver())
      fill(229,204,255);
    rectMode(CENTER);
    rect(location.x, location.y, width,height, 7);
    noFill(); 
  }
  
  void scale(float sc){
    scale_factor = sc;
    width*=scale_factor; 
  }
  
}

class Glutes{
  Pt left_l,right_l;
  float width,height;
   float lConX;
    float lConY;
    float lCon2X;
    float lCon2Y;
  Glutes(Pt l_l,Pt r_l){
    left_l = l_l;
    right_l = r_l;
    width= 25;
    height=25;
   
  } 
  
  void scale(float s){
    width*=s;
    height*=s;
  }
  boolean mouseOver() {     
    float lConX = left_l.x - (width/2);
    float lConY = left_l.y;
    float lCon2X = left_l.x + (width/2);
    float lCon2Y = left_l.y + (height);
    float rConX = right_l.x - (width/2);
    float rConY = right_l.y;
    float rCon2X = right_l.x + (width/2);
    float rCon2Y = right_l.y + (height);

   if(mouseX > lConX && mouseX < lCon2X && mouseY > lConY && mouseY < lCon2Y 
       || mouseX > rConX && mouseX < rCon2X && mouseY > rConY && mouseY < rCon2Y )       
      return true;     
   else
      return false;
  }
  
  void show(){
   if(mouseOver())
     fill(229,204,255); 
   //Need to apply rotations to ellipses here
    pushMatrix();
    translate(left_l.x,left_l.y+12);
    //rotate(PI/24.0);
    ellipse(0,0,width,height);
    popMatrix();

    pushMatrix();
    translate(right_l.x,right_l.y+12);
    //rotate(11*PI/12.0);
    ellipse(0,0,width,height);
    popMatrix();
    noFill();
  }
}

class LowerBack{
  Pt location;
  float width,height,scale_factor;
  LowerBack(Pt l){
    location= l;
    width=50;
    height = 50;
  }
  boolean mouseOver() {
    // Set up the container for each body part   
    float conX = location.x - (width/2);
    float conY = location.y - (height/2);
    float con2X = location.x + (width/2);
    float con2Y = location.y + (height/2);

   if(mouseX > conX && mouseX < con2X && mouseY > conY && mouseY < con2Y)       
      return true;     
   else
      return false;
  }
  
  void show(){
    
    if(mouseOver())
      fill(229,204,255);
    rect(location.x, location.y, width,height, 7); 
    noFill();
   //location.show();
  } 
  
  void scale(float s){
    scale_factor = s;
    width*=scale_factor;
  }
  
}


class Hamstrings{
  Pt left_l,right_l;
  float width,height;
  Hamstrings(Pt ll,Pt rr){
    left_l=ll;
    right_l=rr;
    width= 20;
    height=30;
  }  
   boolean mouseOver() {     
    float lConX = left_l.x - (width/2);
    float lConY = left_l.y;
    float lCon2X = left_l.x + (width/2);
    float lCon2Y = left_l.y + (height);
    float rConX = right_l.x - (width/2);
    float rConY = right_l.y;
    float rCon2X = right_l.x + (width/2);
    float rCon2Y = right_l.y + (height);

   if(mouseX > lConX && mouseX < lCon2X && mouseY > lConY && mouseY < lCon2Y 
       || mouseX > rConX && mouseX < rCon2X && mouseY > rConY && mouseY < rCon2Y )       
      return true;     
   else
      return false;
  }
  
  void show(){
    if(mouseOver())
      fill(229,204,255);
    pushMatrix();
    translate(left_l.x,left_l.y+12);
    //rotate(PI/24.0);
    ellipse(0,0,width,height);
    popMatrix();

    pushMatrix();
    translate(right_l.x,right_l.y+12);
    //rotate(11*PI/12.0);
    ellipse(0,0,width,height);
    popMatrix();
    noFill();
  }
  void scale(float s){
    width*=s;
   
  } 
}

class Pt {
  
  float x, y;
  
  Pt(float x, float y) {
    this.x = x;
    this.y = y;
  }
  
  float distance(Pt a) {
    return (float) sqrt((this.x-a.x)*(this.x-a.x)+(this.y-a.y)*(this.y-a.y));
  }
  
  void draw() {
    ellipse(this.x, this.y, 10, 10);
  }
  void drawWithNum(int num) {
    fill(255, 0, 0);
    ellipse(this.x, this.y, 100, 100);
    fill(50);
    textSize(50);
    text(num, this.x-4, this.y-4);
  }
  public void move(float dx, float dy) {
    this.x+=dx;
    this.y+=dy;
  }
  
  public void move(Pt delta) {
    this.x+=delta.x;
    this.y+=delta.y;
  }

  public Pt subtract(Pt a) {
    return new Pt(this.x-a.x, this.y-a.y);
  }

  public String toString() {
    return "("+x+","+y+" )";
  }

  Pt add1(float u, float v) {
    x += u; 
    y += v; 
    return this;
  }                       // P.add(u,v): P+=<u,v>

  Pt add2(Pt P) {
    x += P.x; 
    y += P.y; 
    return this;
  };                              // incorrect notation, but useful for computing weighted averages

    Pt add3(float s, Pt P) {
    x += s*P.x; 
    y += s*P.y; 
    return this;
  };               // adds s*P

  void set(Pt p) {
    this.x=p.x;
    this.y=p.y; 
  }

  Pt make() {
    return(new Pt(x, y));
  };

  void show(float r) { 
    pushMatrix(); 
    translate(x, y); 
    sphere(r); 
    popMatrix();
  }

  void showLineTo (Pt P) {
    line(x, y, P.x, P.y);
  }

  void setToPoint(Pt P) { 
    x = P.x; 
    y = P.y; 
  }

  void setToPt(Pt P) { 
    x = P.x; 
    y = P.y;
  } 

  void setTo (float px, float py) {
    x = px; 
    y = py;
  }

  void setToMouse() { 
    x = mouseX; 
    y = mouseY;
  }

  void write() {
    println("("+x+","+y+")");
  };

 


  void vert() {
    vertex(x, y);
  };

    void vertext(float u, float v) {
      vertex(x, y, u, v);
    }

    boolean isInWindow() {
      return(((x<0)||(x>width)||(y<0)||(y>height)));
    }
    
    float disTo(Pt P) {
      return sqrt(sq(P.x-x)+sq(P.y-y));
    }

    void addPt(Pt P) {
      x+=P.x; 
      y+=P.y; 
    }

    void subPt(Pt P) {
      x-=P.x; 
      y-=P.y; 
    }

    void mul(float f) {
    x*=f; 
        y*=f; 
      }

  void show() {
    ellipseMode(CENTER);
      ellipse(x, y, 6, 6);
  }
}



class MuscleMan_Front{
  Chest _chest;
  Torso _torso;
  Quads _quads;
  Calves _calves;
  Biceps _biceps;
  Forearms _forearms;
  Shoulder shoulder; 
  Pt location;
  float head_radius;
  
  MuscleMan_Front(Pt loc){
    location = loc;
    head_radius = 50;
    _chest = new Chest(new Pt(location.x,location.y+head_radius/2));
    _torso = new Torso(new Pt(location.x,_chest.location.y+_chest.height));
    _quads = new Quads(new Pt(_torso.location.x+7,_torso.location.y+_torso.height+7),new Pt(_torso.location.x+_torso.width-7,_torso.location.y+_torso.height+7),20);
    _calves = new Calves(new Pt(_quads.left_location.x-_quads.width/2.0,_quads.left_location.y+50),new Pt(_quads.right_location.x+_quads.width/2.0,_quads.right_location.y),15);
    _biceps = new Biceps(new Pt(_chest.location.x-_chest.width,_chest.location.y),new Pt(_chest.location.x+_chest.width,_chest.location.y),15,_chest.width*1.5);
    _forearms = new Forearms(new Pt(_biceps.left_location.x-_biceps.arm_length,_biceps.left_location.y),
      new Pt(_biceps.right_location.x+_biceps.arm_length,_biceps.right_location.y+_biceps.width*.25),_biceps.width,_biceps.arm_length);
      shoulder = new Shoulder(new Pt(_chest.location.x-_chest.width,_chest.location.y),new Pt(_chest.location.x+_chest.width,_chest.location.y),20.0);
  } 

  void show(){
    ellipseMode(CENTER);
    ellipse(location.x,location.y,head_radius,head_radius);
         rectMode(CENTER);
    _torso.show();

    rectMode(CORNER);
    _chest.show();
    //draw the quads
    
    _quads.show();
    //draw the calves
    _calves.show();
     //draw the torso
    _biceps.show();
    _forearms.show();
    shoulder.show();
//    shoulder.left_l.show();
//    shoulder.right_l.show();    

  }

  void relocate(){
    _biceps.left_location = new Pt(_chest.location.x-_chest.width,_chest.location.y);
    _biceps.right_location = new Pt(_chest.location.x+_chest.width,_chest.location.y);
    _forearms.left_location = new Pt(_biceps.left_location.x-_biceps.arm_length,_biceps.left_location.y);
    _forearms.right_location = new Pt(_biceps.right_location.x+_biceps.arm_length,_biceps.right_location.y+_biceps.width*.25);
    _torso.location = new Pt(location.x,location.y+_chest.height+head_radius);
    _quads.left_location = new Pt(_torso.location.x-_torso.width/2.0,_torso.location.y+_torso.height/2.0+7);
    _quads.right_location = new Pt(_torso.location.x + _torso.width/2.0,_torso.location.y+_torso.height/2.0+7);
    _calves.left_location = new Pt(_quads.left_location.x-_quads.width/2.0,_quads.left_location.y+50);
    _calves.right_location = new Pt(_quads.right_location.x+_quads.width/2.0,_quads.right_location.y);
  }
}

class Torso{
  Pt location;
  float height,width;
  float scale_factor;
  public Torso(Pt loc){
    location = loc;
    width = 50;
    height = 50;
  }
  boolean mouseOver() {
    // Set up the container for each body part   
    float conX = location.x - (width/2);
    float conY = location.y - (height/2);
    float con2X = location.x + (width/2);
    float con2Y = location.y + (height/2);

   if(mouseX > conX && mouseX < con2X && mouseY > conY && mouseY < con2Y)       
      return true;     
   else
      return false;
  }
  void show(){
    if(mouseOver())
      fill(229,204,255);
    rect(location.x,location.y,width,height,7);
    noFill();
  }
  void scale(float newScale){
    scale_factor = newScale;
    width *= scale_factor;
    //height *= scale_factor;
  }

}

class Chest{

  Pt location; //the center location of the chest object
  float scale_factor,width,height;

  Chest(Pt loc){
    location = loc;
    scale_factor = 1;
          width = 25;
          height = 25;
  }
  boolean mouseOver() {     
    float lConX = location.x - (width);
    float lConY = location.y;
    float lCon2X = location.x;
    float lCon2Y = location.y + (height);
    float rConX = location.x;
    float rConY = location.y;
    float rCon2X = location.x + (width);
    float rCon2Y = location.y + (height);

   if(mouseX > lConX && mouseX < lCon2X && mouseY > lConY && mouseY < lCon2Y 
       || mouseX > rConX && mouseX < rCon2X && mouseY > rConY && mouseY < rCon2Y )       
      return true;     
   else
      return false;
  }

  void show(){
   if(mouseOver())
      fill(229,204,255);
    rect(location.x-width, location.y, width,height, 7);
    rect(location.x,location.y,width,height,7);
    noFill();
  }

  void scale(float newScale){
    scale_factor = newScale;
    width *= scale_factor;
    height *= scale_factor;

  }
}

class Quads{

  float width,length,scale_factor;
  Pt left_location,right_location;
  Quads(Pt l_loc,Pt r_loc,float w){
    left_location = l_loc;
    right_location = r_loc;
    width = w;
  }
  boolean mouseOver() {     
    float lConX = left_location.x - (width/2);
    float lConY = left_location.y;
    float lCon2X = left_location.x + (width/2);
    float lCon2Y = left_location.y+width*1.7;
    float rConX = right_location.x - (width/2);
    float rConY = right_location.y;
    float rCon2X = right_location.x + (width/2);
    float rCon2Y = right_location.y +width*1.7;

   if(mouseX > lConX && mouseX < lCon2X && mouseY > lConY && mouseY < lCon2Y 
       || mouseX > rConX && mouseX < rCon2X && mouseY > rConY && mouseY < rCon2Y )       
      return true;     
   else
      return false;
  }
  void show(){
    if(mouseOver())
      fill(229,204,255);
    //Need to apply rotations to ellipses here
    pushMatrix();
    translate(left_location.x,left_location.y+12);
    rotate(PI/24.0);
    ellipse(0,0,width,40);
    popMatrix();

    pushMatrix();
    translate(right_location.x,left_location.y+12);
    rotate(11*PI/12.0);
    ellipse(0,0,width,40);
    popMatrix();
    noFill();

  }

  void scale(float newScale){
    scale_factor = newScale;
    width *= scale_factor;
    //height *= scale_factor;
  }
}

class Calves{
  float width,scale_factor;
  Pt left_location,right_location;
  Calves(Pt l_loc,Pt r_loc,float w){
    left_location = l_loc;
    right_location = r_loc;
    width = w;
  }
     boolean mouseOver() {     
    float lConX = left_location.x - (width/2);
    float lConY = left_location.y-20;
    float lCon2X = left_location.x + (width/2);
    float lCon2Y = left_location.y+(width*1.5);
    float rConX = right_location.x - (width)+4;
    float rConY = right_location.y+30;
    float rCon2X = right_location.x;
    float rCon2Y = right_location.y +(width*2.5)+30;

   if(mouseX > lConX && mouseX < lCon2X && mouseY > lConY && mouseY < lCon2Y 
       || mouseX > rConX && mouseX < rCon2X && mouseY > rConY && mouseY < rCon2Y )       
      return true;     
   else
      return false;
  }
  void show(){
   
    if(mouseOver())
      fill(229,204,255);
    pushMatrix();
    translate(left_location.x,left_location.y);
    rotate(PI/24.0);
    ellipse(0,0,width,40);
    popMatrix();

    pushMatrix();
    translate(right_location.x,left_location.y);
    rotate(11*PI/12.0);
    ellipse(0,0,width,40);
    popMatrix();
    noFill();

    // ellipse(left_location.x,left_location.y,left_location.x+width,left_location.y+50);
    // ellipse(right_location.x,right_location.y,right_location.x+width,right_location.y+50);
  }

  void scale(float newScale){
    scale_factor = newScale;
    width *= scale_factor;
  //  height *= scale_factor;
  }
}

class Biceps{
  float width,scale_factor;
  float arm_length;
  Pt left_location,right_location;
  Biceps(Pt l_loc,Pt r_loc,float w,float a_length){
    left_location = l_loc;
    right_location = r_loc;
    width = w;
    arm_length = a_length;
  }
  
   boolean mouseOver() {     
    float lConX = left_location.x - (arm_length);
    float lConY = left_location.y;
    float lCon2X = left_location.x;
    float lCon2Y = left_location.y + (width);
    float rConX = right_location.x;
    float rConY = right_location.y;
    float rCon2X = right_location.x + (arm_length);
    float rCon2Y = right_location.y + (width);

   if(mouseX > lConX && mouseX < lCon2X && mouseY > lConY && mouseY < lCon2Y 
       || mouseX > rConX && mouseX < rCon2X && mouseY > rConY && mouseY < rCon2Y )       
      return true;     
   else
      return false;
  } 

  void show(){
    if(mouseOver())
      fill(229,204,255);
    pushMatrix();
    translate(right_location.x,right_location.y);
    ellipseMode(CORNER);
    ellipse(0,0,arm_length,width);
    popMatrix();
    pushMatrix();
    translate(left_location.x-arm_length,right_location.y);
    ellipseMode(CORNER);
    ellipse(0,0,arm_length,width);
    popMatrix();
    noFill();
  }
  
  void scale(float newScale){
    scale_factor = newScale;
    width *= scale_factor;
   // height *= scale_factor;
  }


}

class Forearms{
  float width,scale_factor;
  float length;
  Pt left_location, right_location;
  Forearms(Pt l_loc,Pt r_loc,float w, float l){
    left_location = l_loc;
    right_location = r_loc;
    width = w;
    length = l;
  }
   boolean mouseOver() {     
    float lConX = left_location.x - (length);
    float lConY = left_location.y;
    float lCon2X = left_location.x;
    float lCon2Y = left_location.y + (width);
    float rConX = right_location.x;
    float rConY = right_location.y;
    float rCon2X = right_location.x + (length);
    float rCon2Y = right_location.y + (width);

   if(mouseX > lConX && mouseX < lCon2X && mouseY > lConY && mouseY < lCon2Y 
       || mouseX > rConX && mouseX < rCon2X && mouseY > rConY && mouseY < rCon2Y )       
      return true;     
   else
      return false;
  } 
  
  void show(){
   if(mouseOver())
      fill(229,204,255);
    pushMatrix();
    translate(right_location.x,right_location.y);
    ellipseMode(CORNER);
    ellipse(0,0,length,width);
    popMatrix();
    pushMatrix();
    translate(left_location.x-length,right_location.y);
    ellipseMode(CORNER);
    ellipse(0,0,length,width);
    popMatrix();
    noFill();
  }

  void scale(float newScale){
    scale_factor = newScale;
    width *= scale_factor;
  //  height *= scale_factor;
  }

}
