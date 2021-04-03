// Infinite Disintegration
//   Based on the BlendMode Test of November 2019
//
//   Jared S Tarbell
//   January 1, 2020
//   Levitated Toy Factory
//   Albuquerque, New Mexico USA

ArrayList<Node> nodes = new ArrayList<Node>();
IntList history = new IntList();

Camera cam;

color[] pollockFFF = {0xFFA18A69,0xFFF1D4A5,0xFF9A8262,0xFF7C6C42,0xFFA99968,0xFFF4E3BE,0xFFE7D8C0,0xFFF1DDC6,0xFF9D5432,0xFFD9D1C1,0xFF352626,0xFF302C2E,0xFF47402E,0xFF6B7353,0xFF9C542B,0xFF817B6D,0xFF333A3D,0xFF937352,0xFF38322E,0xFF323229,0xFF444842,0xFF4F402E,0xFFF1DCA5,0xFFE0C886,0xFF6B6C55,0xFF745530,0xFFC29160,0xFFDFA133,0xFF6A745D,0xFFE5A037,0xFFE8E1C0,0xFF65472D,0xFF40392E,0xFF6D5D3D,0xFFECDE9D,0xFF7C6C36,0xFFD1A977,0xFF99A160,0xFFC29168,0xFF6B734B,0xFF927B63,0xFF584037,0xFFCA8148,0xFFE49832,0xFF262C2E,0xFFF0AB3B,0xFF4E4738,0xFFF8F2C7,0xFFF3EDC7,0xFF746C43,0xFFF5E9AD,0xFF6D5D44,0xFFD95223,0xFF746433,0xFFAA7330,0xFF392B2D,0xFFB29A58,0xFFC8C187,0xFF7B6C5D,0xFFD9893B,0xFFF4E193,0xFFF0E27B,0xFFA28262,0xFFF4E2AD,0xFF523152,0xFF40392C,0xFF57746E,0xFFC9B97F,0xFFEB8D43,0xFFF6ECCE,0xFF9D5B35,0xFF4E402C,0xFFF5D294,0xFFF5DA83,0xFFF4DBAD,0xFFF5DA94,0xFFF5DBBD,0xFF82735C,0xFFE57037,0xFF7C6C4B,0xFFEFEFD0,0xFF8A8A59,0xFFF1DCAE,0xFF73734B,0xFFE0D0C0,0xFF7B7B4A,0xFF909A7A,0xFF372B27,0xFFF4E18A,0xFFF4DBB5,0xFFF4E784,0xFF696D5E,0xFF936B36,0xFF687466,0xFF817B63,0xFF89826B,0xFFC0B999,0xFF6C5D4E,0xFF473329,0xFF4C5647,0xFFF7F0B6,0xFFF2CC85,0xFF655D45,0xFF3F3229,0xFF836C4B,0xFFDB5A23,0xFF727B52,0xFF9F928B,0xFF2E333D,0xFF99A168,0xFFC45A27,0xFFE7D8A7,0xFF201F21,0xFFF5EABE,0xFF7B7B52,0xFFD85A20,0xFF755532,0xFF745D32,0xFF47402C,0xFFE6B88F,0xFF8C6B4B,0xFF888B7C};

long[] times;
int averageOverFrames = 5;
long baseTime;

int max = 20000;
long lastMillis = 0;


float nodeScale = 1.0;
//float t = 0;
int offx = 0;
int offy = 0;
float warp = .005;
float cry = 0;

int update = 0;

int cnt = 0;

boolean reflected = false;
boolean displayStatus = true;


void setup() {
  //size(1200,1200,FX2D);
  fullScreen(FX2D);
  background(0);
  
  rectMode(CENTER);
  
  cam = new Camera(0,0,0,1);
  
  baseTime = millis();

}

void draw() {
  // clear the background and set the blend mode or not
  background(0);
  
  // move the camera according to mouse vertical position
  cam.dfl = map(mouseY,0,height,1,10000);
  cam.fly();
  
  // adjust node count if necessary
  for (int k=0;k<15;k++) {
    if (nodes.size()<max) {
      // add a node
      Node neo = new Node(offx,offy,warp);
      nodes.add(neo);
    }
    if (nodes.size()>max) {
      // remove a node
      nodes.remove(0);
    }
  }
  
  // draw all the nodes
  for (Node b:nodes) b.render();
  
  // noise drift
  cry-=.005;
  
  // time counter
  cnt++;
  //if ((cnt%1800)==0) shake();
  
  // scalin' nodes
  nodeScale = 1.0;
  
  if (displayStatus) renderStatus(); 

}

void changeNodeMax(int delta) {
  max+=delta; 
  if (max<0) max = 0;
  if (max>100000) max = 100000;
}

void shake() {
  // disturb the noise field with new constants
  offx = floor(random(10000));
  offy = floor(random(10000));
  warp = random(.0011,.0055);
  //if (random(100)<33) warp*=.1;
  update = nodes.size();
}

color goodColor() {
  int i = floor(random(pollockFFF.length));
  return pollockFFF[i];
}

void renderStatus() {
  // report status
  fill(255);
  noStroke();
  textSize(18);
  textAlign(LEFT);
  int ns = nodes.size();
  if (reflected) ns*=2;
  String rpt = ns + " nodes @"+round(frameRate)+"fps";
  if (reflected) rpt+=" reflected";
  rpt+="   dfl:"+cam.dfl;
  text(rpt,20,height-20);
  textAlign(RIGHT);
  String txt = "Infinite Disintegration";
  text(txt,width-20,height-20);
}



void mousePressed() {
  // toggle blendmode
  cam.dfl = map(mouseY,0,height,1,10000);
}

void keyPressed() {
  if (key==' ') {
    shake();
  }
  if (key=='r' || key=='R') {
    reflected = !reflected;
  }
  if (key=='-' || key=='_') {
    changeNodeMax(-100);
  }
  if (key=='=' || key=='+') {
    changeNodeMax(100);
  }
  if (key=='d' || key=='D') {
    displayStatus=!displayStatus;
  }
  if (key=='c' || key=='C') {
    if (cam.dfl>1000) {
      cam.dfl = 1000;
    } else {
      cam.dfl = 10000;
    }
  }
      
}

  
  

    
