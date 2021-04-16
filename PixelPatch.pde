class PixelPatch extends Patch {
    color clr;
    PixelPatch() {
        super();
        this.clr = color(random(255), random(255), random(255));
    }
    PixelPatch(color c) {
        super();
        this.clr = c;
    }
    PixelPatch(PVector position, color c) {
        super(position);
        this.clr = c;
    }
    void draw() {
        fill(clr);
        stroke(clr);
        strokeWeight(5);
        point(this.position.x, this.position.y);
    }
}