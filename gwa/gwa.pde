
class changers{
  int x, y, len, hei;
  changers(int a, int b, int l, int h){
    x=a;
    y=b;
    len=l;
    hei=h;
  }
  boolean triggered(){
    if(x<mouseX && mouseX<len+x && mouseY>y && y+hei>mouseY){
      return true;
    }
    else{return false;}
  }
}

class button extends changers{
    button(int x, int y, int l, int h, String name) {
      super(x, y, l, h);
      fill(60);
      rect(x,y,l,h);
      fill(255);
      textSize(30);
      text(name,x+l/4,y+35);
      
    }
}
button one, two, thr, fou;
String choosein="";
class slidedown extends changers{
    slidedown(int x, int y, int l, int h) {
      super(x, y, l, h);
      fill(255);
      rect(x,y,l,h,10);
      fill(0);
      triangle(x+250,y+20,x+260,y+20,x+255,y+30);
    }
    void menu(String O, String T, String Th, String F){
      one = new button(x,y+hei,len,hei,O);
      two = new button(x,y+hei*2,len,hei,T);
      thr = new button(x,y+hei*3,len,hei,Th);
      fou = new button(x,y+hei*4,len,hei,F);
      
    }
}

import gifAnimation.*;
import processing.video.*;

Movie Moy;
PImage back, img,vign, ply,cap, g;
PShape ca;
PGraphics pg;
Gif my;
GifMaker gifExport, gifExport2;
int modeSwitch, filterSwitch;
int H, L, Y;
int upX, upL, camX, savX, exX;
int slX, slY, slL, slH;
int s, e;
boolean slideDown, record,saveChose;
button up, camera, save, exit, vid, im;
slidedown choose;



void setup(){ 
    size(1700,980);
    background(0);
    fill(150);
    rect(47,117,1006,806);
    pg=createGraphics(1000,800);
    back=loadImage("ex.jpeg");
    img = loadImage("bricks.png");
    vign=loadImage("vign.png");
    ply=loadImage("ply.png");
    ca=loadShape("ca.svg");
    my = new Gif(this, "dd.gif");
    Moy=new Movie(this, "aa.mov");
    my.loop();
    Moy.play();
    
    H=50;
    L=130;
    Y=67;
    slX=1098;
    slY=57;
    slL=280;
    slH=50;
    
    slideDown=false;
    record=false;
    saveChose=false;

    modeSwitch=1;
    filterSwitch=0;
    up = new button(47,Y,260,H," SWITCH"); //upload button
    camera = new button(330,Y,L,H, ""); //camera button
    save = new button(480,Y,L,H,"SAVE"); //save button
    exit = new button(630,Y,L,H,"EXIT"); //exit button
    shape(ca,370,Y);
    fill(60);
    rect(1098,117,550,806); //sticker area
    choose = new slidedown(slX,slY,slL,slH); //slidedown menu
    
    gifExport = new GifMaker(this, "export.gif");
     
    
}

void draw(){
    if(filterSwitch==2){tint(60,160,195);}
    else{noTint();}
    
    showMode(modeSwitch);
    filterChoose(filterSwitch);
    
    if (modeSwitch==1){noTint();image(ply,525,925,50,50);tint(60,160,195);}
    
    if (saveChose){
      vid = new button(save.x,save.y+save.hei,save.len,save.hei,"Video");
      im = new button(save.x,save.y+save.hei*2,save.len,save.hei,"Image");
    }
    
    if (record){
      text("Saving...",780,90);
      e=millis();
      if (modeSwitch==1){
        if((e-s)/1000<Moy.duration()){
          cap = get(50,120,1000,800);
          gifExport.setDelay(200);
          gifExport.addFrame(cap);
        }
        else{
          gifExport.finish();
          fill(150);
          rect(47,117,1006,806);  
          fill(0);
          rect(780,67,130,50);
          record = false;
        }
      }
      else if (modeSwitch==2){
        if(e-s<5000){
          cap = get(50,120,1000,800);
          gifExport2.setDelay(200);
          gifExport2.addFrame(cap);
        }
        else{
          gifExport2.finish();
          fill(150);
          rect(47,117,1006,806);  
          fill(0);
          rect(780,67,130,50);
          record = false;
        }
      }
    }
    
}

