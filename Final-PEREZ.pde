// Project 5 - Loic Perez

String title=  "Project 5 - Final";
String author= "Loïc Perez";

String instruction1= "Use the letter 't' to move the tallest at the end";
String instruction2= "Use the letter 'f' to move the fattest at the end";
String instruction3= "Use the letter 'r' to reset the guys with a new random weight and height";
String instruction4= "Use the letter 'o' to order from the shortest to the tallest";

String name[]= {"Bridge", "Cathy", "Titi", "Lizzie", "Bob", "Metek", "MacFarmer", "TeFian", "Pepite"};
int amount=9;

Person[] people=  new Person[amount];

float surface;
float sky;

float cloudX = 100, cloudY = 100;
float cloudMovement = 1;
float amountCloud=9;

int last;

int buttonY = 200;
int buttonSize = 80;

boolean buttonOver1 = false;
boolean buttonOver2 = false;
boolean buttonOver3 = false;
boolean buttonOver4 = false;
 
int [] buttonX = {520, 640, 760, 880};

void setup() {
  size(960, 640);
  surface = height-100;
  sky = height/3;
  display();
}

void display() {
  for (int j = 0; j < amount; j+= 1) {
    people[j]=  new Person(name[j]);
  }
}


void draw() {
  background(90, 120, 180);

  scene();
  displayPeople();
  cloud();
  button();
  update();
  message();
}

void keyPressed() {
  if      (key == 'e') exit();
  else if (key == 't') tall(people, amount);
  else if (key == 'f') fat(people, amount);
  else if (key == 'o') order(people, amount);
  else if (key == 'r') rand(people, amount);
}

// Exchange values
void xchange(Person[] p, int a, int b) {
  Person temp;
  temp=  p[a];
  p[a]=  p[b];
  p[b]=  temp;
}

// Move the tallest to the end
void tall( Person[] p, int last ) {
  int k=0;
  for (int j = 1; j < last; j+=1 ) {
    if (p[j].h > p[k].h) k=j;
  }
  xchange(p, k, last-1);
}

// Move the fattest to the end
void fat( Person[] p, int last ) {
  int k=0;
  for (int j = 1; j < last; j+=1 ) {
    if (p[j].w > p[k].w) k=j;
  }
  xchange(p, k, last-1);
}

// Order the number from the smallest to the biggest
void order ( Person[] p, int last) {
  for (int j = last; j > 1; j-= 1) {
    tall(p, j);
  }
}


// Reset with a random value
void rand(Person[] p, int last) {

  for (int j = 0; j < last; j+=1) {
    p[j].w = random(20, 100);
    p[j].h = random(20, 100);
  }
} 

void scene() {
  noStroke();
  fill(180, 150, 150);
  rectMode(CORNERS);
  rect(0, surface, width, height);
}

void displayPeople() {
  float x=100, y=surface;  // First person displayed at x=100 & y= surface
  fill(0);
  text("Height:\nWeight:", 10, surface+35);  // Text height & weight
  for (int j = 0; j < amount; j+= 1) {
    people[j].show(x, y);
    x =  x + 100;
  }
}  

class Person {
  float x, w, h;
  float r, g, b;
  String name;

  Person( String friend ) {
    w = random(20, 100);     // Random weight from 20 to 50
    h = random(20, 100);    // Random height from 50 to 100
    r = random(255);        // Random red 
    g = random(255);        // Random green 
    b = random(255);        // Random blue 
    name = friend;
  }

  void show(float x, float y) {
    fill(r, g, b);
    rectMode(CENTER);
    stroke(0);
    rect(x, y-h/2, w, h);            // Body
    float shoulder=  y-h;            // Shoulder height
    float hh=  h/3;                  // Head height
    head(x, shoulder-hh/2, hh);

    // Display name, weight and height of each person
    fill(0);
    text(name, x-20, y+20);          // Name
    text(int(h), x-20, y+36);        // Height
    text(int(w), x-20, y+54);        // Weight
    //fill(0);
    //text( name, 2+x-w/2, y-h/2 );  Name on the guy: not necessary...
  }
  void head(float x, float headY, float hh) {
    // Head
    ellipse(x, headY, hh, hh);
    // Mouth
    fill(255, 0, 0);                  // Red part
    rect(x, headY+6, 4+w/4, 6);
    fill(255);                        // White part
    rect(x, headY+6, w/4, 2);
    // Eyes
    fill(255);                        // White part
    ellipse(x-6, headY-6, 8, 8);
    ellipse(x+6, headY-6, 8, 8);
    fill(0, 0, 255);                  // Blue part
    ellipse(x-6, headY-6, 4, 4);
    ellipse(x+6, headY-6, 4, 4);
  }
}

void message() {
  int space = 20;

  fill(0);
  textSize(12);

  text(title, 20, 15);
  text(author, 20, 30);

  text(instruction1, width/2, 50);
  text(instruction2, width/2, 50 + space);
  text(instruction3, width/2, 50 + (space*2));
  text(instruction4, width/2, 50 + (space*3));
  
  text("Tallest", buttonX[0]-20, buttonY+5);
  text("Fattest", buttonX[1]-20, buttonY+5);
  text("Order", buttonX[2]-15, buttonY+5);
  text("Random", buttonX[3]-18, buttonY+5);
}

void cloud() {
  fill(255, 255, 255);

  float tempX = cloudX, tempY = cloudY, tempW = 60, tempH = 25;

  for (int j=0; j < amountCloud; j+=1) {  // Loop to generate the clouds
    ellipse(tempX, tempY, tempW, tempH);
    tempX = tempX - tempW;
    tempY = tempY + tempH;
    tempW *= 0.8;
    tempH *= 0.8;
  }
  cloudX = cloudX + cloudMovement;   // Movement

  if (cloudX > width + 250) {  // Reset the cloud and generates a random number at a random height
    cloudX = 0;
    cloudY = random(0, sky);
    amountCloud = random(1, 9);
  }
}

void mousePressed() {
    if      (buttonOver1) {
      tall(people, amount);
  } else if (buttonOver2) {
      fat(people, amount);
  } else if (buttonOver3) {
      order(people, amount);
  } else if (buttonOver4) {
      rand(people, amount);
  }
}

void button() {
  float last = 4;

  fill(60, 90, 150);

  for ( int j = 0; j < last; j+=1) {
    ellipse(buttonX[j], buttonY, buttonSize, buttonSize);
  }
}

void update() {
  if (overButton (buttonX[0], buttonY, buttonSize, buttonSize) ) {
    buttonOver1 = true;
    buttonOver2 = false;
    buttonOver3 = false;
    buttonOver4 = false;
  } else if (overButton (buttonX[1], buttonY, buttonSize, buttonSize) ) {
    buttonOver1 = false;
    buttonOver2 = true;
    buttonOver3 = false;
    buttonOver4 = false;
  } else if (overButton (buttonX[2], buttonY, buttonSize, buttonSize) ) {
    buttonOver1 = false;
    buttonOver2 = false;
    buttonOver3 = true;
    buttonOver4 = false;
  } else if (overButton (buttonX[3], buttonY, buttonSize, buttonSize) ) {
    buttonOver1 = false;
    buttonOver2 = false;
    buttonOver3 = false;
    buttonOver4 = true;
  }
}

boolean overButton(int x, int y, int width, int height) {
  if (mouseX >= x-40 && mouseX <= x+40 && mouseY >= y-40 && mouseY <= y+40) {
    return true;
  } else {
    return false;
  }
}
