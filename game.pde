/**
* timeless (second edition!)
* Mohammad Rajabi Seraji
* Game
* A simple game using processing
**/
 
 /**
Things to do: 

1. create a displayable class
2. create a text-dsiaply thing
3. game manager (or board) class
4. create Interactable class (?)
5. 


How to add font:
PFont minecraft;
minecraft = createFont("Minecraft.ttf", 16);
PFont raleway;
minecraft = createFont("Raleway-Thin.ttf", 16);
 */

PaintingCanvas p;
TextBubble t;
PFont minecraft;
String[] texts = new String[3];
int currentStringIndex = 0;

void setup() {
    size(1000, 600);
    minecraft = createFont("Minecraft.ttf", 24);
    // textFont(minecraft);
    frameRate(60);
    p = new PaintingCanvas(height, width, 40, new PVector(0, 0), true);
    texts[0] = "Okay, now that you've seen it all, you know there's nothing here right? ";
    texts[1] = "Well I'm back in white too! You caused me a lot of troubles though!";
    texts[2] = "so get the hell out of here!";
    t = new TextBubble(texts[0], minecraft, 1000, new PVector(20, height-40));
}

void draw() {
    p.display();
    t.updateText();
    if(t.isItFinshed()) {
        currentStringIndex++;
        t.setText(texts[currentStringIndex]);
    }

}

void mouseDragged(MouseEvent event){
    p.handleClick(event);
}






