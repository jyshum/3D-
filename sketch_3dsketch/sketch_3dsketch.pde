import java.awt.Robot;
import java.util.ArrayList;

Robot rbt;
boolean skipFrame;

color white = #FFFFFF; //stone bricks
color black = #000000; //empty space
color lightBrown = #B97A57; //logs

//map variables
int gridSize;
PImage map;

//texture
PImage log;
PImage  grassBlock;
PImage stoneBrick;
boolean wkey, akey, skey, dkey, ekey;
float eyeX, eyeY, eyeZ, focusX, focusY, focusZ, tiltX, tiltY, tiltZ;
float leftRightHeadAngle, upDownHeadAngle;


//game obj
ArrayList<GameObject> objects;

void setup() {
  fullScreen(P3D);
  log = loadImage("Oak_Log_Side.png");
  stoneBrick = loadImage("Stone_Bricks.png");
  grassBlock = loadImage("Grass_Block_Top_C.png");
  textureMode(NORMAL);
  objects = new ArrayList<GameObject>();

  wkey = akey = skey = dkey = false;
  eyeX = width/2;
  eyeY = 8*height/10;
  eyeZ = 0;
  focusX = width/2;
  focusY = height/2;
  focusZ = 10;
  tiltX = 0;
  tiltY = 1;
  tiltZ = 0;
  leftRightHeadAngle = radians(270);
  noCursor();

  try {
    rbt = new Robot();
  }
  catch(Exception e) {
    e.printStackTrace();
  }
  skipFrame = false;

  //initialize map
  map = loadImage("map.png");
  gridSize = 100;
}

void draw() {
  background(0);

  //lights();
  pointLight(255, 255, 255, eyeX, eyeY, eyeZ);

  camera(eyeX, eyeY, eyeZ, focusX, focusY, focusZ, tiltX, tiltY, tiltZ);
  drawFloor(-2000, 2000, height, gridSize);
  drawFloor(-2000, 2000, height-gridSize*4, gridSize);
  //drawRoof();
  drawFocalPoint();
  move();
  drawMap();

  int i = 0;
  while (i < objects.size()) {
    GameObject obj = objects.get(i);
    obj.act();
    obj.show();
    if (obj.lives == 0) {
      objects.remove(i);
    } else {
      i++;
    }
  }
}
