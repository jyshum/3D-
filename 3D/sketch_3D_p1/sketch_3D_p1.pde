float rotx, roty;

void setup() {
  size(800, 800, P3D);
  //rotx = radians(45);
  //roty = radians(45);
}

void draw() {
  background(255);
  translate(width/2, height/2);
  rotateX(rotx);
  rotateY(roty);
  //rotateZ();
  fill(255);
  stroke(0);
  strokeWeight(3);
  box(100, 100, 100);
}

void mouseDragged() {
  rotx = rotx + (pmouseY - mouseY)*0.01;
  roty = roty + (pmouseX - mouseX)*-0.01; // multiply by negati`ve because if you turn right (pmouseX - mouseX) will be negative.
}
