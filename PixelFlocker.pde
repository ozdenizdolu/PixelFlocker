String filename = "test";
String fileext = ".png";
String foldername = "./";
PGraphics pg;
PImage img;

Patch p;
void setup() {
    img = loadImage(foldername+filename+fileext);
    size(img.width, img.height);
    pg = createGraphics(img.width, img.height);
    pg.beginDraw();
    pg.noStroke();
    pg.smooth(8);
    pg.background(0);
    pg.image(img, 0, 0);
    pg.endDraw();
    p = new Patch();
    image(pg, 0, 0, img.width, img.height);
}
void draw() {
    fill(0);
    p.draw();
    p.update();
}