boolean[] keyPresses = new boolean[255];
int PixelSize = 5;
int _long = 1;
Pixel[] pix;
Debuger debs = new Debuger(0);
float x, y;
float noiseSize = 0.005;
int seed;
//boolean walkMode;
color fillcolor;
int screens;

void setup() {
  colorMode(RGB);
  x = 1;
  y = 1;
  pix  = new Pixel[10000];
  //pix[0].deepth = 10;
  frameRate(60);
  size(800, 800);
  noiseDetail(20);
  background(0);
  noStroke();
  seed = (int)random(999999);
  pix[0] = new Pixel(2, 2, 0.89, 0);
}



void draw() {
  //debs = new Debuger(0);
  for (int i = 0; i<_long; i++) {
    pix[i].killCount =0;
  }
  background(0);
  noiseSeed(seed);

  ColorSelector();
  ButtonCheck();
  for (int i = 0; i<_long; i++) {
    if (dist(x+width/2, y+height/2, pix[i].pix_x/noiseSize-x/noiseSize, pix[i].pix_y/noiseSize-y/noiseSize)<400f) {
      if (i>_long-200) {

        if (pix[i].area<0.5) {
          pix[i].area+=(1-pix[i].area)/1000;
        }
        if (pix[i].killCount==0&&i<_long-1) {
          pix[i]=new Pixel(pix[i].pix_x+pix[i].area/2*(random(3)-1), pix[i].pix_y+pix[i].area/2*(random(3)-1), random(0.1)+0.89, (int)(random(21)/10-1));
          //debs.ops++;
        }
      }
    }
  }
  Debug();
}




void ColorSelector() {
  for (int pix_x = 0; pix_x<width; pix_x+=+PixelSize) {
    for (int pix_y = 0; pix_y<height; pix_y+=PixelSize) {
      float xfirst = noise(pix_x*noiseSize+x, pix_y*noiseSize+y);
      float yfirst = noise(pix_y*noiseSize+y, pix_x*noiseSize+x);
      float xsmal = noise(pix_x*noiseSize*4+x*4, pix_y*noiseSize*4+y*4);
      float ysmal = noise(pix_y*noiseSize*4+y*4, pix_x*noiseSize*4+x*4);
      if (dist(x+width/2, y+height/2, pix_x, pix_y)<400f) {
        if (xfirst>0.55) {/*fill(#6dd5ed);*/
          fillcolor = (color(33, 147, 176, 200));
        }
        if (xfirst<=0.55&&xfirst>0.5) {/*fill(#6dd5ed);*/
          fillcolor = (color(247, 247, 22, 200));
        }
        if (xfirst<0.21) {/*fill(#6dd5ed);*/
          fillcolor = (color(245, 245, 245, 200)); //белый
        }
        if (xfirst<0.24&&xfirst>0.21) {/*fill(#6dd5ed);      серый*/
          fillcolor = (color(160, 160, 160, 200));
        }
        if (xfirst>0.24&&xfirst<0.4) {/*fill(#6dd5ed);       зелёный*/
          fillcolor = (color(0, 144, 10, 200));
          if (yfirst<0.45&&yfirst>0.43) {
            fillcolor = (color(33, 147, 176, 200));
          }
        }
        if (xfirst<0.5&&xfirst>0.4) {/*fill(#6dd5ed);      салатовый*/
          fillcolor = (color(0, 198, 11, 200));
          if (yfirst<0.45&&yfirst>0.43) {
            fillcolor = (color(33, 147, 176, 200));
          }
          if (yfirst<0.4&&yfirst>0.34) {
            fillcolor = (color(33, 147, 176, 200));
          }
        }
        for (int i = 0; i<_long; i++) {
          //if (dist(pix_x, pix_y, pix[i].pix_x/noiseSize-x/noiseSize-20, pix[i].pix_y/noiseSize-y/noiseSize-2)<pix[i].area/noiseSize) {fillcolor = color(51, 81, 48, 200);}
          //if (dist(x+width/2, y+height/2, pix[i].pix_x/noiseSize-x/noiseSize/pix[i].deepth, pix[i].pix_y/noiseSize-y/noiseSize/pix[i].deepth)<400f) {
          if (dist(pix_x, pix_y, pix[i].pix_x/noiseSize-x/noiseSize, pix[i].pix_y/noiseSize-y/noiseSize)<pix[i].area/noiseSize) {
            if (fillcolor!=color(51, 100, 48, 200)&&fillcolor!=color(51, 107, 48, 200)&&fillcolor!=color(255, 0, 0, 200)) { /////////&&fillcolor!=(color(245, 245, 245, 200))&&fillcolor!=(color(160, 160, 160, 200))&&fillcolor!=(color(33, 147, 176, 200))
              if ((xsmal<0.45&&xsmal>0.43)||(ysmal<0.45&&ysmal>0.43)) {
                fillcolor = color(51, 107, 48, 200);
              } else {
                fillcolor = color(51, 100, 48, 200);
              }
              if ((xsmal<0.45&&xsmal>0.43)||(ysmal<0.45&&ysmal>0.43)) {
                if (pix[i].type == 1)fillcolor = color(255, 0, 0, 200);
              }

              pix[i].killCount++;
            }
          }

          //}
          if (pix_x==pix[i].pix_x/noiseSize-x/noiseSize&&pix_y==pix[i].pix_y/noiseSize-y/noiseSize) {
            fillcolor = #2DFF00;
          }
          debs.prewArea = pix[i].area;
        }
        //if(fillcolor!=prewFill){
        fill(fillcolor);
        rect(pix_x, pix_y, PixelSize, PixelSize);
        //}
        //prewFill = fillcolor;
        fill(255-255*noise(pix_x*noiseSize+x, pix_y*noiseSize+y), 111);
        rect(pix_x, pix_y, PixelSize, PixelSize);
      }
    }
  }
}



