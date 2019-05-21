//Instructions
String displayLetter = "ABCDEFGHIJKLMNOPQRSTUVWXYZ";

//Lables
String left = "_Test";
String instructionsLeft = "Type to test";

String right = "_Display";
String instructionsRight = "Recently drawn letters";

String center = "_Draw";
String instructions = "Draw the displayed letter in the prompt bellow";
String save = "Right arrow to save";
String delete = "Left arrow to delete";

int spacing = 45;

void setInstructions() {
    fill(255);
    textFont(h1Font, 40);
    text(left, 10, spacing);
    text(center, (width / 3) + 10, spacing);
    text(right, ((width / 3) * 2) + 10, spacing);
    textFont(h2Font, 30);
    fill(255, 255, 255, 150);
    text(instructions, (width / 3) + 10, spacing * 2);
    text(instructionsRight, ((width / 3) * 2) + 10, spacing * 2);
    text(instructionsLeft, 10, spacing * 2);
    
    char instC = displayLetter.charAt(count);
    textFont(h2Font, 470);
    if (isEmpty){
        textFont(h2Font, 470);
        fill(c);
        text(instC, sqX + sqW/2-145, height/2+170);
    }
    
    if (!isEmpty) {
        textFont(h2Font, 20);
        fill(255);
        text(delete, sqX - 150 , height-140);
        text(save, sqX + sqW - 120, height-140);
    }
}
