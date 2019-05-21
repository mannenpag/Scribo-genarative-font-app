//PROCESSING APP FOR USERS TO DRAW A COLLABORATIVE TYPEFACE

// CREATORS
// 2019 Gustav Bodin, Chiara Martini, Ida Ström
// Academy of Art University 
// Instructor Colin Sebestyen

/*
 * MOUSE / Wacom Tablet
 * left click           : set points
 *
 * KEYS
 * left arrow           : clear drawing box 
 * right arrow          : save letter
 * backspace            : delete user input string
 * enter                : save string to data structure / display bellow
 * a-z                  : add letter to user input string and display the drawn letter
 */



//Strings
String buildString = "";
String[] allStrings = {};
String[] nameDisplay = {};
String gridString = "";
String displayString;
String alphabet = "abcdefghijklmnopqrstuvwxyz";

String galleryString = "";

//Counters
int count = 0;
int alphabetCount = 0;
int lettersCount = 0;
boolean switchString = true;

//Data Structure
Table table;

int width = 3840;
int height = 768;

PImage savingArea;
PFont h2Font;
PFont h1Font;

//Drawing box size
float sqW = 410;
float sqH = 410;
int sqX = round((width / 2) - (sqW / 2));
int sqY = round((height / 2) - (sqH / 2));

BoundryBox drawingBox;

boolean isEmpty = true;
boolean drawing = false;
boolean isTyping = false;

//Set up colors for the drawing 
color c = color(255, 255, 255, 40);


void setup() {
    clear();
    size(3840, 768);
    background(10);
    noCursor();

    //PImage cursor;
    //cursor = loadImage("data/cursor.png");

    //cursor(cursor, round(30), round(30));

    //Font
    h1Font = createFont("data/font/IBMPlexMono-ExtraLight.ttf", 30, true);
    h2Font = createFont("data/font/IBMPlexMono-ExtraLight.ttf", 25, true);

    stroke(c);
    fill(c);

    //SET UP DATA STRUCTURE
    table = new Table();
    table.addColumn("index");
    table.addColumn("names");

    //Set up drawing area
    drawingBox = new BoundryBox(color(240), sqX, sqY, sqW, sqH);
    drawingBox.display();
    setInstructions();

    println(frameRate);
}

void draw() {
    //REFRESH THE CANVAS TO MAP THE DRAWING POINT
    CanvasRefresh();

    mX = map(mouseX, 0, width, width / 3, (width / 3) * 2);
    mY = mouseY;
    ellipse(mX, mY, 2, 2);

    if (mousePressed) {
        drawing = true;
    }

    if (pointList.size() >= 1) {
        isEmpty = false;
    }
    if (pointList.size() <= 0) {
        isEmpty = true;
    }

    boolean inside = pointRect(mX, mY, sqX, sqY, sqW, sqH);
    if (inside && drawing) {
        CanvasRefresh();
        fill(c);
        ellipse(mX, mY, 2, 2);
        addPoints();
        drawPoints();
    }

    if (!inside) {
        CanvasRefresh();
        fill(c);
        ellipse(mX, mY, 2, 2);
        drawPoints();
    }
}

void keyPressed() {
    // CAN ONLY USE THE DESIRED KEYES
    if (int(key) >= 97 && int(key) <= 122 && buildString.length() < 6) {
        buildString += key;
    }
    if (keyCode == RIGHT && !isEmpty) {
        char c = alphabet.charAt(count);

        if (gridString.length() < 27) {
            gridString += alphabet.charAt(count);
        }


        for (int i = pointList.size() - 1; i >= 0; i--) {
            pointList.remove(i);
        }

        if (count <= 25) {
            PImage savingArea = get(sqX + 2, sqY + 2, 400, 400);
            savingArea.save("data/letters/" + alphabetCount + "/" + c + ".png");
        }
        lettersCount = 0;
        count++;

        if (gridString.length() == 26) {
            gridString = "";
        }

        if (count == 26) {
            count = 0;
            alphabetCount++;
            createOutput("data/letters/" + alphabetCount + "/" + alphabetCount + "");
        }

        CanvasRefresh();

    }
    if (keyCode == LEFT && !isEmpty) {
        for (int i = pointList.size() - 1; i >= 0; i--) {
            pointList.remove(i);
        }
        CanvasRefresh();
    }
}

