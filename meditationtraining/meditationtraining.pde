import oscP5.*;
import netP5.*;
import ddf.minim.*;
final int N_CHANNELS = 4;
int levels = 4;
int musics = 10;
int num = 0;

float[] dataMin = {0,0,0,0,0,0};
float[] dataMax = {0,0,0,0,0,0};

float plotX1, plotY1;
float plotX2, plotY2;
float labelX, labelY;
 
PFont plotFont;

final color BG_COLOR1 = color(0, 0, 0);
final color BG_COLOR2 = color(255,255,255);
final color BG_COLOR3 = color(127,127,127);
final color BG_COLOR4 = color(0,127,127);
final color BG_COLOR5 = color(127,127,0);

final int PORT = 5001;
OscP5 oscP5 = new OscP5(this, PORT);

Minim minim;
AudioPlayer [] player =new AudioPlayer[musics];
AudioPlayer [] player1 =new AudioPlayer[musics];

PrintWriter output;
float[] data2;
float[] data3;
String[] results1 = {"","","","",""};
String[] results2 = new String[1000];
int count1 = 0;
int count2 = 0;
String put1 = "";
String put2 = "";
int[] check = {0,0,0,0,0,0,0,0,0,0};
float[] datalist1 = {0,0,0,0,0,0,0,0,0,0};
float[] datalist2 = {0,0,0,0,0,0,0,0,0,0};
float[] datalist3 = {0,0,0,0,0,0,0,0,0,0};
float[] datalist4 = {0,0,0,0,0,0,0,0,0,0};
float[] datalist5 = {0,0,0,0,0,0,0,0,0,0};
float[][] readdata = new float[levels][musics]; 


int initial=1;
int menu1=0;
int menu2=0;
int menu3=0;
int menu4=0;
int measuring=0;
int training1=0;
int training2=0;
int training3=0;
int training4=0;
int training5=0;
int result1=0;
int result2=0;
int result3=0;
int result4=0;
int t=0;
float data;

int[] n=new int[musics];
int temp=0;
int selected=0;


void setup(){
  put1 = "";
  put2 = "";
  count1 = 0;
  count2 = 0;
  String[] stuff1 = loadStrings("text/data.txt");
  int check1 = 0;
  for (int i = 0; i < 5; i++){
    data2 = float(split(stuff1[i],','));
    if (data2.length < 2){
      check1 = 1;
    }
  }
  if (check1 == 1){
    for (int i = 0; i < 5; i++){
      results1[i] = "";
    }
  }
  else{
    for (int i = 0; i < 5; i++){
      data2 = float(split(stuff1[i],','));
      if (data2[0] == 1){
        for (int j = 1; j < data2.length; j++){
          if (j == 1){
            results1[i] = "";
          }
          results1[i] += str(data2[j]);
          if (j != data2.length - 1){
            results1[i] += ",";
          }
        }
        float[] a = new float[data2.length-1];
        for(int j=0; j<a.length; j++){
          a[j]=data2[j+1];
        }        
        count1 += 1;
        dataMax[i] = getTableMax(a);
        dataMin[i] = getTableMin(a);
      }
    }
  }
  
  String[] stuff2 = loadStrings("text/teacher.txt");
  int check2 = 0;
  for (int i = 0; i < 1000; i++){
    data3 = float(split(stuff2[i],","));
    if (data3.length < 3){
      check2 = 1;
    }
  }
  if (check2 == 1){
    for (int i = 0; i < 1000; i++){
      results2[i] = "";
    }
  }
  else{
    for (int i = 0; i < 1000; i++){
      data3 = float(split(stuff2[i],','));
      if (data3[0] > 0){
        for (int j = 0; j < data3.length; j++){
          if (j == 0){
            results2[i] = "";
          }
          results2[i] += str(data3[j]);
          if (j != data3.length - 1){
            results2[i] += ",";
          }
        }          
        count2 += 1;
      }
    }
  }
  
  size(1000, 600);
  
  plotX1 = 10; 
  plotX2 = width-10;
  labelX = 20;
  plotY1 = 30;
  plotY2 = height - 30;
  labelY = height - 30;
   
  plotFont = createFont("SansSerif", 20);
  textFont(plotFont);
 
  smooth();
  
  image(loadImage("image/photo_2.jpg"),0,0,1000,600);
  image(loadImage("image/photo_1.png"),200,50,600,100);
  frameRate(30);
  smooth();
  noFill();
  stroke(255,255,255);
  rect(width/2-200,170,400,40);
  rect(width/2-200,270,400,40);
  rect(width/2-200,370,400,40);
  rect(width/2-200,470,400,40);
  textSize(60);
  textAlign(CENTER);
  fill(255,255,255);
  textSize(40);
  text("measuring",width/2,200);
  text("random training",width/2,300);
  text("optimized training",width/2,400);
  text("select training",width/2,500);
  
  minim = new Minim(this);
  for(int i=0;i<musics;i++){
    player[i] = minim.loadFile("music/music"+i+"s.mp3");
    player1[i] = minim.loadFile("music/music"+i+".mp3");
    n[i]=i;
  }
}

