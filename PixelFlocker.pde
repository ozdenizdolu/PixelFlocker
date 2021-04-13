Patch p;
void setup() {
   size(512, 512); 
   background(255);
   p = new Patch();
}
void draw() {
    fill(0);
    p.draw();
    p.update();
}