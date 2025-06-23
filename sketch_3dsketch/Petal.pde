class Petal extends GameObject {
  float speedY;

  Petal() {
    super(random(-2000, 2000), random(800, 1000), random(-2000, 2000), 5); //sets the petal to a random spot on the map
    speedY = random(0.5, 1.5); //random speed
  }

  void act() {
    loc.y -= speedY; //floats up
    if (loc.y < 700) {
      loc.y = random(1000, 1200); //if the y value reaches a certain height it teleports back down under the ground so it infintley rises up and down
    }
  }

  void show() {
    world.pushMatrix();
    world.translate(loc.x, loc.y, loc.z);

    float boxSize = size / 2;

    if (brightness > 0.5) { //if the brightness is above 0.5 or if its day time the petals stay petals

      world.fill(petalPink);
      world.noStroke();
      world.box(boxSize);
    } else { //when its NOT day time, the petals turn yellow and into fire flies
    //just like the pebbles i was going to make them glow - but too laggy and proccessing dosent allow so many lights

      world.noStroke();
      world.fill(255, 255, 0);  // solid yellow center
      world.box(boxSize);
    }

    world.popMatrix();
  }
}
