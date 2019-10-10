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

// Any subclass should implement the display method
interface Displayable {
    PShape getShape();
    void display();
}

interface Clickable {
    void handleClick(MouseEvent event); 
}

// Let's create a black painting page
public class PaintingCanvas implements Displayable, Clickable {
    float canvasHeight, canvasWidth;
    float brushCircleRadius = 10;
    boolean drawingIsAllowed = false;
    PVector canvasUpperLeftCorner;
    PShape canvas; 

    PaintingCanvas(float canvasHeight, float canvasWidth, float brushCircleRadius, PVector position,boolean drawingIsAllowed) {
        this.canvasHeight = canvasHeight;
        this.canvasWidth = canvasWidth;
        this.brushCircleRadius = brushCircleRadius;
        this.drawingIsAllowed = drawingIsAllowed;
        this.canvasUpperLeftCorner = position;
        this.canvas = createShape(GROUP);
        PShape rectangle = createShape(RECT, position.x, position.y, canvasWidth, canvasHeight);
        rectangle.setFill(0);
        this.canvas.addChild(rectangle);
    }

    public void increaseBrushSize() {
        this.brushCircleRadius += 4;
    }

    public void display() {
        shape(this.canvas);
    }

    public PShape getShape() {
        return this.canvas;
    }

    public void handleClick(MouseEvent event) {
        PShape newEllipse = createShape(ELLIPSE, event.getX(), event.getY(), this.brushCircleRadius/2, this.brushCircleRadius/2);
        newEllipse.setFill(color(255, 255, 255));
        newEllipse.setStroke(color(255, 255, 255));
        this.canvas.addChild(newEllipse);
    }

}

public class TextBubble implements Displayable {
    PShape bubble;
    PFont textFont;
    PVector position;
    String currentText;
    int currentCharIndex = 0;
    float elapsedTime = 0; // ms
    int startTime = 0; // ms
    int maxTime = 0; // miliseconds
    int maxTimePerWord = 500; // ms
    boolean isClosing = false;

    TextBubble(String initText, PFont textFont, int maxTimePerWord, PVector position) {
        this.textFont = textFont;
        textFont(textFont);
        this.currentText = initText;
        this.maxTimePerWord = maxTimePerWord;
        this.maxTime = this.currentText.split(" ").length * maxTimePerWord;
        this.position = position;
        this.startTime = millis();
    }

    public void updateText() {
        elapsedTime = millis() - this.startTime;
        if(elapsedTime >= maxTime)
            this.isClosing = true;

        if(this.currentCharIndex < this.currentText.length() && !this.isClosing)
            this.currentCharIndex++;
        else if(this.isClosing && this.currentCharIndex > 0)
            this.currentCharIndex--;

        display();
    }

    public void setText(String newText) {
        this.currentText = newText;
        this.isClosing = false;
    }

    public void display() {
        text(this.currentText, 0, this.currentCharIndex, this.position.x, this.position.y);
    }

    public PShape getShape() {
        return this.bubble;
    }
}

PaintingCanvas p;
TextBubble t;
PFont minecraft;
void setup() {
    size(400, 500);
    minecraft = createFont("Minecraft.ttf", 16);
    // textFont(minecraft);
    frameRate(60);
    p = new PaintingCanvas(height, width, 40, new PVector(0, 0), true);
    t = new TextBubble("hey what are you doing!", minecraft, 100, new PVector(20, height-40));
}

void draw() {
    p.display();
    t.updateText();
}

void mouseDragged(MouseEvent event){
    p.handleClick(event);
}






