String filename = "test";
String fileext = ".jpg";
String foldername = "./";
PGraphics pg;
PImage img;

ArrayList<Patch> flock;
void setup() {
    img = loadImage(foldername + filename + fileext);
    size(img.width, img.height);
    pg = createGraphics(img.width, img.height);
    pg.beginDraw();
    pg.noStroke();
    pg.smooth(8);
    pg.background(0);
    pg.image(img, 0, 0);
    pg.endDraw();
    flock = new ArrayList<Patch>();
    for (int i = 0; i < 300; i++) {
        int pixelX = int(random(width));
        int pixelY = int(random(height));
        flock.add(new PixelPatch(
            new PVector(pixelX, pixelY),
            pg.get(pixelX, pixelY)));
        // flock.add(new Patch());
    }
    image(pg, 0, 0, img.width, img.height);
}

void mousePressed() {
    for (Patch p : flock) {
        p.velocity = new PVector(random(-2,3)*p.speedMultiplier, random(-2, 3)*p.speedMultiplier);
    }
}

void draw() {
    for (Patch p : flock) {
        p.draw();
        p.update(flock);
    }
}