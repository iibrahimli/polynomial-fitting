final float MARGIN = 10;
final float POINTSIZE = 3;
final double STEP = 0.1;
boolean showText = true;

Matrix m;                   // augmented matrix to solve
ArrayList<Point> data;      // data points
ArrayList<Point> poly;      // polynomial vertexes for drawing
double[] coef;              // polynomial coefficients

void setup(){
  size(800, 600);
  data = new ArrayList<Point>();
  poly = new ArrayList<Point>();
  ellipseMode(RADIUS);
}

void draw(){
  background(250);
  drawAxes();
  if(data.size() != 0) drawPolynomial();
  for(Point i : data){
    drawPoint(i);
  }
}

void drawAxes(){
  stroke(0);
  strokeWeight(2);
  line(MARGIN, height-MARGIN, width-MARGIN, height-MARGIN);
  line(MARGIN, height-MARGIN, MARGIN, MARGIN);
}

void drawPoint(Point a){
  noStroke();
  fill(255, 50, 10);
  ellipse((float) (a.x+MARGIN), (float) (height-MARGIN-a.y), POINTSIZE, POINTSIZE);
  fill(80);
  if(showText) text("("+a.x+", "+a.y+")", (float) (a.x+MARGIN+POINTSIZE), (float) (height-MARGIN-a.y-POINTSIZE));
}

void constructMatrix(){
  m = new Matrix(data.size(), data.size()+1);
  
  for(int i=0; i<data.size(); i++){
    for(int j=0; j<data.size(); j++){
      m.mat[i][j] = Math.pow(data.get(i).x, data.size()-1-j);
      //print("for mat["+i+"]["+j+"]: "+data.get(i).x+"^"+(data.size()-1-j)+" = "+m.mat[i][j]+"\n");
    }
  }
  
  for(int i=0; i<data.size(); i++){
    m.mat[i][data.size()] = data.get(i).y;
  }
}

void constructPolynomialVertexes(double[] coef){
  poly.clear();
  poly = new ArrayList<Point>();
  double y;
  
  for(double x=0; x<=width; x+=STEP){
    y = 0;
    for(int i=coef.length-1; i>=0; i--){
      y += Math.pow(xToScreen(x), i) * coef[i];
    }
    poly.add(new Point(x, yToScreen(y)));
  }
  
}

//void drawPolynomial(){
//  strokeWeight(2);
//  stroke(50, 150, 250, 100);
//  beginShape(LINES);
//  for(Point i : poly){
//    vertex((float)i.x, (float)i.y);
//  }
//  endShape();
//}

void drawPolynomial(){
  strokeWeight(2);
  stroke(50, 150, 250, 100);
  Point prev = poly.get(0);
  for(int i=1; i<poly.size(); i++){
    line((float)poly.get(i).x, (float)poly.get(i).y, (float) prev.x, (float) prev.y);
    prev = poly.get(i);
  }
}

void mouseClicked(){
  data.add(new Point(mouseX-MARGIN, height-MARGIN-mouseY));

  constructMatrix();
  //m.printe();
  
  double[] temp = m.gaussianElim();
  coef = temp.clone();
  
  for(int i=0; i<temp.length; i++) coef[i] = temp[temp.length-1-i];
  
  print("y(x) = ");
  for(int i=coef.length-1; i>0; i--) print(coef[i]+"*x^"+i, " + ");
  print(coef[0]+"\n");
  constructPolynomialVertexes(coef);
  
}

void keyPressed(){
  if(key == ' ') showText = !showText;
}
