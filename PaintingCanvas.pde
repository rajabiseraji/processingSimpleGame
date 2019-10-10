
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
