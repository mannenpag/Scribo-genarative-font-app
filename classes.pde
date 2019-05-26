class Letter {
    int x, y, w, h;
    float alpha;

    PImage img;
    char s;

    Letter(char _s, int _x, int _y, int _w, int _h) {

        s = _s;
        x = _x;
        y = _y;
        w = _w;
        h = _h;

        if (alphabetCount == 0) {
            img = loadImage("data/letters/" + 0 + "/" + s + ".png");
        } else if (alphabetCount == 1) {
            img = loadImage("data/letters/" + 0 + "/" + s + ".png");
        } else if (alphabetCount > 1) {
            img = loadImage("data/letters/" + (alphabetCount - 1) + "/" + s + ".png");
        }
    }

    void display() {
        image(img, x, y, w, h);
    }
}

class BoundryBox {
    color c;
    float x;
    float y;
    float w;
    float h;

    BoundryBox(color _c, float _x, float _y, float _w, float _h) {
        c = _c;
        x = _x;
        y = _y;
        w = _w;
        h = _h;
    }

    void display() {
        fill(10);
        stroke(c);
        strokeWeight(.5);
        rect(x, y, w, h);
    }
}
