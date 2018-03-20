String newPi = "";
int[] dig;
int index;


int[] counts = new int[10]; 
void setup() {
  size(1920, 1080);
  dig = int(loadStrings("pi.txt")[0].split(""));
}

void draw() {
  background(0);
  int digit = dig[index];
  index++;
  counts[digit]++;
  fill(255);
  textSize(16);
  newPi += "" + digit;
  if (frameCount % 220 ==0) newPi += "\n";
  float total = 0.0;
  for (int i = 0; i < counts.length; i++) {
    total += counts[i];
  }

float pX =0;
  for (int i = 0; i < counts.length; i++) {
    float perc = (counts[i]/total);
    float w = (perc*width);
    float hue = map(i, 0, 9, 0, 255);
    colorMode(HSB);
    fill(hue, 255, 255);
    rect(pX, 0, w+pX, height);
    fill(255);
    text( i+ " | " + floor(perc*100) + "%",pX+20,20);
    pX += w;
  }
  fill(255,0,0,200);
  text(newPi, 0, 50);
}
