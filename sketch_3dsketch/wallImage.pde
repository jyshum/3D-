class WallImage extends GameObject {
  PImage img;
  float w, h;
  float rotY;

  WallImage(String filename, float x, float y, float z, float w, float h, float rotY) {
    super(x, y, z, 1);  // size is unused here but required by GameObject constructor
    img = loadImage(filename);
    this.w = w;
    this.h = h;
    this.rotY = rotY;
  }

  void act() {
    // Nothing dynamic needed for now
  }

  void show() {
    world.pushMatrix();
    world.translate(loc.x, loc.y, loc.z);
    world.rotateY(rotY);

    world.beginShape(QUADS);
    world.texture(img);
    world.vertex(-w / 2, -h / 2, 0, 0, 0);
    world.vertex(w / 2, -h / 2, 0, 1, 0);
    world.vertex(w / 2, h / 2, 0, 1, 1);
    world.vertex(-w / 2, h / 2, 0, 0, 1);
    world.endShape();

    world.popMatrix();
  }
}
