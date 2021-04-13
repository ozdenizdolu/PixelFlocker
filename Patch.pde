class Patch {
    PVector position, velocity, acceleration;
    Patch() {
        this.position = new PVector();
        this.velocity = new PVector(1, 1);
        this.acceleration = new PVector();
    }
    void update() {
        this.position.add(this.velocity);
        this.velocity.add(this.acceleration);
    }
    void draw() {
        ellipse(position.x, position.y, 15, 15);
    }
}