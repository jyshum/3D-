void drawMap() {
  for (int x = 0; x < map.width; x++) {
    for (int y = 0; y < map.height; y++) {
      color c = map.get(x, y);
      if (c == lightBrown) {
        texturedCube(x*gridSize-2000, height-gridSize, y*gridSize-2000, log, gridSize);
        texturedCube(x*gridSize-2000, height-gridSize*2, y*gridSize-2000, log, gridSize);
        texturedCube(x*gridSize-2000, height-gridSize*3, y*gridSize-2000, log, gridSize);
      }
      if (c == black) {
        texturedCube(x*gridSize-2000, height-gridSize, y*gridSize-2000, stoneBrick, gridSize);
        texturedCube(x*gridSize-2000, height-gridSize*2, y*gridSize-2000, stoneBrick, gridSize);
        texturedCube(x*gridSize-2000, height-gridSize*3, y*gridSize-2000, stoneBrick, gridSize);
      }
    }
  }
}

void drawFloor(int start, int end, int level, int gap) {
  stroke(255);
  strokeWeight(1);
  int x = start;
  int z = start;
  while (z < end) {
    texturedCube(x, level, z, grassBlock, gap);
    x = x+ gap;
    if (x >= end) {
      x = start;
      z = z +gap;
    }
  }
}
