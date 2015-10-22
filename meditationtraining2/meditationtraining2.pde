import oscP5.*;
import netP5.*;
final int N_CHANNELS = 4;

final color BG_COLOR1 = color(0, 0, 0);
final color BG_COLOR2 = color(255,255,255);
final color BG_COLOR3 = color(127,127,127);
final color BG_COLOR4 = color(0,127,127);
final color BG_COLOR5 = color(127,127,0);

final int PORT = 5001;
OscP5 oscP5 = new OscP5(this, PORT);

PrintWriter output;
float[] data2;
String[] result = {"","","","",""};
int count = 0;
String put = "";

int menu1=0;
int menu2=0;
int menu3=0;
int menu4=0;
int measuring=0;
int training1=0;
int training2=0;
int training3=0;
int training4=0;
int result1=0;
int result2=0;
int result3=0;
int t=0;
float data;
//float alpha;


void setup(){
  String[] stuff = loadStrings("data.txt");
  int check = 0;
  for (int i = 0; i < 5; i++){
    data2 = float(split(stuff[i],','));
    if (data2.length < 2){
      check = 1;
    }
  }
  if (check == 1){
    for (int i = 0; i < 5; i++){
      result[i] = "";
    }
  }
  else{
    for (int i = 0; i < 5; i++){
      data2 = float(split(stuff[i],','));
      if (data2[0] == 1){
        for (int j = 1; j < data2.length; j++){
          result[i] += str(data2[j]);
          if (j != data2.length - 1){
            result[i] += ",";
          }
        }          
        count += 1;
      }
    }
  }
  output = createWriter("data.txt");
  
  size(1000, 600);
  background(BG_COLOR2);
  frameRate(30);
  smooth();
  noFill();
  stroke(0,0,0);
  rect(width/2-200,170,400,40);
  rect(width/2-200,270,400,40);
  rect(width/2-200,370,400,40);
  rect(width/2-200,470,400,40);
  textSize(60);
  textAlign(CENTER);
  fill(0,0,0);
  text("meditation training",width/2,100);
  textSize(40);
  text("measuring",width/2,200);
  text("random training",width/2,300);
  text("optimized training",width/2,400);
  text("select training",width/2,500);
}

void draw(){
  if(menu1==1){
  background(BG_COLOR1);
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
    background(BG_COLOR3);
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
    background(BG_COLOR4);
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
    background(BG_COLOR4);
    noFill();
    stroke(255,255,255);
    rect(width-150,height-40,100,20);
    textSize(20);
    textAlign(CENTER);
    fill(255,255,255);
    text("return",width-100,height-20);
  }
    if(measuring==1){
    background(BG_COLOR4);
    noFill();
    stroke(255,255,255);
    rect(width-150,height-40,100,20);
    textSize(20);
    textAlign(CENTER);
    fill(255,255,255);
    text("return",width-100,height-20);
    textSize(60);
    text("now measuring",width/2,height/2);
    textSize(40);
    if (t % 30 == 0){
      text(data,width/2,height*3/4);
      if (t == 30){
        put = str(data);
      }
      else{
        put = put+","+str(data);
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
    background(BG_COLOR4);
    noFill();
    stroke(255,255,255);
    rect(width-150,height-40,100,20);
    textSize(20);
    textAlign(CENTER);
    fill(255,255,255);
    text("return",width-100,height-20);
    textSize(60);
    text("now training",width/2,height/2);
    if(t==300){
      training1=0;
      result2=1;
      t=0;
    }
    t+=1;
  }
  if(training2==1){
    background(BG_COLOR4);
    noFill();
    stroke(255,255,255);
    rect(width-150,height-40,100,20);
    textSize(20);
    textAlign(CENTER);
    fill(255,255,255);
    text("return",width-100,height-20);
    textSize(60);
    text("now training (5m)",width/2,height/2);
    if(t==300){
      training2=0;
      result3=1;
      t=0;
    }
    t+=1;
  }
  if(training3==1){
    background(BG_COLOR4);
    noFill();
    stroke(255,255,255);
    rect(width-150,height-40,100,20);
    textSize(20);
    textAlign(CENTER);
    fill(255,255,255);
    text("return",width-100,height-20);
    textSize(60);
    text("now training (10m)",width/2,height/2);
    if(t==300){
      training3=0;
      result3=1;
      t=0;
    }
    t+=1;
  }
  if(training4==1){
    background(BG_COLOR4);
    noFill();
    stroke(255,255,255);
    rect(width-150,height-40,100,20);
    textSize(20);
    textAlign(CENTER);
    fill(255,255,255);
    text("return",width-100,height-20);
    textSize(60);
    text("now training (20m)",width/2,height/2);
    if(t==300){
      training4=0;
      result3=1;
      t=0;
    }
    t+=1;
  }
  if(result1==1){
    background(BG_COLOR3);
    noFill();
    stroke(255,255,255);
    rect(width-150,height-40,100,20);
    textSize(20);
    textAlign(CENTER);
    fill(255,255,255);
    text("return",width-100,height-20);
    reserve();
  }
  if(result2==1){
    background(BG_COLOR3);
    noFill();
    stroke(255,255,255);
    rect(width-150,height-40,100,20);
    textSize(20);
    textAlign(CENTER);
    fill(255,255,255);
    text("return",width-100,height-20);
  }
  if(result3==1){
    background(BG_COLOR3);
    noFill();
    stroke(255,255,255);
    rect(width-150,height-40,100,20);
    textSize(20);
    textAlign(CENTER);
    fill(255,255,255);
    text("return",width-100,height-20);
  }
}



void mousePressed(){
  if(menu1==0 && menu2==0 && menu3==0 && menu4==0 && measuring==0 && training1==0 && training2==0 && training3==0 && training4==0 && result1==0 && result2==0 &&result3==0){
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
    menu1=0;
    menu2=0;
    menu3=0;
    menu4=0;
    measuring=0;
    training1=0;
    training2=0;
    training3=0;
    training4=0;
    result1=0;
    result2=0;
    result3=0;
    setup();
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
}

void oscEvent(OscMessage msg){
  if(msg.checkAddrPattern("/muse/elements/alpha_relative")){
    if(measuring==1){
      for(int ch = 0; ch < N_CHANNELS; ch++){
      data = msg.get(ch).floatValue();
      //data = (data - (MAX_MICROVOLTS / 2)) / (MAX_MICROVOLTS / 2); // -1.0 1.0
      data = -data*data*100;
      }
    }
      println("回ってます");
  }
}

void reserve(){
  int check = 0;
  result[count % 5] = put;
  count += 1;
  if (count == 6){
    check = 1;
    count -= 1;
  }
  else{
    check = 0;
  }
  for (int i = 0; i < 5; i++){
    if (count > i){
      output.print("1,");
      output.println(result[(check + i) % 5]);
    }
    else{
      output.println("0,0");
    }
  }
  output.flush();  // Writes the remaining data to the file
  output.close();
}







