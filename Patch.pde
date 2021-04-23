class Patch {
    PVector position, velocity, acceleration;
    float perceptionRange;
    float mass;
    float cohesionPower = 0.4, separationPower = 2, alignPower = 1;
    float speedMultiplier = 0.8;
    Patch() {
        this.position = new PVector(random(width), random(height));
        this.velocity = new PVector(random(-2,3)*speedMultiplier, random(-2, 3)*speedMultiplier);
        this.acceleration = new PVector();
        this.perceptionRange = 80.0;
        this.mass = 50;
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

    boolean isVisible(Patch p) {
        boolean isMe = this == p;
        boolean isInRange = this.perceptionRange >= this.position.dist(p.position);
        return !isMe && isInRange;
    }
    
    Patch setPowers(float cohesionPower, float separationPower, float alignPower) {
        this.cohesionPower = cohesionPower;
        this.separationPower = separationPower;
        this.alignPower = alignPower;
        return this;
    }
    PVector separation(ArrayList<Patch> patches) {
        PVector steering = new PVector();
        //int totalPerceptiblePatches = 0;
        for (Patch patch : patches) {
            if (isVisible(patch)) {
                PVector reverseDirection = PVector.sub(this.position, patch.position);
                reverseDirection.div(reverseDirection.mag());
                steering.add(reverseDirection);    
                //totalPerceptiblePatches++;
            }
        }
        //steering.div(totalPerceptiblePatches);
        steering.div(this.mass);
        return steering;
    }
    PVector cohesion(ArrayList<Patch> patches) {
        PVector avg = new PVector();
        int totalPerceptiblePatches = 0;
        for (Patch patch : patches) {
            if (isVisible(patch)) {
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
            if (isVisible(patch)) {
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
        float oldVelocityMagnitude = this.velocity.mag();
        this.velocity.add(this.acceleration);
        this.velocity.setMag(oldVelocityMagnitude);
        if (this.position.x < 0 || this.position.x >= width) {
            this.position.x = this.position.x % width;
        }
        if (this.position.y < 0 || this.position.y >= height) {
            this.position.y = this.position.y % height;
        }
        
        this.acceleration = PVector.mult(align(patches), alignPower);
        this.acceleration.add(PVector.mult(cohesion(patches), cohesionPower));
        this.acceleration.add(PVector.mult(separation(patches), separationPower));
    }
    void draw() {
        ellipse(position.x, position.y, 15, 15);
    }
}