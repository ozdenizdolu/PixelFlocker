class Patch {
    PVector position, velocity, acceleration;
    float perceptionRange;
    Patch() {
        this.position = new PVector(random(width), random(height));
        this.velocity = new PVector(random(-2,3), random(-2,3));
        this.acceleration = new PVector();
        this.perceptionRange = 25.0;
    }
    void align(ArrayList<Patch> patches) {
        PVector avg = new PVector();
        int totalPerceptiblePatches = 0;
        for (Patch patch : patches) {
            if (this.perceptionRange >= this.position.dist(patch.position)) {
                avg.add(patch.velocity);    
                totalPerceptiblePatches++;
                // might need to exclude this patch in this calculation
            }
        }
        avg.div(totalPerceptiblePatches);
        PVector steering = new PVector();
        steering = PVector.sub(avg, this.velocity);
        this.acceleration = steering;
    }
    void update() {
        this.position.add(this.velocity);
        this.velocity.add(this.acceleration);
    }
    void draw() {
        ellipse(position.x, position.y, 15, 15);
    }
}