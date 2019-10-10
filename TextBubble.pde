
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
    boolean isFinished = false;

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

        if(this.currentCharIndex == 0 && this.isClosing)
            this.isFinished = true;
        this.currentText = this.finalText.substring(0, this.currentCharIndex);
        display();
    }

    public void setText(String newText) {
        this.startTime = millis();
        this.finalText = newText;
        this.currentText = this.finalText.substring(0, this.currentCharIndex);
        this.maxTime = this.finalText.split(" ").length * maxTimePerWord;
        this.isClosing = false;
        this.isFinished = false;
    }

    public boolean isItFinshed() {
        return this.isFinished;
    }

    public void display() {
        float textXPostion = (width - 20 - textWidth(this.finalText)) / 2;
        text(this.currentText, textXPostion, this.position.y, width - 20, height - 40);
    }

    public PShape getShape() {
        return this.bubble;
    }
}
