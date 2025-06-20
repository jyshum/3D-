import java.awt.Robot; //<>//
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
color petalPink = #F0B5E5;

//map variables
int gridSize;
PImage map;

//texture
PImage log;
PImage  grassBlock;
PImage stoneBrick;
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
float brightness;

boolean showOverlay = false;


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
  brightness = (sin(timeOfDay) + 1) / 2;

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

  // === Check if player is near the engraved stone ===
  PVector playerPos = new PVector(eyeX, eyeY, eyeZ);
  PVector stonePos = new PVector(0, height - 100, -150);  // match your stone's position

  float distance = PVector.dist(playerPos, stonePos);
  showOverlay = (distance < 300); // trigger radius

  if (showOverlay) {
    // Switch to 2D HUD layer
    hint(DISABLE_DEPTH_TEST);
    camera(); // reset to 2D coordinate system

    fill(0, 200); // semi-transparent black
    noStroke();
    rect(0, 0, width, height);

    fill(255);
    textAlign(CENTER, CENTER);
    textSize(24);
    text("Its not about how many times you fall.\nIts about how many times you get back up.", width / 2, height / 2);

    hint(ENABLE_DEPTH_TEST); // re-enable depth for future 3D drawing
  }

  HUD.beginDraw();
  HUD.clear();
  //drawCrosshair();
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
  for (int i = 0; i < 10; i++) {
    float px = random(-300, 300);
    float py = height-10;
    float pz = -150 + random(-300, 300);
    objects.add(new SmallPebble(px, py, pz));
  }

  // Stone in front of the tree (along negative Z direction)
  objects.add(new EngravedStone(0, height-100, 0 - 150));






  // Add signs, portal, trees etc.
}
