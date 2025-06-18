void texturedCube(float x, float y, float z, PImage texture, float size) {
  world.pushMatrix();
  world.translate(x, y, z);
  world.scale(size);
  world.noStroke();

  world.noStroke();

  world.beginShape(QUADS);
  world.texture(texture);

  //top
  //     x, y, z, tx,ty
  world.vertex(0, 0, 0, 0, 0);
  world.vertex(1, 0, 0, 1, 0);
  world.vertex(1, 0, 1, 1, 1);
  world.vertex(0, 0, 1, 0, 1);

  //bottom
  //     x, y, z, tx,ty
  world. vertex(0, 1, 0, 0, 0);
  world.vertex(1, 1, 0, 1, 0);
  world.vertex(1, 1, 1, 1, 1);
  world.vertex(0, 1, 1, 0, 1);

  //front
  //     x, y, z, tx,ty
  world.vertex(0, 0, 1, 0, 0);
  world.vertex(1, 0, 1, 1, 0);
  world.vertex(1, 1, 1, 1, 1);
  world.vertex(0, 1, 1, 0, 1);

  //back
  //     x, y, z, tx,ty
  world.vertex(0, 0, 0, 0, 0);
  world.vertex(1, 0, 0, 1, 0);
  world.vertex(1, 1, 0, 1, 1);
  world.vertex(0, 1, 0, 0, 1);

  //left
  //     x, y, z, tx,ty
  world.vertex(0, 0, 1, 0, 0);
  world.vertex(0, 0, 0, 1, 0);
  world.vertex(0, 1, 0, 1, 1);
  world.vertex(0, 1, 1, 0, 1);

  //right
  //     x, y, z, tx,ty
  world.vertex(1, 0, 1, 0, 0);
  world.vertex(1, 0, 0, 1, 0);
  world.vertex(1, 1, 0, 1, 1);
  world.vertex(1, 1, 1, 0, 1);

  world.endShape();



  world.popMatrix();
}

void texturedCube(float x, float y, float z, PImage top, PImage side, PImage bottom, float size) {
  world.pushMatrix();
  world.translate(x, y, z);
  world.scale(size);
  world.noStroke();

  world.noStroke();

  world.beginShape(QUADS);
  world.texture(top);

  //top
  //     x, y, z, tx,ty
  world.vertex(0, 0, 0, 0, 0);
  world. vertex(1, 0, 0, 1, 0);
  world.vertex(1, 0, 1, 1, 1);
  world. vertex(0, 0, 1, 0, 1);

  //bottom
  //     x, y, z, tx,ty
  world. vertex(0, 1, 0, 0, 0);
  world. vertex(1, 1, 0, 1, 0);
  world. vertex(1, 1, 1, 1, 1);
  world. vertex(0, 1, 1, 0, 1);

  //front
  //     x, y, z, tx,ty
  world.vertex(0, 0, 1, 0, 0);
  world. vertex(1, 0, 1, 1, 0);
  world.vertex(1, 1, 1, 1, 1);
  world. vertex(0, 1, 1, 0, 1);

  //back
  //     x, y, z, tx,ty
  world.vertex(0, 0, 0, 0, 0);
  world.vertex(1, 0, 0, 1, 0);
  world. vertex(1, 1, 0, 1, 1);
  world. vertex(0, 1, 0, 0, 1);

  //left
  //     x, y, z, tx,ty
  world.vertex(0, 0, 1, 0, 0);
  world.vertex(0, 0, 0, 1, 0);
  world.vertex(0, 1, 0, 1, 1);
  world.vertex(0, 1, 1, 0, 1);

  //right
  //     x, y, z, tx,ty
  world.vertex(1, 0, 1, 0, 0);
  world.vertex(1, 0, 0, 1, 0);
  world. vertex(1, 1, 0, 1, 1);
  world. vertex(1, 1, 1, 0, 1);

  world.endShape();



  world.popMatrix();
}
