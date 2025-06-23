class SmallPebble extends GameObject {

  SmallPebble(float x, float y, float z) {
    super(x, y, z, random(10, 20)); // size set here
  }

  void act() { 
    
    //i was going to add lights to each and every pebble but proccessing only allows 8 different light sources
    
  }

  void show() {
    world.pushMatrix();
    world.translate(loc.x, loc.y, loc.z);

    // Flattened ellipsoid pebble
    world.pushMatrix();
    world.scale(1, 0.3, 1); // squashed vertically
    world.fill(80); // dark gray
    world.noStroke();
    world.sphere(size);
    world.popMatrix();

    // White glowing top (now horizontal)
    world.pushMatrix();
    world.translate(0, -size * 0.3, 0); // sit on top
    world.rotateX(HALF_PI); // rotate ellipse to lay flat
    world.fill(255);
    world.ellipse(0, 0, size * 1.2, size * 1.2);
    world.popMatrix();

    world.popMatrix();
  }
}
