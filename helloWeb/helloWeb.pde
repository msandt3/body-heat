MuscleMan muscleMan;
void setup(){
  size(600,400,P2D);
  muscleMan = new MuscleMan(new Pt(200,50));
  muscleMan._chest.scale(.5);
}

void draw(){
  background(255);
  noFill();
  stroke(0);
  muscleMan.show();
  fill(255,0,0);
  muscleMan._chest.location.show();

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

// class Line{
//   Pt start, end;
//   Line(Pt a, Pt b){
//     start = a;
//     end = b;
//   }
//   show(){
//     line(start.x,start.y,end.x,end.y);
//   }
// }

class MuscleMan{
	Chest _chest;
  Torso _torso;
  Quads _quads;
  Calves _calves;
  Biceps _biceps;
  Pt location;
  float head_radius;
	MuscleMan(Pt loc){
    location = loc;
    head_radius = 50;
	  _chest = new Chest(new Pt(location.x,location.y+head_radius/2));
    _torso = new Torso(new Pt(location.x-_chest.width/2,_chest.location.y+_chest.height/2))
    _quads = new Quads(new Pt(_torso.location.x+7,_torso.location.y+_torso.height+7),new Pt(_torso.location.x+_torso.width-7,_torso.location.y+_torso.height+7),20);
    _calves = new Calves(new Pt(_quads.left_location.x-_quads.width/2.0,_quads.left_location.y+50),new Pt(_quads.right_location.x+_quads.width/2.0,_quads.right_location.y),15);
    _biceps = new Biceps(new Pt(_chest.x,_chest.y),new Pt(_chest.x+_chest.width,_chest.y),15);
	} 


	void show(){
    ellipseMode(CENTER);
    ellipse(location.x,location.y,head_radius,head_radius);
		_chest.show();
    //draw the quads
    _quads.show();
    //draw the calves
    _calves.show();
     //draw the torso
    _torso.show();
    //draw the right arm
    // line(_chest.location.x+_chest.width-7,_chest.location.y,_chest.location.x+_chest.width+55,_chest.location.y+55);
    // //draw the left arm
    // line(_chest.location.x-_chest.width+7,_chest.location.y,_chest.location.x-_chest.width-55,_chest.location.y+55);
    // //draw the left leg
    // line(_torso.location.x+7,_torso.location.y+_torso.height,_torso.location.x-15,_torso.location.y+_torso.height+70);   
    // //draw the right leg
    // line(_torso.location.x-7+_torso.width,_torso.location.y+_torso.height,_torso.location.x+15+_torso.width,_torso.location.y+_torso.height+70);

	}
}

class Torso{
  Pt location;
  float height,width;
  public Torso(Pt loc){
    location = loc;
    width = 50;
    height = 50;
  }
  void show(){
    rect(location.x,location.y,width,height,7);
  }

}

class Chest{

	Pt location; //the center location of the chest object
	float scale_factor,width,height;

	Chest(Pt loc){
		location = loc;
		scale_factor = 1;
    width = 50;
    height = 50;
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

  float width,length;
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
}

class Calves{
  float width;
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
}

class Biceps{
  float width;
  Pt left_location,right_location;
  Biceps(Pt l_loc,Pt r_loc,float w){
    left_location = l_loc;
    right_location = r_loc;
    width = w;
  }

  void show(){
    pushMatrix();
    translate(right_location.x,right_location.y);
    ellipse(0,0,width);
    popMatrix();
  }


}