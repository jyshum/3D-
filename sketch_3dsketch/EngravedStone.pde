class EngravedStone extends GameObject {
  float angle = 0;
  float floatOffset = 0; //the variable that allows the stone to move up and down smoothly
  EngravedStone(float x, float y, float z) {
    super(x, y, z, 1);
    lives = 99999;
  }

  void act() {
    angle += 0.02;  // slow rotation
    floatOffset = sin(millis() * 0.002) * 20; // smooth up/down between -10 and +10 using a sin graph
  }


  void show() {
    world.pushMatrix();
    world.translate(loc.x, loc.y + floatOffset, loc.z); //translate to the x and y + offset which will make it float up and down
    world.rotateY(angle); //making the cube rotate


    // Main Stone
    world.fill(100);
    world.box(120, 120, 120);

    // Glowing Triangle Engraving
    world.pushMatrix();
    world.translate(0, 0, 61);
    world.fill(255, 255, 200);
    world.beginShape();
    world.vertex(-15, 10);
    world.vertex(0, -10);
    world.vertex(15, 10);
    world.endShape(CLOSE);
    world.popMatrix();


    world.popMatrix();
  }
}
