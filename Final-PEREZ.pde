// Project 5 - Loic Perez

String title=  "Project 5 - Final";
String author= "Loïc Perez";

String instruction= "Use the letter 'q' to exit";
String instruction1= "Use the letter 't' to move the tallest at the end";
String instruction2= "Use the letter 'f' to move the fattest at the end";
String instruction3= "Use the letter 'r' to reset the guys with a new random weight and height";
String instruction4= "Use the letter 'o' to order from the shortest to the tallest";
String instruction5 = "Use the letter '1' to display the first array (in case you are on the second)";
String instruction6 = "Use the letter '2' to display the second array";

String name[]= {"Bridge", "Cathy", "Titi", "Lizzie", "Bob", "Metek", "MacFarmer", "TeFian", "Pepite"};
String namePerez[]= {"Jeje", "Jean", "Quentin", "Lucas", "Christian", "Cloa", "Marlyse", "Chrisitine", "Tom", "lucette", "Vincent"};

int amount=9;
int amount1 = 11;

Person[] people=  new Person[amount];
Person[] perez = new Person[amount1]; 

float surface;
float sky;

float average;

float xSun = 100, ySun = 150, sunSize = 40;
float xMoon = 100, yMoon = 150, moonSize = 40;

float cloudX = 100, cloudY = 100;
float cloudMovement = 1;
float amountCloud=9;

float pct25 = 1.25;

int last;

int buttonY = 200;
int buttonSize = 80;

boolean buttonOver1 = false;
boolean buttonOver2 = false;
boolean buttonOver3 = false;
boolean buttonOver4 = false;

int [] buttonX = {60, 180, 300, 420};

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
    for (int j = 0; j < amount1; j+= 1) {
    perez[j]=  new Person(namePerez[j]);
  }
}


void draw() {
  background(120, 150, 210);

  scene();
  displayPeople();
  cloud();
  button();
  update();
  message();
  displaySecondArray();
}

void keyPressed() {
  if      (key == 'q') exit();
  else if (key == 't') tall(people, amount);
  else if (key == 'f') fat(people, amount);
  else if (key == 'o') order(people, amount);
  else if (key == 'r') reset(people, amount);
}


void displaySecondArray() {
  if (key == '2') {
    displayPerez();
  } else if (key == '1'){
    displayPeople();
  }
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
void reset(Person[] p, int last) {

  for (int j = 0; j < last; j+=1) {
    p[j].w = random(20, 100);
    p[j].h = random(20, 100);
    p[j].age = random(1,99);
    p[j].salary = random(1000,100000);
  }
} 

// Scene
void scene() {
  noStroke();
  fill(180, 150, 150);
  rectMode(CORNERS);
  rect(0, surface, width, height);
  
  // Grass
  stroke(50,240,50);
  int i = 0;
  
  while (i < width) {
    line(i, surface, i-15, surface-20);
    i = i + 5;
  }

}

// Display People
void displayPeople() {
  float x=100, y=surface;  // First person displayed at x=100 & y= surface
  fill(0);
  text("Height:\nWeight:\nAge:\nSalary:", 10, surface+35);  // Text height & weight
  for (int j = 0; j < amount; j+= 1) {
    people[j].show(x, y);
    x =  x + 100;
  }
    fill(255,255,0);
  ellipse(xSun,ySun,sunSize,sunSize);
  
  xSun = xSun +1;
  
  if (xSun > width) {
   xSun = 0;
  } 
}


// Display Perez
void displayPerez() {
  background(60, 90, 150);
  
  cloud();
  button();
  update();
  message();
  
  // Moon
  fill(255,255,255);
  ellipse(xMoon,yMoon,moonSize,moonSize);
  
  xMoon = xMoon +1;
  
  if (xMoon > width) {
   xMoon = 0;
  } 
  float x=100, y=surface;  // First person displayed at x=100 & y= surface
  fill(0);  
  text("Height:\nWeight:\nAge:\nSalary:", 10, surface+35);  // Text height & weight
    for (int j = 0; j < amount; j+= 1) {
    perez[j].show(x, y);
    x =  x + 100;
  } 
  
  // Grass
  stroke(50,240,50);
  int i = 0;
  
  while (i < width) {
    line(i, surface, i+15, surface-20);
    i = i + 5;
  }

}


// Class Person
class Person {
  float x, w, h;
  float r, g, b;
  float age,salary;
  String name;

  Person( String friend ) {
    w = random(20, 100);     // Random weight from 20 to 50
    h = random(20, 100);    // Random height from 50 to 100
    r = random(255);        // Random red 
    g = random(255);        // Random green 
    b = random(255);        // Random blue 
    age = random(1,99);      // Age
    salary = random(1000,100000); // Salary
    name = friend;          // name
  }

  void show(float x, float y) {
    fill(r, g, b);
    rectMode(CENTER);
    stroke(0);
    rect(x, y-h/2, w, h);            // Body
    float shoulder=  y-h;            // Shoulder height
    float hh=  h/3;                  // Head height
    head(x, shoulder-hh/2, hh);

    // Display name, weight,height, age & salary of each person
    fill(0);
    text(name, x-20, y+20);          // Name
    text(int(h), x-20, y+36);        // Height
    text(int(w), x-20, y+54);        // Weight
    text(int(age), x-20, y+72);      // Age
    if (int(age) > 18) {
    text("$", x-30, y+90);           // $ sign
    text(salary, x-20, y+90);        // salary
    }
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
  void raise(float pct) {
    // Increase salary by pct
    salary = salary*pct25;
  }
  void bonus(float amt) {
    // Increase salary by amount
   salary = salary + 1000;
  }
}

// Message on the screen
void message() {
  int space = 20;

  fill(0);
  textSize(12);

  text(title, 20, 15);
  text(author, 20, 30);
  text("Average salary: " + average, width/2, 80 - space);
  
  average = people[0].salary + people[1].salary + people[2].salary + people[3].salary + people[4].salary 
  + people[5].salary + people[6].salary + people[7].salary + people[8].salary / 9;

  text(instruction, width/20, 80 - space);
  text(instruction1, width/20, 80);
  text(instruction2, width/20, 80 + space);
  text(instruction3, width/20, 80 + (space*2));
  text(instruction4, width/20, 80 + (space*3));
  text(instruction5, width/20, 80 + (space*12));
  text(instruction6, width/20, 80 + (space*13));
  
  text("Tallest", buttonX[0]-20, buttonY+5);
  text("Fattest", buttonX[1]-20, buttonY+5);
  text("Order", buttonX[2]-15, buttonY+5);
  text("Reset", buttonX[3]-18, buttonY+5);
  
  
}

// Cloud 
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

// Button function / MousePressed
void mousePressed() {
    if      (buttonOver1) {
      tall(people, amount);
  } else if (buttonOver2) {
      fat(people, amount);
  } else if (buttonOver3) {
      order(people, amount);
  } else if (buttonOver4) {
      reset(people, amount);
  }
}

// Button Loop
void button() {
  float last = 4;

  fill(60, 90, 150);

  for ( int j = 0; j < last; j+=1) {
    ellipse(buttonX[j], buttonY, buttonSize, buttonSize);
  }
}

// Click on the button function
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

// Define the click
boolean overButton(int x, int y, int width, int height) {
  if (mouseX >= x-40 && mouseX <= x+40 && mouseY >= y-40 && mouseY <= y+40) {
    return true;
  } else {
    return false;
  }
}


