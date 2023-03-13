// Henon Phase Deep
// a mathematical strange attractor
// j.tarbell   May, 2004
// Albuquerque, New Mexico
// complexification.net

// based on code from mathworld.wolfram.com/HenonMap.html

// Processing 0085 Beta syntax update
// j.tarbell   April, 2005

// number of points to draw in each iteration
float offx, offy;
float scale = 0.73;      // scale the visualization to match the applet size
float a = random(TWO_PI);       // slice constant (0...TWO_PI)
int maxnum = 5000;

boolean drawing = true;

// OBJECTS
TravelerHenon[] travelers = new TravelerHenon[maxnum];

color[] goodcolor = {#000000, #6b6556, #a09c84, #908b7c, #79746e, #755d35, #937343, #9c6b4b, #ab8259, #aa8a61, #578375, #f0f6f2, #d0e0e5, #d7e5ec, #d3dfea, #c2d7e7, #a5c6e3, #a6cbe6, #adcbe5, #77839d, #d9d9b9, #a9a978, #727b5b, #6b7c4b, #546d3e, #47472e, #727b52, #898a6a, #919272, #AC623b, #cb6a33, #9d5c30, #843f2b, #652c2a, #7e372b, #403229, #47392b, #3d2626, #362c26, #57392c, #998a72, #864d36, #544732 };
color somecolor() {
  // pick some random good color
  return goodcolor[int(random(goodcolor.length))];
}


// MAIN METHODS
void setup() {
  size(1000,1000,P2D);
  pixelDensity(2);
  background(255);
  // gen slice
  renderSlice();
  // make some travelers
  for (int i=0;i<maxnum;i++) {
    travelers[i] = new TravelerHenon();
  }
  
}

void draw() {
    // repeat to get drawing result faster
    for (int k=0;k<20;k++) {
      // draw all travelers
      for (int i=0;i<maxnum;i++) {
        if (drawing) travelers[i].draw();
      }
    }
  
    // random mutations
    for (int k=0;k<2;k++) {
      travelers[int(random(maxnum))].rebirth();
    }
}


void mousePressed() {
  // stop drawing, clear screen, and reset
  drawing=false;
  background(255);
  renderSlice();
}



// METHODS ----------------------------------------------------------------------------

void renderSlice() {
  // pick random palette
  //gifID = int(random(gifNum));
  // convert GIF palette into usable palette
  //takecolor(palette[gifID]+".gif");
  // set random slice constant 0..TWO_PI
  a = random(0.2,TWO_PI-0.2);
  // avoid noid space
  if ((a>2.05) && (a<2.6)) {
    a = random(1.2,1.7);
  }
  
  // scale
  scale = .73;
  
  // random offset
  offx = random(1.0);
  offy = -0.1;
  
  // begin drawing aain
  drawing = true;
}


// OBJECTS ----------------------------------------------------------------------------

class TravelerHenon {
  float x, y;

  color myc;

  TravelerHenon() {
    rebirth();
  }

  void draw() {
    // move through time
    float t = x * cos(a) - (y - x*x) * sin(a);
    y = x * sin(a) + (y - x*x) * cos(a);
    x = t;
    float fuzx = random(-0.004,0.004);
    float fuzy = random(-0.004,0.004);
    
    float px = fuzx + (x/scale+offx)*width;
    float py = fuzy + (y/scale+offy)*height;
    
    if ((px>0) && (px<width) && (py>0) && (py<height)) {
      // render  
      stroke(myc,56);
      point(px,py);
    }
  }

  void rebirth() {
    x = random(0,1.0);
    y = random(0,1.0);
    myc = goodcolor[int(random(goodcolor.length))];
  }

}
