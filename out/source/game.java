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

PaintingCanvas p;
public void setup() {
    
    frameRate(60);
    p = new PaintingCanvas(height, width, 40, new PVector(0, 0), true);
}

public void draw() {
    p.display();
}

public void mouseDragged(MouseEvent event){
    p.handleClick(event);
}






  public void settings() {  size(400, 500); }
  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "game" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