void ButtonCheck() {
  if (keyPresses[SHIFT]) {
    noiseSize-=noiseSize/10;
    x+=mouseX*noiseSize/PixelSize/2;
    y+=mouseY*noiseSize/PixelSize/2;
  }
  if (keyPresses[CONTROL]) {
    noiseSize+=noiseSize/10;
    x-=mouseX*noiseSize/PixelSize/2;
    y-=mouseY*noiseSize/PixelSize/2;
  }
  if (keyPresses['s']) {
    y+=noiseSize*5;
  }
  if (keyPresses['w']) {
    y-=noiseSize*5;
  }
  if (keyPresses['d']) {
    x+=noiseSize*5;
  }
  if (keyPresses['a']) {
    x-=noiseSize*5;
  }
  //if (keyPresses['4']) {
  //  walkMode = !walkMode;
  //}

        
  //if (dist(x+width/2, y+height/2, pix[_long-1].pix_x/noiseSize-x/noiseSize, pix[_long-1].pix_y/noiseSize-y/noiseSize)<400f) {
  if (keyPresses[RIGHT]) {
    _long++;
    pix[_long-1] = new Pixel(pix[_long-2].pix_x+pix[_long-2].area/2, pix[_long-2].pix_y, random(0.1)+0.89, (int)(random(21)/10-1));
  } else if (keyPresses[LEFT]) {
    _long++;
    pix[_long-1] = new Pixel(pix[_long-2].pix_x-pix[_long-2].area/2, pix[_long-2].pix_y, random(0.1)+0.89, (int)(random(21)/10-1));
  }
  if (keyPresses[DOWN]) {
    _long++;
    pix[_long-1] = new Pixel(pix[_long-2].pix_x, pix[_long-2].pix_y+pix[_long-2].area/2, random(0.1)+0.89, (int)(random(21)/10-1));
  } else if (keyPresses[UP]) {
    _long++;
    pix[_long-1] = new Pixel(pix[_long-2].pix_x, pix[_long-2].pix_y-pix[_long-2].area/2, random(0.1)+0.89, (int)(random(21)/10-1));
  }
  //}
}



void Debug() {
  if (_long>1)text(pix[_long-2].killCount, 10, 10, 10);
  text(_long, 10, 20);
  text(seed, 10, 30);
  text(debs.prewArea, 10, 40);
  //text();
}


class Debuger {
  int ops;
  float prewArea;
  Debuger(int opsTemp) {
    ops = opsTemp;
  }
}


class Pixel {
  float deepth, pix_x, pix_y;
  int type, killCount;
  float area = random(0.02)+0.01;
  Pixel(float xTemp, float yTemp, float deepthTemp, int typeTemp) {
    deepth = deepthTemp;
    type = typeTemp;
    //pix_x = xTemp*PixelSize/noiseSize-x/noiseSize;
    //pix_y = yTemp*PixelSize/noiseSize-y/noiseSize;
    pix_x = xTemp;
    pix_y = yTemp;
  }
}

void keyPressed() {
  keyPresses[keyCode] = true;
  keyPresses[key] = true;
}
void keyReleased() {
  //if (keyPresses[' ']) {
    //save(str(screens)+".png");
    //screens++;
  //}
  keyPresses[keyCode] = false;
  keyPresses[key] = false;
}
