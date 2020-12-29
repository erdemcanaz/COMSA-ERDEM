import java.awt.*;
import java.awt.event.*;
import java.awt.datatransfer.*;
import javax.swing.*;
import java.io.*;

PImage f1;
//PRE-INPUT
int pixel_accuracy_y=1;//px
int pixel_accuracy_x=1;//px
int color_accuracy= 10;//0-255 scale
//RUN-TIME INPUT
int upper_left[] = new int[2]; //x,y
int lower_right[] = new int[2]; //x,y
int picked_color[] = new int[3]; //RGB
float data[]= new float[105];
//


void setup() {
  size(1000, 500);
  background(255); 
  f1 = loadImage("func1.png");
  image (f1, 0, 0);
}
void draw() {
}

void copy_data() {

  String selection = "[";
  for (int i=0; i<100; i++) {
    selection += String.valueOf(data[i])+" ";
  }
  selection +="];";

  StringSelection toClipboard = new StringSelection(selection);
  Clipboard clipboard = Toolkit.getDefaultToolkit().getSystemClipboard();
  clipboard.setContents(toClipboard, toClipboard);
}
void extract_function_data() {  
  strokeWeight(4);
  float px_to_x=1.0f/(lower_right[0]-upper_left[0]);
  float px_to_y=1.0f/(lower_right[1]-upper_left[1]);

  for (float x=upper_left[0]; x<= lower_right[0]; x+=0.9) {
    float  y=0;
    for (y = upper_left[1]; y<= lower_right[1]; y+=0.1) {
      if (compare_color((int)x, (int)y)) {        
        point(x+500, y);       
        data[(int)((100*(x-upper_left[0]))/(lower_right[0]-upper_left[0]))] = (lower_right[1]-y)*px_to_y;        
        break;
      }
    }
    if (y>lower_right[1]) {
      data[(int)((100*(x-upper_left[0]))/(lower_right[0]-upper_left[0]))] = -1;
      point(x+500, y);
    }
  }
}
boolean compare_color(int x, int y) {
  picked_color[0]=(int)red(get(x, y));
  if (abs(picked_color[0]-(int)red(get(x, y)))>color_accuracy)return false;
  if (abs(picked_color[1]-(int)green(get(x, y)))>color_accuracy)return false;
  if (abs(picked_color[2]-(int)blue(get(x, y)))>color_accuracy)return false;
  return true;
}
//#################################################################################
boolean color_pick= false;
void keyPressed() { 
  if (key=='p') {    
    color_pick= !color_pick;
    if (color_pick) {
      background(0, 255, 0);
      image (f1, 0, 0);
    } else {
      background(255);
      image (f1, 0, 0);
    }
    println("Color pick:"+color_pick);
  } else if (key=='e') {
    background(255);
    image (f1, 0, 0);
    extract_function_data();
  } else if (key=='v') {
    background(255);
    image (f1, 0, 0);
    copy_data();
  }
}

void mouseClicked() {
  if (color_pick) {
    picked_color[0]=(int)red(get(mouseX, mouseY));
    picked_color[1]=(int)green(get(mouseX, mouseY));
    picked_color[2]=(int)blue(get(mouseX, mouseY));
    println("picked color: "+picked_color[0]+" , "+picked_color[1]+" , "+picked_color[2]);
  } else {
    if (mouseButton==LEFT) {
      upper_left[0]=mouseX;
      upper_left[1]=mouseY;
      println("upper_left: ", mouseX, mouseY);
    } else {
      lower_right[0]=mouseX;
      lower_right[1]=mouseY;
      println("lower_right: ", mouseX, mouseY);
    }
  }
}