void movieEvent(Movie m) {
  m.read();
}

void theRing(int in){
    if (in==1){
      img = loadImage("bricks.png");
      blend(img, 50, 120, 1000, 800, 50, 120, 1000, 800, DIFFERENCE);
    }
    else if (in==2){
      img = loadImage("bricks2.jpg");
      blend(img, 50, 120, 1000, 800, 50, 120, 1000, 800, SOFT_LIGHT);
    }
    
    blend(vign,50,120,1000,800,50,120,1000,800,DARKEST);
    blend(my, 50, 120, 1000, 800, 50, 120, 1000, 800, SOFT_LIGHT);
}

void showMode(int inn){
  if (inn==0){
    fill(0);
    rect(50,120,1000,800);
  }
  else if (inn==1){
    image(Moy,50,120,1000,800);
    
  }
  else if (inn==2){
    image(back,50,120,1000,800);
  }
}

void filterChoose(int innn){
  if (innn==0){}
  else if (innn==1){theRing(1);}
  else if (innn==2){theRing(2);}
  else if (innn==3){g=loadImage("im.png");blend(g,50, 120, 1000, 800, 50, 120, 1000, 800,OVERLAY);}
}

void mouseClicked(){
  if(up.triggered()){if(modeSwitch==1){modeSwitch=2;} else{modeSwitch=1;} }
  if (camera.triggered()){filterSwitch=2;}
  if(save.triggered()){
    saveChose=true;
  }
  
  
  if(exit.triggered()){exit();}
  if(choose.triggered()){choose.menu("RING-1","RING-2","MIDSOMMAR","NONE");slideDown=true;}
  
  if (modeSwitch==1){if(dist(mouseX,mouseY,550,950)<25){Moy.pause();Moy.jump(0);Moy.play();}}
  if(saveChose){  
    vid = new button(save.x,save.y+save.hei,save.len,save.hei,"Video");
    im = new button(save.x,save.y+save.hei*2,save.len,save.hei,"Image");
    if(vid.triggered()){
      if (modeSwitch==1){
        Moy.pause();
        Moy.jump(0);
        Moy.play();
        gifExport = new GifMaker(this, "export.gif");
      }
      else{gifExport2 = new GifMaker(this, "export2.gif");gifExport2.setRepeat(0); }
      s=millis();
      record = true;
      saveChose=false;
      }
      
    else if (im.triggered()){
      showMode(modeSwitch);
      filterChoose(filterSwitch);
      cap = get(50,120,1000,800);
      if (modeSwitch==1){cap.save("capture.png");}
      else{cap.save("capture2.png");}
      fill(150);
      rect(47,117,1006,806);
      saveChose=false;
    }
    else if (save.triggered()){
      
    }
    else{saveChose=false;}
  }
  if (slideDown){
    if(choose.triggered()){}
    else if(one.triggered()){filterSwitch=1;fill(255);noStroke();rect(choose.x+10,choose.y+10,206,40);fill(0);text("RING-1", choose.x+40, choose.y+35);}
    else if(two.triggered()){filterSwitch=2; fill(255);noStroke();rect(choose.x+10,choose.y+10,206,40);fill(0);text("RING-2", choose.x+40, choose.y+35);}
    else if(thr.triggered()){filterSwitch=3; fill(255);noStroke();rect(choose.x+10,choose.y+10,200,40);fill(0);text("MIDSOMMAR", choose.x+30, choose.y+35);}
    else if(fou.triggered()){filterSwitch=0;}
    else{
      slideDown=false;
      fill(0);
      rect(1098,107,550,15);
      fill(60);
      rect(1098,117,550,806); 
    }
    
  }
}
