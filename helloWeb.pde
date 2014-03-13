void setup(){
	
size(600,400,P2D);

}

void draw(){
	background(255);
    fill(50);
	textSize(32);
	text("HELLO WORLD!!!!",100,100);
	Pt p = new Pt(200,200);
	show(p);
}

class Pt {
  
  float x, y;
  
  Pt(float x, float y) {
    this.x = x;
    this.y = y;
  }
  
  float distance(Pt a) {
    return (float) Math.sqrt((this.x-a.x)*(this.x-a.x)+(this.y-a.y)*(this.y-a.y));
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

//  Pt add(float s, vec V) {
//    x += s*V.x; 
//    y += s*V.y; 
//    return this;
//  }                 // P.add(s,V): P+=sV

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
  };

  boolean isInWindow() {
    return(((x<0)||(x>width)||(y<0)||(y>height)));
  };


  
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
}
void show(Pt P) {
  ellipse(P.x, P.y, 6, 6);
}