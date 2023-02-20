import java.util.ArrayList;
import java.util.List;
import java.util.Iterator;
import ddf.minim.*;

boolean left, right, up, down, shift, z;

int scene_num = 0;
int stageCode = 0;

Stage stage;
Title title;
GameOver gameover;
Clear clear;

int totalScore = 0;

Minim minim;

void setup(){
  colorMode(HSB, 360, 100, 100, 100);
  size(720, 480);
  smooth();
  textSize(mojiSize);
  title = new Title();
  gameover = new GameOver();
  clear = new Clear();
  minim = new Minim(this);
}

void draw(){
  switch(scene_num){
    case STATUS_GAME_TITLE:
      title.updateMe();
      break;
    case STATUS_GAME_PLAYING:
      stage.updateMe();
      break;
    case STATUS_GAME_GAMEOVER:
      if(getStage().bgm_Stage.isPlaying()){getStage().bgm_Stage.pause();}
      gameover.updateMe();
      break;
    case STATUS_GAME_CLEAR:
      clear.updateMe();
      break;
  }
}

void scene_Title(){
}

void scene_GameOver(){
  background(0);
  textAlign(CENTER);
  textSize(64);
  text("Gameover", width / 2, height / 2 - 64);
  textSize(32);
  text("Press Z", width / 2, height / 2 - 32);
}

void gameReset(){
  totalScore = 0;
}

void scene_Game(){
  background(0);
  getStage().updateMe();
  
  stage_Seigyo();
}

void stage_Seigyo(){
  
}

void scene_Clear(){
  background(0);
  textAlign(CENTER);
  textSize(64);
  text("Stage Clear", width / 2, height / 2 - 64);
  textSize(32);
  text("Press Z", width / 2, height / 2 + 64);
}

Stage getStage(){
  return stage;
}

void keyPressed(){
  switch(scene_num){
    case STATUS_GAME_TITLE:
      title.keyInsert();
    break;
    case 1:
    if(keyCode == LEFT)left = true;
    if(keyCode == RIGHT) right = true;
    if(keyCode == UP) up = true;
    if(keyCode == DOWN) down = true;
    if(keyCode == SHIFT) shift = true;
    if(keyCode == 'Z') z = true;
    break;
    case 2:
      gameover.keyInsert();
    break;
    case 3:
      clear.keyInsert();
    break;
  }
  
}

void keyReleased(){
  if(keyCode == LEFT) left = false;
  if(keyCode == RIGHT) right = false;
  if(keyCode == UP) up = false;
  if(keyCode == DOWN) down = false;
  if(keyCode == SHIFT) shift = false;
  if(keyCode == 'Z') z = false;
}
