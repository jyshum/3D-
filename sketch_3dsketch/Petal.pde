class Petal extends GameObject {
  float speedY;

  Petal() {
    super(random(-1500, 1500), random(800, 1000), random(-1500, 1500), 5);
    speedY = random(0.5, 1.5);
  }

  void act() {
    loc.y -= speedY;
    if (loc.y < 700) {
      loc.y = random(1000, 1200);
    }
  }

  void show() {
    world.pushMatrix();
    world.translate(loc.x, loc.y, loc.z);
    world.fill(255, 182, 193);  // Pink
    world.noStroke();
    world.sphere(size / 2);
    world.popMatrix();
  }
}
