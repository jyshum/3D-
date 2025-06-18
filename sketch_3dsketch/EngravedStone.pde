class EngravedStone extends GameObject {

  EngravedStone(float x, float y, float z) {
    super(x, y, z, 1);
    lives = 99999;
  }

  void act() {
    // no behavior for now
  }

  void show() {
    println("Drawing engraved stone IN 3D:", loc.x, loc.y, loc.z);

    world.pushMatrix();
    world.translate(loc.x, loc.y, loc.z);

    // Draw main stone block
    world.fill(120); // dark gray stone
    world.box(60, 60, 60);

    // Draw engraving (glowing white rectangle on front face)
    world.pushMatrix();
    world.translate(0, 0, 31); // slightly in front
    world.fill(255); // bright white engraving
    world.rectMode(CENTER);
    world.noStroke();
    world.rect(0, 0, 30, 20);
    world.popMatrix();

    world.popMatrix();
  }
}
