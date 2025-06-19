class springTree extends GameObject {
  springTree(float x, float y, float z) {
    super(x, y, z, 1);  // size not important here
  }

  void act() {
    // trees don't move
  }

  void show() {
    world.pushMatrix();
    world.translate(loc.x, loc.y-200, loc.z);  // lower the whole tree
    world.fill(brown); // brown color
    world.box(50, 500, 50); // width, height, depth
    world.fill(#228B22); // green
    world.popMatrix();
    world.pushMatrix();
    world.translate(loc.x, loc.y-500, loc.z);
    world.sphere(100);
    world.popMatrix();
  }
}
