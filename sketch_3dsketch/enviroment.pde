void drawMap() {
  for (int x = 0; x < map.width; x++) {
    for (int y = 0; y < map.height; y++) {
      color c = map.get(x, y);
      if (c == lightBrown) {
        texturedCube(x*gridSize-2000, height-gridSize, y*gridSize-2000, log, gridSize);
        texturedCube(x*gridSize-2000, height-gridSize*2, y*gridSize-2000, log, gridSize);
        texturedCube(x*gridSize-2000, height-gridSize*3, y*gridSize-2000, log, gridSize);
        texturedCube(x*gridSize-2000, height-gridSize*4, y*gridSize-2000, log, gridSize);

        texturedCube(x*gridSize-2000, height-gridSize*8, y*gridSize-2000, springTreeLeaves, gridSize);
      }
      if (c == black) {
        texturedCube(x*gridSize-2000, height, y*gridSize-2000, stoneBrick, gridSize);
      }
      if (c == pinkTree) {
        texturedCube(x*gridSize-2000, height-gridSize*4, y*gridSize-2000, springTreeLeaves, gridSize);
        texturedCube(x*gridSize-2000, height-gridSize*5, y*gridSize-2000, springTreeLeaves, gridSize);
        texturedCube(x*gridSize-2000, height-gridSize*6, y*gridSize-2000, springTreeLeaves, gridSize);
      }
      if (c == pinkTree2) {
        texturedCube(x*gridSize-2000, height-gridSize*7, y*gridSize-2000, springTreeLeaves, gridSize);
        texturedCube(x*gridSize-2000, height-gridSize*4, y*gridSize-2000, springTreeLeaves, gridSize);
      }
    }
  }
}

void drawFloor(int startX, int endX, int startZ, int endZ, int level, int gap) {
  stroke(255);
  strokeWeight(1);
  for (int x = startX; x < endX; x += gap) {
    for (int z = startZ; z < endZ; z += gap) {
      texturedCube(x, level, z, grassBlock, gap);
    }
  }
}



void drawSkyNightBackground() {

  timeOfDay += daySpeed;
  if (timeOfDay > TWO_PI) timeOfDay = 0;
  
  // Boost day colors: closer to light blue and white
  int r = int(5 + brightness * 200);   // 5 (night) to 205 (day)
  int g = int(10 + brightness * 220);  // 10 to 230
  int b = int(20 + brightness * 235);  // 20 to 255

  world.background(r, g, b);
}
