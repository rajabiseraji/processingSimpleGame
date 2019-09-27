/**
* timeless (second edition!)
* Mohammad Rajabi Seraji
* Timeless, Making an innovative digital clock
* These are three interleaved circles with a common centre
* that each represent a portion of the clock (Hour, minute, second, miliseconds)
**/

import java.util.Map;
import java.util.concurrent.TimeUnit;

Map<String,Integer> measureRangeMap = new HashMap<String,Integer>();
final int DEFAULT_CLOCK_MAX_RADIUS = 480; // default maximum radius of our clock ~ 240px for hour circle
final int DEFAULT_MINUTES_RADIUS = 360; // default minute clock radius ~ 240px for min circle
final int DEFAULT_SECONDS_RADIUS = 240; // default seconds clock radius ~ 120px for s circle 
// Some colors
final color METALIC_SEEWEED = #028090;
final color PERSIAN_GREEN = #00A896;
final color CARIBBEAN_GREEN = #02C39A;
final color PALE_SPRING_BUD = #F0F3BD;
// load the font
PFont raleway;
// final int DEFAULT_MILISECONDS_RADIUS = 20; // default seconds clock radius ~ 20 for ms circle 
final PVector DEFAULT_CLOCK_CENTER = new PVector(500 ,500);
SomeNewClock instance;

