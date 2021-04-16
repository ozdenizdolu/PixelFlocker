class Patch {
    PVector position, velocity, acceleration;
    float perceptionRange;
    float mass;
    Patch() {
        this.position = new PVector(random(width), random(height));
        this.velocity = new PVector(random( - 2,3), random( - 2,3));
        this.acceleration = new PVector();
        this.perceptionRange = 25.0;
        this.mass = 10;
    }
    Patch(PVector position, PVector velocity, PVector acceleration, float perceptionRange, float mass) {
        this.position = position;
        this.velocity = velocity;
        this.acceleration = acceleration;
        this.perceptionRange = perceptionRange;
        this.mass = mass;
    }
    Patch(PVector position) {
        this();
        this.position = position;
    }
    PVector cohesion(ArrayList<Patch> patches) {
        PVector avg = new PVector();
        int totalPerceptiblePatches = 0;
        for (Patch patch : patches) {
            if (this.perceptionRange >= this.position.dist(patch.position)) {
                avg.add(patch.position);    
                totalPerceptiblePatches++;
                // might need to exclude this patch in this calculation
            }
        }
        avg.div(totalPerceptiblePatches);
        PVector steering = new PVector();
        steering = PVector.sub(avg, this.position);
        steering.div(this.mass);
        return steering;
    }
    PVector align(ArrayList<Patch> patches) {
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
        steering.div(this.mass);
        return steering;
    }
    void update(ArrayList<Patch> patches) {
        this.position.add(this.velocity);
        this.velocity.add(this.acceleration);
        this.acceleration = align(patches);
        this.acceleration.add(cohesion(patches));
    }
    void draw() {
        ellipse(position.x, position.y, 15, 15);
    }
}