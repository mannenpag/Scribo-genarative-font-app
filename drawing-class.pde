int timer = 1;
int limit = 200;
float distLimit = 80;

boolean isDrawing = false;
ArrayList < PVector > pointList = new ArrayList < PVector > ();

void addPoints() {
    if (mouseButton == LEFT) {
        isDrawing = true;
    }

    if (isDrawing) {

        boolean cond1 = frameCount % timer == 0;
        boolean cond2 = pointList.size() < limit;

        if (cond1 && cond2) {
            PVector currentPosition = new PVector(mX, mY);
            pointList.add(currentPosition);
        }
    }
}

void drawPoints() {
    for (int i = 0; i < pointList.size(); i++) {
        PVector point = pointList.get(i);
        for (int j = 0; j < pointList.size(); j++) {
            if (i != j) {
                PVector point2 = pointList.get(j);
                if (dist(point.x, point.y, point2.x, point2.y) < distLimit) {
                    stroke(c);
                    fill(c);
                    line(point.x, point.y, point2.x, point2.y);
                }
            }
        }
        stroke(c);
        fill(c);
        ellipse(point.x, point.y, 1, 1);
    }
}

void mouseReleased() {
    isDrawing = false;
}
