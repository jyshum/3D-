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

  if (brightness > 0.5) {
    // Daytime: pink petals
    world.fill(petalPink);
    world.noStroke();
    world.box(size / 2);
  } else {
    // Nighttime: glowing yellow firefly
    world.noStroke();

    // Glow effect (larger, transparent sphere behind the main one)
    world.pushMatrix();
    world.fill(255, 255, 0, 50); // very transparent yellow glow
    world.box(size * 1.5);    // larger "glow field"
    world.popMatrix();

    // Core firefly
    world.fill(255, 255, 0);     // solid yellow core
    world.box(size / 2);      // or size if you prefer larger
  }

  world.popMatrix();
}
}
