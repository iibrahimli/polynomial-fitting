class Point{
  double x, y;
  
  Point(double x, double y){
    this.x = x;
    this.y = y;
  }
  
  Point toScreen(){
    return new Point(x - MARGIN, (height - MARGIN) - y);
  }

  Point toVal(){
    return new Point(x + MARGIN, height - MARGIN - y);
  }
}

double xToScreen(double x){
  return x - MARGIN;
}

double yToScreen(double y){
  return (height - MARGIN) - y;
}