//Build conditional boolean 
void showText(String userString) {
    if (userString.length() >= 1) {
        isTyping = true;
    }
    if (userString.length() <= 0) {
        isTyping = false;
    }

    // LOOP TROUGH A STRING AND FETCH AN IMG
    for (int i = 0; i < userString.length(); i++) {
        tint(255, 255);
        Letter l = new Letter(userString.charAt(i), 200 * i, 120, 200, 200);
        l.display();
        switchString = true;
        //On delete remove last index
        if (keyCode == 8) {
            //buildString.remove(i);
            buildString = "";
            CanvasRefresh();
        }
    }
    // LOOP TROUGH A STRING AND FETCH AN IMG
    if (keyCode == 10 && switchString == true) {
        TableRow newRow = table.addRow();
        newRow.setInt("index", table.lastRowIndex());
        newRow.setString("names", buildString);
        saveTable(table, "data/names.csv");
        buildString = "";
        switchString = false;
        //Refresh the canvas
        CanvasRefresh();
    }
}

//Build conditional boolean 
void showName() {
    int lastRowIndex = table.lastRowIndex();
    //println(lastRowIndex);

    if (lastRowIndex > -1) {
        String[] temp = append(nameDisplay, table.getString(table.lastRowIndex(), "names"));
        //printArray(temp);

        for (int i = 0; i < table.getString(table.lastRowIndex(), "names").length(); i++) {
            tint(255, 255);
            Letter l = new Letter(table.getString(table.lastRowIndex(), "names").charAt(i), 200 * i, 500, 200, 200);
            l.display();
        }
    }
}

//String to display recent letters
String makeDisplayString(String gridString, int displayNum) {
    String displayString = "";
    int gridLength = gridString.length();
    if (gridLength > 2) {
        for (int i = gridLength - 1; i > gridLength - displayNum; i--) {
            //print(appString.charAt(i-1));
            displayString += gridString.charAt(i);
        }
    }
    return displayString;
}

void grid(int positionGrid) {
    //println(displayString);
    int gridSize = 400;

    if (count == 0 && alphabetCount >= 1) {
        displayString = "zyx";
        for (int i = 0; i < displayString.length(); i++) {
            PImage img;

            char c = displayString.charAt(i);
            img = loadImage("data/letters/" + ((alphabetCount) - 1) + "/" + c + ".png");
            tint(255, 255 - (20 * i));
            image(img, positionGrid + (gridSize * i), (height / 2) - (gridSize / 2), gridSize, gridSize);
        }
    }
    if (count == 1) {
        displayString = "a";
        for (int i = 0; i < displayString.length(); i++) {
            PImage img;

            char c = displayString.charAt(0);
            img = loadImage("data/letters/" + alphabetCount + "/" + c + ".png");
            tint(255, 255 - (20 * i));
            image(img, positionGrid + (gridSize * i), (height / 2) - (gridSize / 2), gridSize, gridSize);
        }
    }
    if (count == 2) {
        displayString = "ba";
        for (int i = 0; i < displayString.length(); i++) {
            PImage img;

            char c = displayString.charAt(i);
            img = loadImage("data/letters/" + alphabetCount + "/" + c + ".png");
            tint(255, 255 - (100 * i));
            image(img, positionGrid + (gridSize * i), (height / 2) - (gridSize / 2), gridSize, gridSize);
        }
    }
    if (count >= 3) {
        displayString = makeDisplayString(gridString, 4);
        for (int i = 0; i < displayString.length(); i++) {
            PImage img;

            char c = displayString.charAt(i);
            img = loadImage("data/letters/" + alphabetCount + "/" + c + ".png");
            tint(255, 255 - (100 * i));
            image(img, positionGrid + (gridSize * i), (height / 2) - (gridSize / 2), gridSize, gridSize);
        }
    }
}

//Refresh the canvas
void CanvasRefresh() {
    background(10);
    showText(buildString);
    drawingBox.display();
    setInstructions();
    showName();
    grid(width - (width / 3));

    //if (frameCount % 60 == 0){
    //    background(10);
    //}

    if (frameCount % 60 == 0 && !isTyping) {
        stroke(255);
        line(20, 120, 20, 320);
    }
}
