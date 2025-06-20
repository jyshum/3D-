class EngravedStone extends GameObject {
  float angle = 0;
  float floatOffset = 0;
  EngravedStone(float x, float y, float z) {
    super(x, y, z, 1);
    lives = 99999;
  }

  void act() {
    angle += 0.01;  // slow rotation
    floatOffset = sin(millis() * 0.001) * 10; // smooth up/down between -10 and +10
  }


  void show() {
    println("Drawing engraved stone IN 3D:", loc.x, loc.y, loc.z);

    world.pushMatrix();
    world.translate(loc.x, loc.y + floatOffset, loc.z); // floating effect
    world.rotateY(angle); // rotate around Y-axis

    // Main stone
    world.fill(100);
    world.box(120, 120, 120);

    // Glowing triangle engraving
    world.pushMatrix();
    world.translate(0, 0, 61); // front face
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