void draw(){
  if(menu1==1){
  if(initial==1){
    image(loadImage("image/wtr0053-024.jpg"),0,0,1000,600);
    initial=0;
  }
  noFill();
  stroke(255,255,255);
  rect(width-150,height-40,100,20);
  rect(width/2-250,height/2,500,40);
  textSize(20);
  textAlign(CENTER);
  fill(255,255,255);
  text("return",width-100,height-20);
  textSize(60);
  text("start measuring",width/2,height/2+40);
  }
  if(menu2==1){
    if(initial==1){
      image(loadImage("image/wtr0053-024.jpg"),0,0,1000,600);
      initial=0;
    }
    noFill();
    stroke(255,255,255);
    rect(width-150,height-40,100,20);
    rect(width/2-250,height/2,500,40);
    textSize(20);
    textAlign(CENTER);
    fill(255,255,255);
    text("return",width-100,height-20);
    textSize(60);
    text("start training",width/2,height/2+40);
  }
  if(menu3==1){
    if(initial==1){
      image(loadImage("image/wtr0053-024.jpg"),0,0,1000,600);
      initial=0;
    }
    noFill();
    stroke(255,255,255);
    rect(width-150,height-40,100,20);
    rect(width/2-200,170,400,40);
    rect(width/2-200,270,400,40);
    rect(width/2-200,370,400,40);
    textSize(20);
    textAlign(CENTER);
    fill(255,255,255);
    text("return",width-100,height-20);
    textSize(40);
    text("5 minutes",width/2,200);
    text("10 minutes",width/2,300);
    text("20 minutes",width/2,400);
  }
  if(menu4==1){
    if(initial==1){
      image(loadImage("image/wtr0053-024.jpg"),0,0,1000,600);
      initial=0;
    }
    noFill();
    stroke(255,255,255);
    rect(width-150,height-40,100,20);
    rect(width/4-100,height/6-30,200,60);
    rect(width/4-100,height*2/6-30,200,60);
    rect(width/4-100,height*3/6-30,200,60);
    rect(width/4-100,height*4/6-30,200,60);
    rect(width/4-100,height*5/6-30,200,60);
    rect(width*3/4-100,height/6-30,200,60);
    rect(width*3/4-100,height*2/6-30,200,60);
    rect(width*3/4-100,height*3/6-30,200,60);
    rect(width*3/4-100,height*4/6-30,200,60);
    rect(width*3/4-100,height*5/6-30,200,60);
    textSize(20);
    textAlign(CENTER);
    fill(255,255,255);
    text("return",width-100,height-20);
    textSize(40);
    text("1",width/4,height/6);
    text("2",width/4,height*2/6);
    text("3",width/4,height*3/6);
    text("4",width/4,height*4/6);
    text("5",width/4,height*5/6);
    text("6",width*3/4,height/6);
    text("7",width*3/4,height*2/6);
    text("8",width*3/4,height*3/6);
    text("9",width*3/4,height*4/6);
    text("10",width*3/4,height*5/6);
  }
  if(measuring==1){
    if(initial==1){
      image(loadImage("image/eha0008-009.jpg"),0,0,1000,600);
      initial=0;
    }
    noFill();
    stroke(0,0,0);
    rect(width-150,height-40,100,20);
    textSize(20);
    textAlign(CENTER);
    fill(0,0,0);
    text("cancel",width-100,height-20);
    textSize(60);
    text("now measuring",width/2,height/2);
    
    output = createWriter("text/data.txt");
    textSize(40);
    if (t % 30 == 0){
      if (t == 30){
        put1 = str(data);
      }
      else{
        put1 = put1+","+str(data);
      }
      if (t != 0){
        datalist1[t/30-1] = data;
      }
    }
    if(t==300){
      measuring=0;
      result1=1;
      t=0;
    }
    t+=1;
  }
  if(training1==1){
    if(initial==1){
      image(loadImage("image/eha0008-009.jpg"),0,0,1000,600);
      initial=0;
    }
    noFill();
    stroke(255,255,255);
    rect(width-150,height-40,100,20);
    textSize(20);
    textAlign(CENTER);
    fill(255,255,255);
    text("cancel",width-100,height-20);
    textSize(60);
    text("now training",width/2,height/2);
    
    output = createWriter("text/teacher.txt");
    textSize(40);
    float start = 0;
    float end = 0;
    
    if(t==0){
      for(int i=0; i<musics; ++i) {
        temp = n[i];
        n[i] = n[int(random(musics))];
        n[int(random(musics))] = temp;
      }
      num = 0;
      put2 = str(n[num]+1);
      player[n[num]].rewind();
      player[n[num]].play();
    }
    
    if (t % 300 <= 30 && t % 300 != 0){
      start += data;
    }
    if (t % 300 == 30){
      start /= 30;
      put2 += "," + str(start);
    }
    if (t % 300 >= 270){
      end += data;
    }
    if (t % 30 == 0){
      if (t != 0){
        if (t % 300 == 0){
          datalist2[9] = data;
        }
        else{
          datalist2[(t%300)/30-1] = data;
        }
      }
    }
    if(t % 300 ==0 && t != 0){
      end /= 30;
      put2 += "," + str(end);
      if(start < -0.03){
        put2 += ",3";
      }
      else if(start < -0.02){
        put2 += ",2";
      }
      else if(start < -0.01){
        put2 += ",1";
      }
      else{
        put2 += ",0";
      }
      if(t==600){
        training1=0;
        result2=1;
        t=0;
        for(int i=0; i<musics;i++){
          player[i].pause();
        } 
      }
      else{
        num += 1;
        player[n[num]].rewind();
        player[n[num]].play();
        reserve2();
        output = createWriter("text/teacher.txt");
        put2 = str(n[num]+1);
      }
    }
    t+=1;
  }
  if(training2==1){
    if(initial==1){
      image(loadImage("image/eha0008-009.jpg"),0,0,1000,600);
      initial=0;
    }
    noFill();
    stroke(255,255,255);
    rect(width-150,height-40,100,20);
    textSize(20);
    textAlign(CENTER);
    fill(255,255,255);
    text("return",width-100,height-20);
    textSize(60);
    text("now training (5m)",width/2,height/2);
    
    output = createWriter("text/teacher.txt");
    textSize(40);
    float start = 0;
    float end = 0;
    
    if(t==0){
      optimized_play(0);
    }
    
    if (t % 300 <= 30 && t % 300 != 0){
      start += data;
    }
    if (t % 300 == 30){
      start /= 30;
      put2 += "," + str(start);
    }
    if (t % 300 >= 270){
      end += data;
    }
    if (t % 30 == 0){
      if (t != 0){
        if (t % 300 == 0){
          datalist2[9] = data;
        }
        else{
          datalist2[(t%300)/30-1] = data;
        }
      }
    }
    if(t % 300 ==0 && t != 0){
      int level;
      end /= 30;
      put2 += "," + str(end);
      if(start < -0.03){
        put2 += ",3";
        level = 3;
      }
      else if(start < -0.02){
        put2 += ",2";
        level = 2;
      }
      else if(start < -0.01){
        put2 += ",1";
        level = 1;
      }
      else{
        put2 += ",0";
        level = 0;
      }
      if(t==600){
        training2=0;
        result3=1;
        t=0;
        for(int i=0; i<musics;i++){
          player1[i].pause();
        } 
      }
      else{
        reserve2();
        output = createWriter("text/teacher.txt");
        optimized_play(level);
      }
    }
    t+=1;
  }
  if(training3==1){
    if(initial==1){
      image(loadImage("image/eha0008-009.jpg"),0,0,1000,600);
      initial=0;
    }
    noFill();
    stroke(255,255,255);
    rect(width-150,height-40,100,20);
    textSize(20);
    textAlign(CENTER);
    fill(255,255,255);
    text("cancel",width-100,height-20);
    textSize(60);
    text("now training (10m)",width/2,height/2);
    
    output = createWriter("text/teacher.txt");
    textSize(40);
    float start = 0;
    float end = 0;
    
    if(t==0){
      optimized_play(0);
    }
    
    if (t % 300 <= 30 && t % 300 != 0){
      start += data;
    }
    if (t % 300 == 30){
      start /= 30;
      put2 += "," + str(start);
    }
    if (t % 300 >= 270){
      end += data;
    }
    if (t % 30 == 0){
      if (t != 0){
        if (t % 300 == 0){
          datalist2[9] = data;
        }
        else{
          datalist2[(t%300)/30-1] = data;
        }
      }
    }
    if(t % 300 ==0 && t != 0){
      int level;
      end /= 30;
      put2 += "," + str(end);
      if(start < -0.03){
        put2 += ",3";
        level = 3;
      }
      else if(start < -0.02){
        put2 += ",2";
        level = 2;
      }
      else if(start < -0.01){
        put2 += ",1";
        level = 1;
      }
      else{
        put2 += ",0";
        level = 0;
      }
      if(t==600){
        training3=0;
        result3=1;
        t=0;
        for(int i=0; i<musics;i++){
          player1[i].pause();
        } 
      }
      else{
        reserve2();
        output = createWriter("text/teacher.txt");
        optimized_play(level);
      }
    }
    t+=1;
  }
  if(training4==1){
    if(initial==1){
      image(loadImage("image/eha0008-009.jpg"),0,0,1000,600);
      initial=0;
    }
    noFill();
    stroke(255,255,255);
    rect(width-150,height-40,100,20);
    textSize(20);
    textAlign(CENTER);
    fill(255,255,255);
    text("cancel",width-100,height-20);
    textSize(60);
    text("now training (20m)",width/2,height/2);
    
    output = createWriter("text/teacher.txt");
    textSize(40);
    float start = 0;
    float end = 0;
    
    if(t==0){
      optimized_play(0);
    }
    
    if (t % 300 <= 30 && t % 300 != 0){
      start += data;
    }
    if (t % 300 == 30){
      start /= 30;
      put2 += "," + str(start);
    }
    if (t % 300 >= 270){
      end += data;
    }
    if (t % 30 == 0){
      if (t != 0){
        if (t % 300 == 0){
          datalist2[9] = data;
        }
        else{
          datalist2[(t%300)/30-1] = data;
        }
      }
    }
    if(t % 300 ==0 && t != 0){
      int level;
      end /= 30;
      put2 += "," + str(end);
      if(start < -0.03){
        put2 += ",3";
        level = 3;
      }
      else if(start < -0.02){
        put2 += ",2";
        level = 2;
      }
      else if(start < -0.01){
        put2 += ",1";
        level = 1;
      }
      else{
        put2 += ",0";
        level = 0;
      }
      if(t==600){
        training4=0;
        result3=1;
        t=0;
        for(int i=0; i<musics;i++){
          player1[i].pause();
        } 
      }
      else{
        reserve2();
        output = createWriter("text/teacher.txt");
        optimized_play(level);
      }
    }
    t+=1;
  }
  if(training5==1){
    if(initial==1){
      image(loadImage("image/eha0008-009.jpg"),0,0,1000,600);
      initial=0;
    }
    noFill();
    stroke(255,255,255);
    rect(width-150,height-40,100,20);
    textSize(20);
    textAlign(CENTER);
    fill(255,255,255);
    text("cancel",width-100,height-20);
    textSize(60);
    text("now training",width/2,height/2);
    
    output = createWriter("text/teacher.txt");
    textSize(40);
    float start = 0;
    float end = 0;
    
    if(t==0){
      player1[selected].rewind();
      player1[selected].play();
    }
    
    if (t % 300 <= 30 && t % 300 != 0){
      start += data;
    }
    if (t % 300 == 30){
      start /= 30;
      put2 += "," + str(start);
    }
    if (t % 300 >= 270){
      end += data;
    }
    if (t % 30 == 0){
      if (t != 0){
        if (t % 300 == 0){
          datalist2[9] = data;
        }
        else{
          datalist2[(t%300)/30-1] = data;
        }
      }
    }
    if(t % 300 ==0 && t != 0){
      int level;
      end /= 30;
      put2 += "," + str(end);
      if(start < -0.03){
        put2 += ",3";
        level = 3;
      }
      else if(start < -0.02){
        put2 += ",2";
        level = 2;
      }
      else if(start < -0.01){
        put2 += ",1";
        level = 1;
      }
      else{
        put2 += ",0";
        level = 0;
      }
      if(t==600){
        training5=0;
        result4=1;
        t=0;
        for(int i=0; i<musics;i++){
          player1[i].pause();
        } 
      }
      else{
        reserve2();
        output = createWriter("text/teacher.txt");
      }
    }
    t+=1;
  }
  if(result1==1){
    background(BG_COLOR3);
    noFill();
    stroke(255,255,255);
    rect(width-150,height-40,100,20);
    fill(255,255,255);
    textAlign(CENTER);
    
    background(0);
    image(loadImage("image/photo_3.jpg"),0,0,1000,120);
    textSize(60);
    text("result",width/2,100);
    noFill();
    rect(width-150,height-40,100,20);
    textSize(20);
    text("return",width-100,height-20);
    dataMax[5] = getTableMax(datalist1);
    dataMin[5] = getTableMin(datalist1);
    drawYearLabels();
    noStroke();
    drawDataAlpha();
  
    reserve1();
  }
  if(result2==1){
    image(loadImage("image/photo_3.jpg"),0,0,1000,600);
    noFill();
    stroke(255,255,255);
    rect(width-150,height-40,100,20);
    textSize(20);
    textAlign(CENTER);
    fill(255,255,255);
    text("return",width-100,height-20);textAlign(CENTER);
    textSize(60);
    text("training finished",width/2,height/2);
    reserve2();
  }
  if(result3==1){
    image(loadImage("image/photo_3.jpg"),0,0,1000,600);
    noFill();
    stroke(255,255,255);
    rect(width-150,height-40,100,20);
    textSize(20);
    textAlign(CENTER);
    fill(255,255,255);
    text("return",width-100,height-20);
    textSize(60);
    text("training finished",width/2,height/2);
    reserve2();
  }
  if(result4==1){
    image(loadImage("image/photo_3.jpg"),0,0,1000,600);
    noFill();
    stroke(255,255,255);
    rect(width-150,height-40,100,20);
    textSize(20);
    textAlign(CENTER);
    fill(255,255,255);
    text("return",width-100,height-20);
    textSize(60);
    text("training finished",width/2,height/2);
    reserve2();
  }
}
void mousePressed(){
  initial=1;
  if(menu1==0 && menu2==0 && menu3==0 && menu4==0 && measuring==0 && training1==0 && training2==0 && training3==0 && training4==0 && training5==0 && result1==0 && result2==0 && result3==0 && result4==0){
    if(mouseX>=width/2-200 && mouseX<=width/2+200 && mouseY>=170 && mouseY<=210){
      menu1=1;
    }
    else if(mouseX>=width/2-200 && mouseX<=width/2+200 && mouseY>=270 && mouseY<=310){
      menu2=1;
    }
    else if(mouseX>=width/2-200 && mouseX<=width/2+200 && mouseY>=370 && mouseY<=410){
      menu3=1;
    }
    else if(mouseX>=width/2-200 && mouseX<=width/2+200 && mouseY>=470 && mouseY<=510){
      menu4=1;
    }
  }
  else if(mouseX>=width-150 && mouseX<=width-50 && mouseY>=height-40 && mouseY<=height-20){
    if(measuring==0 && training1==0 && training2==0 && training3==0 && training4==0 && training5==0){
      menu1=0;
      menu2=0;
      menu3=0;
      menu4=0;
      measuring=0;
      training1=0;
      training2=0;
      training3=0;
      training4=0;
      training5=0;
      result1=0;
      result2=0;
      result3=0;
      result4=0;
      setup();
    }
    else{
      measuring=0;
      training1=0;
      training2=0;
      training3=0;
      training4=0;
      training5=0;
      put1="";
      put2="";
      for(int i=0; i<num;i++){
        player[i].pause();
        player1[i].pause();
      } 
      if(measuring == 1){
        for (int i = 0; i < 5; i++){
          if (count1 > i){
            output.print("1,");
            output.println(results1[i % 5]);
          }
          else{
            output.println("0,0");
          }
        }
        output.flush();  // Writes the remaining data to the file
        output.close();
        setup();
      }
      else{
        for (int i = 0; i < 1000; i++){
          if (count2 > i){
            output.print("1,");
            output.println(results2[i % 1000]);
          }
          else{
            output.println("0,0,0");
          }
        }
        output.flush();  // Writes the remaining data to the file
        output.close();
        setup();
      }
    }
  }
  else if(menu1==1 && mouseX>=width/2-250 && mouseX<=width/2+250 && mouseY>=height/2 && mouseY<=height/2+40){
    menu1=0;
    measuring=1;
  }
  else if(menu2==1 && mouseX>=width/2-250 && mouseX<=width/2+250 && mouseY>=height/2 && mouseY<=height/2+40){
    menu2=0;
    training1=1;
  }
  else if(menu3==1 && mouseX>=width/2-200 && mouseX<=width/2+200 && mouseY>=170 && mouseY<=210){
    menu3=0;
    training2=1;
  }
  else if(menu3==1 && mouseX>=width/2-200 && mouseX<=width/2+200 && mouseY>=270 && mouseY<=310){
    menu3=0;
    training3=1;
  }
  else if(menu3==1 && mouseX>=width/2-200 && mouseX<=width/2+200 && mouseY>=370 && mouseY<=410){
    menu3=0;
    training4=1;
  }
  else if(menu4==1 && mouseX>=width/4-100 && mouseX<=width/4+100 && mouseY>=height/6-30 && mouseY<=height/6+30){
    menu4=0;
    training5=1;
    selected=0;
  }
  else if(menu4==1 && mouseX>=width/4-100 && mouseX<=width/4+100 && mouseY>=height*2/6-30 && mouseY<=height*2/6+30){
    menu4=0;
    training5=1;
    selected=1;
  }
  else if(menu4==1 && mouseX>=width/4-100 && mouseX<=width/4+100 && mouseY>=height*3/6-30 && mouseY<=height*3/6+30){
    menu4=0;
    training5=1;
    selected=2;
  }
  else if(menu4==1 && mouseX>=width/4-100 && mouseX<=width/4+100 && mouseY>=height*4/6-30 && mouseY<=height*4/6+30){
    menu4=0;
    training5=1;
    selected=3;
  }
  else if(menu4==1 && mouseX>=width/4-100 && mouseX<=width/4+100 && mouseY>=height*5/6-30 && mouseY<=height*5/6+30){
    menu4=0;
    training5=1;
    selected=4;
  }
  else if(menu4==1 && mouseX>=width*3/4-100 && mouseX<=width*3/4+100 && mouseY>=height/6-30 && mouseY<=height/6+30){
    menu4=0;
    training5=1;
    selected=5;
  }
  else if(menu4==1 && mouseX>=width*3/4-100 && mouseX<=width*3/4+100 && mouseY>=height*2/6-30 && mouseY<=height*2/6+30){
    menu4=0;
    training5=1;
    selected=6;
  }
  else if(menu4==1 && mouseX>=width*3/4-100 && mouseX<=width*3/4+100 && mouseY>=height*3/6-30 && mouseY<=height*3/6+30){
    menu4=0;
    training5=1;
    selected=7;
  }
  else if(menu4==1 && mouseX>=width*3/4-100 && mouseX<=width*3/4+100 && mouseY>=height*4/6-30 && mouseY<=height*4/6+30){
    menu4=0;
    training5=1;
    selected=8;
  }
  else if(menu4==1 && mouseX>=width*3/4-100 && mouseX<=width*3/4+100 && mouseY>=height*5/6-30 && mouseY<=height*5/6+30){
    menu4=0;
    training5=1;
    selected=9;
  }
}

