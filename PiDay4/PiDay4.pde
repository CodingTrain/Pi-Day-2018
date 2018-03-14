import processing.pdf.*;

String pi;

PGraphics canvas;


void setup() {
  size(800, 800);
  canvas = createGraphics(8000, 8000);

  float cols = 1000;
  float rows = 1000;

  pi = loadStrings("pi-1million.txt")[0];
  //println(pi.length());

  //beginRecord(PDF, "bookofpi.pdf");
  canvas.beginDraw();
  canvas.colorMode(HSB, 1.0);
  float w = canvas.width/cols;
  float h = canvas.height/rows;
  int index = 0;
  for (float y = 0; y < canvas.height; y += h) {
    for (float x = 0; x < canvas.width; x += w) {
      String s = "" + pi.charAt(index);
      int digit = int(s);
      float hue = digit/9.0;
      canvas.fill(hue, 1, 1);
      canvas.noStroke();
      canvas.rect(x, y, w, h);
      // fill(255-bright);
      //textAlign(CENTER,CENTER);
      //text(digit,x+w/2,y+h/2);
      index++;
      if (index >= pi.length()) {
        index = pi.length() - 1;
      }
    }
  }
  canvas.endDraw();
  image(canvas, 0, 0, width, height);
  canvas.save("posterofpi.png");
  println(index);
  //endRecord();
}
