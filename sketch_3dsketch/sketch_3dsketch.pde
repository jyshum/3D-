//robot stuff :) //<>//
import java.awt.Robot; //<>//
import java.util.ArrayList;
Robot rbt;
boolean skipFrame;

//color pallette and all
color white = #FFFFFF;
color black = #000000;
color mossyStone = #3E543B;
color moss1 = #22B14C;
color lightBrown = #B97A57;
color brown = #8B5A2B;
color treeGreen = #22B14C;
color pinkTree = #FFAEC9;
color pinkTree2 = #7A5460;
color pinkBush = #A67183;
color pinkBush2 = #4A323A;
color petalPink = #F0B5E5;

//map variables
int gridSize;
PImage map;

//texture
PImage log, quote1, grassBlock, stoneBrick, moss, mossyStoneBrick, springTreeLeaves;

//layers
PGraphics world;
PGraphics HUD;

//Initialize enviroment scenery
String currentSeason = "spring";
float timeOfDay = 0;              //controls time of day and how fast each cycle is
float daySpeed = 0.0035;
float brightness;

//quote interaction stuff
boolean showOverlay = false;    // full quote screen
boolean readyToInteract = false; // nearby and ready
boolean interactionTriggered = false;

//Character ALL stuff
boolean wkey, akey, skey, dkey, ekey, shiftKey, spaceKey;
float eyeX, eyeY, eyeZ, focusX, focusY, focusZ, tiltX, tiltY, tiltZ;
float leftRightHeadAngle, upDownHeadAngle;
//Bobblehead walking feature stuff
float bobbleTimer = 0;
float bobbleAmount = 8;       // how strong the bobble is
float bobbleSpeed = 0.075;       // how fast it moves

//game obj and arrays
ArrayList<GameObject> objects;

void setup() {
  
  //create layers
  world = createGraphics(width, height, P3D);
  HUD = createGraphics(width, height, P2D);
  //set fullscreen mode
  fullScreen(P3D);
  //create arraylist
  objects = new ArrayList<GameObject>();
  
  //Load textures here!
  log = loadImage("Oak_Log_Side.png");
  stoneBrick = loadImage("Stone_Bricks.png");
  quote1 = loadImage("quote.jpg");
  moss = loadImage("grass2.jpg");
  grassBlock = loadImage("Grass_Block_Top_C.png");
  springTreeLeaves = loadImage("blossomLeaves.jpg");
  mossyStoneBrick = loadImage("mossyStone.png.png");

  //character interaction and viewpoint start it here!
  wkey = akey = skey = dkey = false;                   //set all keys to false first
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

  //robot stuff
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

  //load the scenery!
  loadSpring();
}





void draw() {
  //begin the world draw and texture
  world.beginDraw();
  world.textureMode(NORMAL);
  brightness = (sin(timeOfDay) + 1) / 2; //setting the "brightness" of the day through a sin wave, so it goes up and down in a smooth loop

  // Set dynamic lighting
  world.ambientLight(40 + brightness * 100, 40 + brightness * 100, 40 + brightness * 100); //multiplying by the brightness variable makes it so that the world's lighting changes with the day and night cycle(darker when its night, brighter when its day).

  //call the day/night cycle!
  drawSkyNightBackground(); 
  
  //drawing a light at the engravedstone so it looks like its glowing
  world.pointLight(130, 130, 30, 0, height-100, 0 - 150);
  
  //setting the player's camera and viewpoint
  world.camera(eyeX, eyeY, eyeZ, focusX, focusY, focusZ, tiltX, tiltY, tiltZ);

  //making the 3D floor - go check out enviroment to see how I changed it!
  drawFloor(-2000, 2000, -2000, 2000, height, gridSize);

  
  //drawFocalPoint();  I want to cancel this for now
  
  //let the player move by using move() function - go to character to see how it works!
  move();
  //drawing the map so it can load in all the blocks and terrain
  drawMap();

  //make loop to call all gameobjects just like in asteroids
  int i = 0;
  while (i < objects.size()) {
    GameObject obj = objects.get(i);
    obj.act();
    obj.show();
    if (obj.lives == 0) { //I didnt use lives because I decided not to add enemies
      objects.remove(i);
    } else {
      i++;
    }
  }

  //end the draw!
  world.endDraw();
  image(world, 0, 0);

  // Check if player is near the engraved stone and if so make it "able to interact"
  PVector playerPos = new PVector(eyeX, eyeY, eyeZ);
  PVector stonePos = new PVector(0, height - 100, -150);  // match your stone's position
  float distance = PVector.dist(playerPos, stonePos); //checking distance between player and stone pos

  if (distance < 300) {
    readyToInteract = true;    //looking for the radius distance if they intersect
  } else {
    readyToInteract = false;
    interactionTriggered = false;
    showOverlay = false;
  }

  //if the player is near enough, pop up a text to interact
  if (readyToInteract && !interactionTriggered) {
    // Show soft dark screen + prompt
    hint(DISABLE_DEPTH_TEST);
    camera(); // reset to 2D


    fill(255);
    textAlign(CENTER, CENTER);
    textSize(50);
    text("Press E to interact", width / 2, height / 2+100);

    hint(ENABLE_DEPTH_TEST);
  } else if (showOverlay) {
    // Full quote overlay
    hint(DISABLE_DEPTH_TEST);
    camera();

    fill(0, 200);
    noStroke();
    rect(0, 0, width, height);

    fill(255);
    textAlign(CENTER, CENTER);
    textSize(24);
    text("It's not about how many times you fall.\nIt's about how many times you get back up.", width / 2, height / 2);

    hint(ENABLE_DEPTH_TEST);
  }

  HUD.beginDraw();
  //draw the 2d stuff thats always on the screen, i dont think i need the map but i left it there so i can debug the location stuff
  HUD.clear();
  //drawCrosshair();
  drawMinimap();
  HUD.endDraw();
  image(HUD, 0, 0);

  if (ekey) { //makes it possible to press ekey and look at the quotes
    if (readyToInteract && !interactionTriggered) {
      showOverlay = true;
      interactionTriggered = true;
    }
  }
}



void loadSpring() {
  objects.clear();  // Clear old objects
  currentSeason = "spring"; // i was gonna add more seasons here thats why technically this is spring but its my only season.

  // Add petals
  for (int i = 0; i < 800; i++) {
    objects.add(new Petal());
  }
  for (int i = 0; i < 10; i++) { //make the pebbles suround the engraved stone
    float px = random(-300, 300);
    float py = height-10;
    float pz = -150 + random(-300, 300);
    objects.add(new SmallPebble(px, py, pz));
  }

  // Stone in front of the tree (along negative Z direction)
  objects.add(new EngravedStone(0, height-100, 0 - 150));
  //add the images here
  objects.add(new WallImage("quote.jpg", -1000, height - 1000, -2000, 2000, 2000, 0));
  objects.add(new WallImage("quote2.jpg", 1000, height - 1000, -2000, 2000, 2000, 0));
  objects.add(new WallImage("quote3.jpeg", 1000, height-500 , 2000, 1000, 1000, PI));

}