void oscEvent(OscMessage msg){
  if(msg.checkAddrPattern("/muse/elements/alpha_relative")){
    for(int ch = 0; ch < N_CHANNELS; ch++){
      data = msg.get(ch).floatValue();
      data = -data*data*100;
    }
  }
}

void reserve1(){
  int check1 = 0;
  results1[count1 % 5] = put1;
  count1 += 1;
  if (count1 == 6){
    check1 = 1;
    count1 -= 1;
  }
  else{
    check1 = 0;
  }
  for (int i = 0; i < 5; i++){
    if (count1 > i){
      output.print("1,");
      output.println(results1[(check1 + i) % 5]);
    }
    else{
      output.println("0,0");
    }
  }
  output.flush();  // Writes the remaining data to the file
  output.close();
}

void reserve2(){
  int check2 = 0;
  results2[count2 % 1000] = put2;
  count2 += 1;
  if (count2 == 1001){
    check2 = 1;
    count2 -= 1;
  }
  else{
    check2 = 0;
  }
  for (int i = 0; i < 1000; i++){
    if (count2 > i){
      output.println(results2[(check2 + i) % 1000]);
    }
    else{
      output.println("0,0,0");
    }
  }
  output.flush();  // Writes the remaining data to the file
  output.close();
}

void readdata(){
  float[][] readsums = new float[levels][musics];
  float[][] readcounts = new float[levels][musics];
  float[] data4;
  for(int i = 0; i < results2.length; i++){
    if(results2[i] != null && results2[i] != ""){
      println(i);
      println(results2[i]);
      data4 = float(split(results2[i],","));
      if(data4[0] != 0){
        readsums[int(data4[3])][int(data4[0]-1)] += data4[2] - data4[1];
        readcounts[int(data4[3])][int(data4[0]-1)] += 1;
      }
    }
  }
  for(int i = 0; i < levels; i++){
    for(int j = 0; j < musics; j++){
      if(readcounts[i][j] > 0){
        readdata[i][j] = readsums[i][j] / readcounts[i][j];
      }
    }
  }
}

