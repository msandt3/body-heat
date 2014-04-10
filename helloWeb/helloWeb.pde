MuscleMan_Front muscleMan_control,muscleMan_data;
MuscleMan_Back mm_control,mm_data;
void setup(){
  size(600,1000,P2D);
  muscleMan_control = new MuscleMan_Front(new Pt(115,80));
  muscleMan_data = new MuscleMan_Front(new Pt(350,80)); 
  mm_control = new MuscleMan_Back(new Pt(115,350));
  mm_data = new MuscleMan_Back(new Pt(350,350));
}

void draw(){
  background(255);
  fill(0);
  textSize(22);
  text("CONTROL",muscleMan_control.location.x-muscleMan_control.head_radius,muscleMan_control.location.y-30);
  text("YOU",muscleMan_data.location.x-muscleMan_data.head_radius/2.0,muscleMan_data.location.y-30);
  stroke(0);
  fill(255);
  muscleMan_data.relocate();
  muscleMan_control.relocate();
  muscleMan_control.show();
  muscleMan_data.show();
  mm_control.show();
//  mm_data.show();

}

void scaleChest(float s){
  muscleMan_data._chest.scale(s);
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
   // tr = new Triceps(new Pt();
   // new Biceps(new Pt(_chest.location.x-_chest.width,_chest.location.y),new Pt(_chest.location.x+_chest.width,_chest.location.y),15,_chest.width*1.5);
  } 
  void show(){
    ellipseMode(CENTER);
    ellipse(location.x,location.y,head_radius,head_radius);
    rectMode(CORNER);
    location.show();
    ub.show();
    lb.show();
    gl.show();
    gl.left_l.show();
    gl.right_l.show();
    hammys.show();
  }
}

class Triceps{
  Pt left; Pt right;
  float width, arm_length;
  Triceps(Pt ll,Pt rr){
    left = ll;
    right = rr;
    width = 15;
    arm_length=25;
  } 

  void show(){
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
  }
  
//  void scale(float newScale){
//    scale_factor = newScale;
//    width *= scale_factor;
//   // height *= scale_factor;
//  } 
  
}

class UpperBack{
  Pt location;
  float width,height;
  UpperBack(Pt l){
    location=l;
    width = 50;
    height = 50;
  }
  
  void show(){
    location.show();
    rect(location.x, location.y, width,height, 7); 
  }
  
}

class Glutes{
  Pt left_l,right_l;
  float width,height;
  Glutes(Pt l_l,Pt r_l){
    left_l = l_l;
    right_l = r_l;
    width= 25;
    height=25;
  } 
  
  void show(){
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
  }
}

class LowerBack{
  Pt location;
  float width,height;
  LowerBack(Pt l){
    location= l;
    width=50;
    height = 50;
  }
  
  void show(){
    location.show();
    rect(location.x, location.y, width,height, 7); 
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
  
  void show(){
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
  void show(){
    rect(location.x,location.y,width,height,7);
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

	void show(){
		rect(location.x-width, location.y, width,height, 7);
    rect(location.x,location.y,width,height,7);
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

  void show(){
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
 
  void show(){
   
    
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

  void show(){
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

  void show(){
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
  }

  void scale(float newScale){
    scale_factor = newScale;
    width *= scale_factor;
  //  height *= scale_factor;
  }

}
