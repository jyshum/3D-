import java.awt.Robot;
import java.util.ArrayList;

Robot rbt;
boolean skipFrame;

color white = #FFFFFF; //stone bricks
color black = #000000; //empty space
color lightBrown = #B97A57; //logs
color brown = #8B5A2B;
color treeGreen = #22B14C;
color pinkTree = #FFAEC9;
color pinkTree2 = #7A5460;

//map variables
int gridSize;
PImage map;

//texture
PImage log;
PImage  grassBlock;
PImage stoneBrick; //<>//
PImage springTreeLeaves;
boolean wkey, akey, skey, dkey, ekey;
float eyeX, eyeY, eyeZ, focusX, focusY, focusZ, tiltX, tiltY, tiltZ;
float leftRightHeadAngle, upDownHeadAngle;


//game obj
ArrayList<GameObject> objects;

//layers
PGraphics world;
PGraphics HUD;

//seasons
String currentSeason = "spring";

  float timeOfDay = 0;
  float daySpeed = 0.015;
void setup() {
  //create layers
  world = createGraphics(width, height, P3D);
  HUD = createGraphics(width, height, P2D);


  fullScreen(P2D);
  log = loadImage("Oak_Log_Side.png");
  stoneBrick = loadImage("Stone_Bricks.png");
  grassBlock = loadImage("Grass_Block_Top_C.png");
  springTreeLeaves = loadImage("blossomLeaves.jpg");
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


  loadSpring();
  
}

void draw() {
  world.beginDraw();
  world.textureMode(NORMAL);

  drawSkyNightBackground();
  //lights();
  //world.pointLight(255, 255, 255, eyeX, eyeY, eyeZ);
  world.camera(eyeX, eyeY, eyeZ, focusX, focusY, focusZ, tiltX, tiltY, tiltZ);


  drawFloor(-2000, 2000, -2000, 2000, height, gridSize);


  //drawFloor(-2000, 2000, height-gridSize*8, gridSize);

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

  world.endDraw();
  image(world, 0, 0);

  HUD.beginDraw();
  HUD.clear();
  drawCrosshair();
  drawMinimap();
  HUD.endDraw();
  image(HUD, 0, 0);
}

void loadSpring() {
  objects.clear();  // Clear old objects
  currentSeason = "spring";

  // Add petals
  for (int i = 0; i < 800; i++) {
    objects.add(new Petal());
  }

  // Center of the map

//  // Tree at center, sitting just above ground
//  objects.add(new springTree(0, height, 0));

  // Stone in front of the tree (along negative Z direction)
  objects.add(new EngravedStone(0, height-100, 0 - 150));






  // Add signs, portal, trees etc.
}