void stop() {
  player[0].close();
  minim.stop();
  super.stop();
}

void optimized_play(int p){
  readdata();
  int maxnum = 0;
  float max = 0;
  for(int i=0; i<musics; i++){
    if(check[i] == 0){
      if(-readdata[p][i] > max){
        maxnum = i;
        max = -readdata[p][i];
      }
    }
    check[maxnum] = 1;
    player1[maxnum].rewind();
    player1[maxnum].play();
    put2 = str(maxnum+1);
  }
}

void drawDataAlpha() {
  //int lr = latestRow(); 
  for(int i=1; i<datalist1.length; i++){
    float value = datalist1[i];
    float x = map(i, 0, 66, plotX1, plotX2);
    float y = 350;
    float a = map(-value, dataMin[5], dataMax[5], 100, 255);
    float w = (plotX2-plotX1)/66*1.1;
    fill(31,127,255, a);
    rect(x-w/2, y-(plotY2-plotY1-200)/2-50, w, plotY2-plotY1-200);
  }
  for(int i=0; i<results1.length; i++){
    float[] graphdata = float(split(results1[i],','));
    for(int j=1; j<graphdata.length; j++){
      float value = graphdata[j];
      float x = map(j+11*i+11, 0, 66, plotX1, plotX2);
      float y = 350;
      float a = map(-value, dataMin[i], dataMax[i], 100, 255);
      float w = (plotX2-plotX1)/66*1.1;
      fill(31,127,255, a);
      rect(x-w/2, y-(plotY2-plotY1-200)/2-50, w, plotY2-plotY1-200);
    }
  }
}

void drawYearLabels() {
  fill(255);
  textSize(10);
  textAlign(CENTER);
   
  stroke(224);
  textSize(20);
   
  for (int i=0; i< 60; i++) {
    if (i % 10 == 0) {
      float x = map(i, 0, 60, plotX1, plotX2);
      text(i/10+1, x+(plotX2-plotX1)/12, plotY2-50);
      text("Max = "+dataMax[5-i/10], x+(plotX2-plotX1)/12, plotY2 - 30);
    }
  }
}

float getTableMax(float[] a){
  float max = 0;
  if(a != null){
    for (int i=0; i<a.length;i++) {
      if(max < -a[i]){
        max = -a[i];
      }
    }
  }
  return max;
}

float getTableMin(float[] a){
  float min = 100; 
  if(a != null){
    for (int i=0; i<a.length;i++) {
      if(min > -a[i]){
        min = -a[i];
      }
    }
  }
  return min;
}

/*
int latestRow(){
  int latest=0;
  for(int i=0; i<data.length-1;i++){
    if(data[i+1][0] == 0){
      latest = i;
    }else if(data[data.length-1][0] == 1){
      latest = data.length-1;
    }
  }
  return latest;
}
*/
