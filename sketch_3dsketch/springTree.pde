class springTree extends GameObject {
  springTree(float x, float y, float z) {
    super(x, y, z, 1);  // size not important here
    lives = 10000;
  }

  void act() {
    // trees don't move
  }

  void show() {
    world.pushMatrix();
    world.translate(loc.x, loc.y, loc.z);

    // Draw trunk
    world.pushMatrix();
    world.translate(0, 50, 0); // lift trunk up from base
    world.fill(#8B5A2B); // brown color
    world.box(20, 100, 20); // width, height, depth
    world.popMatrix();

    // Draw leaves (simple sphere canopy)
    world.pushMatrix();
    world.translate(0, 120, 0); // above trunk
    world.fill(#228B22); // green
    world.sphere(60);
    world.popMatrix();

    world.popMatrix();
  }
}
