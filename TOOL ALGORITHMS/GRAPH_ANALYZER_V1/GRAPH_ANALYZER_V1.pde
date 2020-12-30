import java.awt.*;
import java.awt.event.*;
import java.awt.datatransfer.*;
import javax.swing.*;
import java.io.*;


PImage f1;
PImage background;
//PRE-INPUT
int pixel_accuracy_y=1;//px
int pixel_accuracy_x=1;//px
int color_accuracy= 10;//0-255 scale
//RUN-TIME INPUT
int upper_left[] = new int[2]; //x,y
int lower_right[] = new int[2]; //x,y
int picked_color[] = new int[3]; //RGB
float data[]= new float[105];


int CIRCLE_DIAMETER=3;
//LOWER MENU
String NAME ="";
String SUB_NAME= "";
int NO= 0;
String X_NAME="";
String Y_NAME="";
float X_CONV=0;
float Y_CONVER=0;
boolean IS_PROPER=false;
//RIGHT MENU
int which_is_active=-1;



void setup() {
  size(1100, 625);
  background(255); 
  f1 = loadImage("func1.png");
  background = loadImage("background_transparent.png");
  image (f1, 0, 0);
  image(background, 0, 0);
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
  if(key=='s')CIRCLE_DIAMETER=3;
  else if(key=='d')CIRCLE_DIAMETER=20;
  else if(key=='r')image(f1,0,0);
}

void mouseDragged() 
{
    if(which_is_active==11){
      if(mouseX>500 || mouseY>500) return;
      stroke(255);fill(255);
      circle(mouseX, mouseY, CIRCLE_DIAMETER);
    }
    else if(which_is_active==12){
      if(mouseX>500 || mouseY>500) return;
      stroke(picked_color[0],picked_color[1],picked_color[2]);fill(picked_color[0],picked_color[1],picked_color[2]);
      circle(mouseX, mouseY, CIRCLE_DIAMETER);
    }
}
void mouseClicked() {
  int clicked_button=onWhichButton();  
  //MENU  
  if (clicked_button==10)which_is_active=10;
  else if (clicked_button==11)which_is_active=11;
  else if (clicked_button==12)which_is_active=12;
  else if (clicked_button==13)which_is_active=13;
  else if (clicked_button==14)which_is_active=14;
  else if (clicked_button==8)IS_PROPER=!IS_PROPER;
  //ON GRAPH
  else if (clicked_button==0) {
    if (which_is_active==10) {
      picked_color[0]=(int)red(get(mouseX, mouseY));
      picked_color[1]=(int)green(get(mouseX, mouseY));
      picked_color[2]=(int)blue(get(mouseX, mouseY));
    }
    else if(which_is_active==11){
      if(mouseX>500 || mouseY>500) return;
      stroke(255);fill(255);
      circle(mouseX, mouseY, CIRCLE_DIAMETER);
    }
    else if(which_is_active==12){
      if(mouseX>500 || mouseY>500) return;
      stroke(picked_color[0],picked_color[1],picked_color[2]);fill(picked_color[0],picked_color[1],picked_color[2]);
      circle(mouseX, mouseY, CIRCLE_DIAMETER);
    }
    else if(which_is_active==13){
      if(mouseX>500 || mouseY>500) return;
      upper_left[0]=mouseX;
      upper_left[1]=mouseY;
    }
    else if(which_is_active==14){
      if(mouseX>500 || mouseY>500) return;
      lower_right[0]=mouseX;
      lower_right[1]=mouseY;
    }
  }
}

int onWhichButton() {
  int x= mouseX;
  int y= mouseY;
  if (x<500&&y<500)return 0; //CLICK ON GRAPH
  if (x>8&&x<406&&y>500&&y<550)return 1;//NAME
  else if (x>406&&x<592&&y>500&&y<550)return 2;//SUB NAME
  else if (x>592&&x<657&&y>500&&y<550)return 3;//NO
  else if (x>657&&x<776&&y>500&&y<550)return 4;//X-NAME
  else if (x>776&&x<895&&y>500&&y<550)return 5;//Y-NAME
  else if (x>895&&x<974&&y>500&&y<550)return 6;//X-CONVERSION
  else if (x>974&&x<1051&&y>500&&y<550)return 7;//Y-CONVERSION
  else if (x>1051&&y>500&y<550)return 8;// IS PROPER ?
  else if (x>1000&&y>550) return 9;//COPY TO CLIPBOARD
  else if (x>996 &&y<62) return 10; //PICK COLOR
  else if (x>996&&y>126&&y<185)return 11;//ERASE
  else if (x>996&&y>185&&y<247) return 12;//DRAW
  else if (x>996&&y>247&&y<304)return 13;//UPPER LEFT
  else if (x>996&&y>370&&y<430)return 14;//LOWER RIGHT
  else return -1;
}
