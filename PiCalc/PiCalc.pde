/*
 * Computation of the n'th decimal digit of \pi with very little memory.
 * Written by Fabrice Bellard on January 8, 1997.
 *
 * We use a slightly modified version of the method described by Simon
 * Plouffe in "On the Computation of the n'th decimal digit of various
 * transcendental numbers" (November 1996). We have modified the algorithm
 * to get a running time of O(n^2) instead of O(n^3log(n)^3).
 *
 * This program uses mostly integer arithmetic. It may be slow on some
 * hardwares where integer multiplications and divisons must be done
 * by software. We have supposed that 'int' has a size of 32 bits. If
 * your compiler supports 'long long' integers of 64 bits, you may use
 * the integer version of 'mul_mod' (see HAS_LONG_LONG).
 */


int mul_mod(int a, int b, int m) {
  return (int) (((long)a * (long)b) % (long) m);
}

/* return the inverse of x mod y */
int inv_mod(int x, int y)
{
  int q, u, v, a, c, t;

  u = x;
  v = y;
  c = 1;
  a = 0;
  do {
    q = v / u;

    t = c;
    c = a - q * c;
    a = t;

    t = u;
    u = v - q * u;
    v = t;
  } while (u != 0);
  a = a % y;
  if (a < 0)
    a = y + a;
  return a;
}

/* return (a^b) mod m */
int pow_mod(int a, int b, int m)
{
  int r, aa;

  r = 1;
  aa = a;
  while (true) {
    if (b % 2 == 1)
      r = mul_mod(r, aa, m);
    b = b >> 1;
    if (b == 0)
      break;
    aa = mul_mod(aa, aa, m);
  }
  return r;
}

/* return true if n is prime */
boolean is_prime(int n)
{
  int r, i;
  if ((n % 2) == 0)
    return false;

  r = (int) (sqrt(n));
  for (i = 3; i <= r; i += 2)
    if ((n % i) == 0)
      return false;
  return true;
}

/* return the prime number immediatly after n */
int next_prime(int n)
{
  do {
    n++;
  } while (!is_prime(n));
  return n;
}

int getDigit(int n) {

  int av, a, vmax, N, num, den, k, kq, kq2, t, v, s, i;
  double sum;

  N = (int) ((n + 20) * log(10) / log(2));

  sum = 0;

  for (a = 3; a <= (2 * N); a = next_prime(a)) {

    vmax = (int) (log(2 * N) / log(a));
    av = 1;
    for (i = 0; i < vmax; i++)
      av = av * a;

    s = 0;
    num = 1;
    den = 1;
    v = 0;
    kq = 1;
    kq2 = 1;

    for (k = 1; k <= N; k++) {

      t = k;
      if (kq >= a) {
        do {
          t = t / a;
          v--;
        } while ((t % a) == 0);
        kq = 0;
      }
      kq++;
      num = mul_mod(num, t, av);

      t = (2 * k - 1);
      if (kq2 >= a) {
        if (kq2 == a) {
          do {
            t = t / a;
            v++;
          } while ((t % a) == 0);
        }
        kq2 -= a;
      }
      den = mul_mod(den, t, av);
      kq2 += 2;

      if (v > 0) {
        t = inv_mod(den, av);
        t = mul_mod(t, num, av);
        t = mul_mod(t, k, av);
        for (i = v; i < vmax; i++)
          t = mul_mod(t, a, av);
        s += t;
        if (s >= av)
          s -= av;
      }
    }

    t = pow_mod(10, n - 1, av);
    s = mul_mod(s, t, av);
    //sum = fmod(sum + (double) s / (double) av, 1.0);
    sum = (sum + (double) s / (double) av) % 1.0;
  }
  //println(sum);
  return (int) (sum * 10);
}

String pie;
int counter = 1;

PrintWriter output;

void setup() {
  output = createWriter("pi.txt");
  pie = "3.";
  output.print("3.");
}

void draw() {
  background(0);
  int digit = getDigit(counter);
  output.print(digit);  // Write the coordinate to the file
  output.flush();  // Writes the remaining data to the file
  //pie += digit;
  //println(pie);
  counter++;
  fill(255);
  textAlign(CENTER);
  text(counter,width/2,height/2);
}
