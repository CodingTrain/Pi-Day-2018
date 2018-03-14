const r = 200;
let total = 0,
    circle = 0,
    recordPI = 0;

function setup() {
    createCanvas(402, 402);
    background(51);
    translate(width / 2, height / 2);
    stroke(255);
    noFill();
    ellipse(0, 0, r * 2, r * 2);
    rectMode(CENTER);
    rect(0, 0, r * 2, r * 2);
}

function draw() {
    translate(width / 2, height / 2);

    for (let i = 0; i < 100000; i++) {
        let x = random(-r, r),
            y = random(-r, r),
            d = x * x + y * y;
        total++;
        if (d < r * r) {
            circle++;
            stroke(100, 255, 0, 100);
        } else {
            stroke(0, 100, 255, 100);
        }
        strokeWeight(1);
        point(x, y);
    }
    let pi = 4 * (circle / total),
        recordDiff = Math.abs(Math.PI - recordPI),
        diff = Math.abs(Math.PI - pi);
    if (diff < recordDiff) {
        recordDiff = diff;
        recordPI = pi;
        console.log(recordPI);
    }
}