void setup() {
    background(#05668d);
    raleway = createFont("Raleway-Thin.ttf", 16);
    size(1000, 1000);
    measureRangeMap.put("h", 23);
    measureRangeMap.put("m", 59);
    measureRangeMap.put("s", 59);
    measureRangeMap.put("ms", 99);
    instance = new SomeNewClock();
    smooth(4);
}

void draw() {
    instance.drawClock();
}

// public final class myTimeSource {
//     public int seconds() {
//         return 
//     }
// } 

class SomeNewClock {
    private int alarmSec = 0;
    private int alarmMin = 0;
    private int alarmHour = 0;
    private int s;
    private int m;
    private int h;
    private int ms;
    private ClockCircle hourCircle;
    private ClockCircle minCircle;
    private ClockCircle secondCircle;
    // private ClockCircle msCircle;
    private PShape ourClock;

    SomeNewClock() {
        this.s = second();
        this.m = minute();
        this.h = hour();
        hourCircle = new ClockCircle(23, DEFAULT_CLOCK_MAX_RADIUS, DEFAULT_CLOCK_CENTER.x, DEFAULT_CLOCK_CENTER.y, DEFAULT_MINUTES_RADIUS, PERSIAN_GREEN, METALIC_SEEWEED, color(40), radians(98));
        minCircle = new ClockCircle(59, DEFAULT_MINUTES_RADIUS, DEFAULT_CLOCK_CENTER.x, DEFAULT_CLOCK_CENTER.y, DEFAULT_SECONDS_RADIUS, CARIBBEAN_GREEN, METALIC_SEEWEED, color(40), radians(98));
        secondCircle = new ClockCircle(59, DEFAULT_SECONDS_RADIUS, DEFAULT_CLOCK_CENTER.x, DEFAULT_CLOCK_CENTER.y, 0, PALE_SPRING_BUD, METALIC_SEEWEED, color(40), radians(98));
    }

    // SomeNewClock(int minute, int second, int hour) {
    //     this.s = second;
    //     this.m = minute;
    //     this.h = hour;
    //     hourCircle = new ClockCircle(23, DEFAULT_CLOCK_MAX_RADIUS, DEFAULT_CLOCK_CENTER.x, DEFAULT_CLOCK_CENTER.y, DEFAULT_MINUTES_RADIUS, PERSIAN_GREEN, METALIC_SEEWEED, color(40), radians(98));
    //     minCircle = new ClockCircle(59, DEFAULT_MINUTES_RADIUS, DEFAULT_CLOCK_CENTER.x, DEFAULT_CLOCK_CENTER.y, DEFAULT_SECONDS_RADIUS, CARIBBEAN_GREEN, METALIC_SEEWEED, color(40), radians(98));
    //     secondCircle = new ClockCircle(59, DEFAULT_SECONDS_RADIUS, DEFAULT_CLOCK_CENTER.x, DEFAULT_CLOCK_CENTER.y, 0, PALE_SPRING_BUD, METALIC_SEEWEED, color(40), radians(98));
    // }

    public void setAlarm() {

    }

    private void drawNumbers() {
        textFont(raleway, 50);
        fill(40);
        text(String.format("%02d", second()), secondCircle.getNumberLocation().x, secondCircle.getNumberLocation().y);
        textFont(raleway, 60);
        text(String.format("%02d", minute()), minCircle.getNumberLocation().x, minCircle.getNumberLocation().y);
        textFont(raleway, 70);
        text(String.format("%02d", hour()), hourCircle.getNumberLocation().x, hourCircle.getNumberLocation().y);
    }

    public void drawClock() {
        ourClock = createShape(GROUP);
        ourClock.addChild(hourCircle.updateClock(hour()));
        ourClock.addChild(minCircle.updateClock(minute()));
        ourClock.addChild(secondCircle.updateClock(second()));
        shape(ourClock);
        drawNumbers();
    }
}


class ClockCircle {
    // fields of the class go here
    //private Map<String, Integer> measureMapSystem;
    private final int MAX_RANGE; // maximum value this circle can represent
    private final float MAX_RADIUS; // radius of the biggest filled circle inside this circle
    private final float MIN_RADIUS; // radius of the smallest filled circle inside this circle
    private final float RADIUS_INCREMENT_STEP; // The step of incremenation of filled circles 
    private PVector CIRCLE_CENTER; // center coords of the circle
    private final float angel; // angel between the lines
    final color textColor;
    final color innerFillColor; // fill color of inner circle that fills the outer one
    final color outerFillColor; // fill color of the outer circle
    private int currentValue = 0; // current represented value by the circle, initially 0
    private float currentRadius; // current radius that corresponds to current value
    private PShape circleShape; // this is the geometrical representation of the clock circle

    // first signature
    // timeUnit can be: h , m, s, ms represeting different times units
    ClockCircle (String timeUnit, Map measureRangeMap, int maxRadius, int centerX, int centerY, float initialRadius, color innerFill, color outerFill, color textColor, float angel) {
        int maxRange = (int) measureRangeMap.get(timeUnit); // get the corresponding number of each unit from the map 
        //if (maxRange && maxRadius) { // if time unit exists in the map
            this.MAX_RANGE = maxRange;
            this.MAX_RADIUS = maxRadius;
            this.MIN_RADIUS = initialRadius;
            this.RADIUS_INCREMENT_STEP = (MAX_RADIUS - MIN_RADIUS) / maxRange; 
            this.CIRCLE_CENTER = new PVector(centerX, centerY); // set the CENTER constant
            this.currentRadius = initialRadius;
            this.innerFillColor = innerFill;
            this.outerFillColor = outerFill;
            this.textColor = textColor;
            this.angel = angel;
        //} 
    }

    // second signature
    // this one receives and sets the basic constant fields of the class
    ClockCircle (int maxRange, int maxRadius, float centerX, float centerY, float initialRadius, color innerFill, color outerFill, color textColor, float angel) {
        this.MAX_RANGE = maxRange + 1;
        this.MAX_RADIUS = maxRadius;
        this.MIN_RADIUS = initialRadius;
        this.RADIUS_INCREMENT_STEP = (MAX_RADIUS - MIN_RADIUS) / maxRange;
        this.CIRCLE_CENTER= new PVector(centerX, centerY); // set the CENTER constant
        this.currentRadius = initialRadius; // set the initial value of the current radius
        this.innerFillColor = innerFill;
        this.outerFillColor = outerFill;
        this.textColor = textColor;
        this.angel = angel;
    }

    // This version will be used by external functions to set the fields value and radius
    public void setValue(int value, int radius) {
        this.setCurrentValue(value);
        this.setCurrentRadius(radius);
    }

    // This version uses an X and Y position to find the interaction and then sets the values
    public void setValue(float positionX, float positionY) {

    }

    private void createCircleShape() {
        ellipseMode(RADIUS);
        stroke(this.outerFillColor);
        circleShape = createShape(GROUP);
        PShape outerCircle = createShape(ELLIPSE, this.CIRCLE_CENTER.x, this.CIRCLE_CENTER.y, this.MAX_RADIUS, this.MAX_RADIUS);
        outerCircle.setFill(outerFillColor);
        PShape innerCircle = createShape(ELLIPSE, this.CIRCLE_CENTER.x, this.CIRCLE_CENTER.y, this.currentRadius, this.currentRadius);
        innerCircle.setFill(innerFillColor);
        circleShape.addChild(outerCircle);
        circleShape.addChild(innerCircle);
    }

    public PVector getNumberLocation() {
        float numberXPostion = this.CIRCLE_CENTER.x - 30;
        float numberYPostion = this.CIRCLE_CENTER.y - this.MAX_RADIUS + ((this.MAX_RADIUS - this.MIN_RADIUS) / 2);
        return new PVector(numberXPostion, numberYPostion);
    }

    public PShape updateClock(int newValue) {
        if (newValue <= this.MAX_RANGE) {
            this.setCurrentValue(newValue);
            float newRadius = this.MIN_RADIUS + newValue * RADIUS_INCREMENT_STEP;
            this.setCurrentRadius(newRadius);
            this.createCircleShape();
            // println("newValue: "+newValue);
        } 
        return this.circleShape;
    }

    public void setCurrentValue(int newCurrentValue) {
        this.currentValue = newCurrentValue;
    }

    public int getCurrentValue() {
        return this.currentValue;
    }

    public void setCurrentRadius(float newCurrentRadius) {
        this.currentRadius = newCurrentRadius;
    }

    public float getCurrentRadius() {
        return this.currentRadius;
    }
}



