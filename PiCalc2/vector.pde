public class Vec {
  public long x;
  public long y;

  public Vec() {
    set(0, 0);
  }

  public Vec(long _x, long _y) {
    set(_x, _y);
  }

  public void set(long _x, long _y) {
    x = _x;
    y = _y;
  }

  public double length() {
    return Math.sqrt(x * x + y * y);
  }

}