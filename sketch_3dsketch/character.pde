void move() {
  
  //sprint stuff
  float sprintSpeed = 5;
  if (shiftKey) {
    sprintSpeed = 10;
  }
  
  if (wkey & canMoveForward() ) {
    eyeX = eyeX + cos(leftRightHeadAngle)*sprintSpeed;      //multiplying it by sprint speed so it adjusts how fast the character is moving
    eyeZ = eyeZ + sin(leftRightHeadAngle)*sprintSpeed;
  }
  if (skey & canMoveBackward() ) {
    eyeX = eyeX - cos(leftRightHeadAngle)*sprintSpeed;
    eyeZ = eyeZ - sin(leftRightHeadAngle)*sprintSpeed;
  }
  if (akey & canMoveLeft() ) {
    eyeX = eyeX - cos(leftRightHeadAngle + PI/2)*sprintSpeed;
    eyeZ = eyeZ - sin(leftRightHeadAngle + PI/2)*sprintSpeed;
  }
  if (dkey & canMoveRight() ) {
    eyeX = eyeX - cos(leftRightHeadAngle - PI/2)*sprintSpeed;
    eyeZ = eyeZ - sin(leftRightHeadAngle - PI/2)*sprintSpeed;
  }
  

  if (skipFrame == false) {
    leftRightHeadAngle = leftRightHeadAngle + (mouseX - pmouseX)*0.01;
    upDownHeadAngle = upDownHeadAngle + (mouseY - pmouseY)*0.01;
  }

  if (upDownHeadAngle > PI/2.5) upDownHeadAngle = PI/2.5;
  if (upDownHeadAngle < -PI/2.5) upDownHeadAngle = -PI/2.5;



  focusZ = eyeZ + sin(leftRightHeadAngle)*300;
  focusY = eyeY + tan(upDownHeadAngle)*300;

  //bobble head stuff
  float bobbleOffset = sin(bobbleTimer * 2) * bobbleAmount; //uses ANOTHER sin graph to simulate a smooth up and down 
  float baseEyeY = 8 * height / 10;  // your current base eyeY
  eyeY = baseEyeY + bobbleOffset; //setting the eyeY our vertical viewpoint so that its affected by the up and down wave of bobbleOffset

  float sidewaysBobble = cos(bobbleTimer * 2) * 5;  // small side sway and same logic as up and down just sideways
  focusX = eyeX + cos(leftRightHeadAngle) * 300 + sidewaysBobble;



  if (mouseX > width-2) {
    rbt.mouseMove(3, mouseY);
    skipFrame = true;
  } else if (mouseX < 2) {
    rbt.mouseMove(width-3, mouseY);
    skipFrame = true;
  } else {
    skipFrame = false;
  }

  boolean isWalking = wkey || akey || skey || dkey; 

  if (isWalking) { //only makes it so that the head bobble is activated when walking(or pressing w, a, s, d).
    bobbleTimer += bobbleSpeed;
  } else {
    bobbleTimer = 0;
  }
}

//collision stuff and logic
boolean isWalkable(float x, float z) {
  int mapx = int(x + 2000) / gridSize;
  int mapy = int(z + 2000) / gridSize;

  if (mapx < 0 || mapx >= map.width || mapy < 0 || mapy >= map.height) return false;

  color tileColor = map.get(mapx, mapy);
  return tileColor == white || tileColor == pinkTree || tileColor == pinkTree2 || tileColor == mossyStone || tileColor == moss1;  //looks for all the things you can walk on
}


boolean canMoveInDirection(float angle) {
  float futureX = eyeX + cos(angle) * 50;
  float futureZ = eyeZ + sin(angle) * 50;

  float padding = 30;    //padding is the distance/space allowed, i still havent figured this out yet and made it more robust.
  
  //right now its able to not cut any corners but when I walk straight into a block i stop but i sort of see inside it.

  return (
    isWalkable(futureX + padding, futureZ + padding) &&
    isWalkable(futureX + padding, futureZ - padding) &&
    isWalkable(futureX - padding, futureZ + padding) &&
    isWalkable(futureX - padding, futureZ - padding)
    );
}

//setting all the other move in forward by calling moveindirection so the code is alot cleaner
boolean canMoveForward() {
  return canMoveInDirection(leftRightHeadAngle);
}

boolean canMoveBackward() {
  return canMoveInDirection(leftRightHeadAngle + PI);
}

boolean canMoveLeft() {
  return canMoveInDirection(leftRightHeadAngle - HALF_PI);
}

boolean canMoveRight() {
  return canMoveInDirection(leftRightHeadAngle + HALF_PI);
}

void drawFocalPoint() {
  pushMatrix();
  translate(focusX, focusY, focusZ);
  sphere(5);
  popMatrix();
}
