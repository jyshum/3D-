void move() {
    if (wkey & canMoveForward() ) {
    eyeX = eyeX + cos(leftRightHeadAngle)*10;
    eyeZ = eyeZ + sin(leftRightHeadAngle)*10;
  }
  if (skey & canMoveBackward() ) {
    eyeX = eyeX - cos(leftRightHeadAngle)*10;
    eyeZ = eyeZ - sin(leftRightHeadAngle)*10;
  }
  if (akey & canMoveLeft() ) {
    eyeX = eyeX - cos(leftRightHeadAngle + PI/2)*10;
    eyeZ = eyeZ - sin(leftRightHeadAngle + PI/2)*10;
  }
  if (dkey & canMoveRight() ) {
    eyeX = eyeX - cos(leftRightHeadAngle - PI/2)*10;
    eyeZ = eyeZ - sin(leftRightHeadAngle - PI/2)*10;
  }

  if (skipFrame == false) {
    leftRightHeadAngle = leftRightHeadAngle + (mouseX - pmouseX)*0.01;
    upDownHeadAngle = upDownHeadAngle + (mouseY - pmouseY)*0.01;
  }

  if (upDownHeadAngle > PI/2.5) upDownHeadAngle = PI/2.5;
  if (upDownHeadAngle < -PI/2.5) upDownHeadAngle = -PI/2.5;


  focusX = eyeX + cos(leftRightHeadAngle)*300;
  focusZ = eyeZ + sin(leftRightHeadAngle)*300;
  focusY = eyeY + tan(upDownHeadAngle)*300;

  if (mouseX > width-2) {
    rbt.mouseMove(3, mouseY);
    skipFrame = true;
  } else if (mouseX < 2) {
    rbt.mouseMove(width-3, mouseY);
    skipFrame = true;
  } else {
    skipFrame = false;
  }
  println(eyeX, eyeY, eyeZ);
  
  if (ekey) {
    objects.add(new Bullet());
  }
  
}

boolean canMoveForward() {
  float fwdx, fwdy, fwdz;

  int mapx, mapy;

  fwdx = eyeX + cos(leftRightHeadAngle)*120;
  fwdy = eyeY;
  fwdz = eyeZ + sin(leftRightHeadAngle)*120;

  mapx = int(fwdx+2000) / gridSize;
  mapy = int(fwdz+2000) / gridSize;

  if (map.get(mapx, mapy) == white) {
    return true;
  } else {
    return false;
  }
}

boolean canMoveBackward() {
  float bwdx, bwdy, bwdz;

  int mapx, mapy;

  bwdx = eyeX + cos(leftRightHeadAngle+radians(180))*120;
  bwdy = eyeY;
  bwdz = eyeZ + sin(leftRightHeadAngle+radians(180))*120;

  mapx = int(bwdx+2000) / gridSize;
  mapy = int(bwdz+2000) / gridSize;

  if (map.get(mapx, mapy) == white) {
    return true;
  } else {
    return false;
  }
}

boolean canMoveLeft() {
  float mlx, mly, mlz;

  int mapx, mapy;

  mlx = eyeX + cos(leftRightHeadAngle-radians(90))*120;
  mly = eyeY;
  mlz = eyeZ + sin(leftRightHeadAngle-radians(90))*120;

  mapx = int(mlx+2000) / gridSize;
  mapy = int(mlz+2000) / gridSize;

  if (map.get(mapx, mapy) == white) {
    return true;
  } else {
    return false;
  }
}

boolean canMoveRight() {
  float mrx, mry, mrz;

  int mapx, mapy;

  mrx = eyeX + cos(leftRightHeadAngle+radians(90))*120;
  mry = eyeY;
  mrz = eyeZ + sin(leftRightHeadAngle+radians(90))*120;

  mapx = int(mrx+2000) / gridSize;
  mapy = int(mrz+2000) / gridSize;

  if (map.get(mapx, mapy) == white) {
    return true;
  } else {
    return false;
  }
}

void drawFocalPoint() {
  pushMatrix();
  translate(focusX, focusY, focusZ);
  sphere(5);
  popMatrix();
}
