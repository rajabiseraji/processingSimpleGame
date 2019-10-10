import processing.core.*; 
import processing.data.*; 
import processing.event.*; 
import processing.opengl.*; 

import java.util.HashMap; 
import java.util.ArrayList; 
import java.io.File; 
import java.io.BufferedReader; 
import java.io.PrintWriter; 
import java.io.InputStream; 
import java.io.OutputStream; 
import java.io.IOException; 

public class game extends PApplet {

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
    public PShape getShape();
    public void display();
}

interface Clickable {
    public void handleClick(MouseEvent event); 
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
    String currentText, finalText;
    int currentCharIndex = 0;
    int elapsedTime = 0; // ms
    int startTime = 0; // ms
    int maxTime = 0; // miliseconds
    int maxTimePerWord = 500; // ms
    boolean isClosing = false;

    TextBubble(String initText, PFont textFont, int maxTimePerWord, PVector position) {
        this.textFont = textFont;
        textFont(textFont);
        this.finalText = initText;
        this.currentText = this.finalText.substring(0, this.currentCharIndex);
        this.maxTimePerWord = maxTimePerWord;
        this.maxTime = this.finalText.split(" ").length * maxTimePerWord;
        this.position = position;
        this.startTime = millis();
    }

    public void updateText() {
        elapsedTime = millis() - this.startTime;
        if(elapsedTime >= maxTime)
            this.isClosing = true;
        delay(50);
        if(this.currentCharIndex < this.finalText.length() && !this.isClosing)
            this.currentCharIndex++;
        else if(this.isClosing && this.currentCharIndex > 0)
            this.currentCharIndex--;
        this.currentText = this.finalText.substring(0, this.currentCharIndex);
        display();
    }

    public void setText(String newText) {
        this.finalText = newText;
        this.isClosing = false;
    }

    public void display() {
        float textXPostion = (width - 20 - textWidth(this.finalText)) / 2;
        text(this.currentText, textXPostion, this.position.y, width - 20, height - 40);
    }

    public PShape getShape() {
        return this.bubble;
    }
}

PaintingCanvas p;
TextBubble t;
PFont minecraft;
public void setup() {
    
    minecraft = createFont("Minecraft.ttf", 24);
    // textFont(minecraft);
    frameRate(60);
    p = new PaintingCanvas(height, width, 40, new PVector(0, 0), true);
    t = new TextBubble("Okay, now that you've seen it all, you know there's nothing here right? ", minecraft, 1000, new PVector(20, height-40));
}

public void draw() {
    p.display();
    t.updateText();
}

public void mouseDragged(MouseEvent event){
    p.handleClick(event);
}






  public void settings() {  size(1000, 600); }
  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "game" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
