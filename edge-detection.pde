//based on http://jeffreythompson.org/collision-detection/point-rect.php
//april 24th 2019  

float mX = 0;
float mY = 0;

boolean pointRect(float mX, float mY, float rx, float ry, float rw, float rh) {

    if (mX >= rx &&
        mX <= rx + rw &&
        mY >= ry &&
        mY <= ry + rh) {
        return true;
    }
    return false;
}
