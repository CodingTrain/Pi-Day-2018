boolean exp = false;
int limit = 100;
double bestPi;
Pi pi;

void setup() {
  pi = new Pi();
  size(1000, 1000);
  reset();
}

void draw() {
  for (int i = 0; i < limit; i++) {
    if (pi.run()) {
      reset();
    }
  }

  fill(23);
  noStroke();
  rect(pi.size.x, 0, pi.size.x, pi.size.y);

  fill(255);
  textAlign(LEFT);
  textSize(14);

  float total = pi.pos.y * pi.r;
  float qPi = pi.count / total;
  float currentPi = qPi * 4;

  float precision = (float) 100 / pi.r;
  float accuracy = (float) 100 - precision;
  text("Best Pi: " + bestPi, pi.size.x + 50, 80);
  text("Precision: " + precision, pi.size.x + 50, 130);
  text("Accuracy: " + accuracy + '%', pi.size.x + 50, 180);
  text("Generation: " + pi.history.size(), pi.size.x + 50, 230);

  text(pi.count + " / " + total, pi.size.x + 50, 330);
  text("Quarter Pi: " + qPi, pi.size.x + 50, 380);
  text("Pi: " + currentPi, pi.size.x + 50, 430);

  fill(51);
  rect(0, pi.size.y, width, pi.size.y);
  pi.drawHistory();
}

void reset() {
  bestPi = pi.calculate();
  println(pi.history);

  background(80);
  fill(0, 0, 255, 100);
  noStroke();
  ellipse(pi.size.x / 2, pi.size.y / 2, pi.size.x, pi.size.y);

  stroke(255);
  line(0, pi.size.x / 2, pi.size.x, pi.size.y / 2);
  line(pi.size.x / 2, 0, pi.size.x / 2, pi.size.y);

  fill(255);
  noStroke();
  textAlign(CENTER);
  textSize(14);

  text("Y", pi.size.x / 2 - 20, 40);
  text("X", 20, pi.size.y / 2 - 20);
  //text((int) pi.r, pi.size.x / 2 * 1.5, pi.size.y / 2 + 25);
}