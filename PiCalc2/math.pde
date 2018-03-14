public class Pi {
  private Vec pos = new Vec();
  private long r = 1;
  private long count;

  public ArrayList<Double> history = new ArrayList<Double>();

  public Vec size = new Vec(width / 2, height / 2);
  private Vec lastDraw = new Vec();

  public void drawHistory() {
    double min = Double.MAX_VALUE;
    double max = -1;
    int total = history.size();
    if (total == 1) {
      return;
    }

    for (int i = 0; i < total; i++) {
      double f = history.get(i);
      if (f < min) {
        min = f;
      }
      if (f > max) {
        max = f;
      }
    }

    fill(255);
    stroke(255, 0, 0);
    textSize(11);
    text((float) max * 4, size.x * 0.05, size.y + size.y * 0.15);
    text((float) min * 4, size.x * 0.05, size.y + size.y * 0.9);

    float space = size.x * 1.8 / total;

    float prevX = -1;
    float prevY = -1;

    for (int i = 0; i < total; i++) {
      //if (i == 0) continue;

      double f = history.get(i);
      float x = (size.x * 0.15) + (i * space);
      float y = size.y + size.y * 0.15 + map((float) f, (float) min, (float) max, (float) size.y * 0.75, 0);

      if (prevX >= 0 && prevY >= 0) {
        line(prevX, prevY, x, y);
      }

      //ellipse(x, y, 2, 2);

      prevX = x;
      prevY = y;
    }
  }

  public double calculate() {
    double total = r * r;
    double qPi = count / total;
    double pi = qPi * 4;
    if (count > 0) {
      history.add(qPi);

      //println(count + " / " + (long) total);
      //println("Quarter Pi: " + qPi);
      //println("Pi: " + pi);
      //println(" ");
    }

    if (exp) {
      r *= 10;
    } else {
      r++;
    }
    lastDraw.x = 0;
    lastDraw.y = 0;
    count = 0;
    pos.y = 0;
    pos.x = nextX();

    return pi;
  }

  public boolean run() {
    int drawX = (int) map(pos.x, 0, r, size.y / 2, size.y);
    int drawY = (int) map(pos.y, r, 0, size.x, size.x / 2);

    noStroke();
    int pW = 1;
    if (r < 1000) {
      pW = 2;
    }

    double len = pos.length();
    if (len < r) {
      fill(0, 255, 0);
      pos.x++;
    } else {

      count += pos.x;
      if (len > r) {
       count--; 
      }

      pos.y++;
      if (pos.y > r) {
        return true;
      }

      pos.x = nextX();
      fill(255, 0, 0);
    }

    if (lastDraw.y != drawY || lastDraw.x != drawX) {
      lastDraw.set(drawX, drawY);
      ellipse(drawY, drawX, pW, pW);
    }

    return false;
  }

  private long nextX() {
    return (long) Math.floor(Math.sqrt(r * r - pos.y * pos.y));
  }

}