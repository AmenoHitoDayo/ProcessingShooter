class Clear{
  
  Clear(){
    
  }
  
  void updateMe(){
    drawMe();
  }
  
  void drawMe(){
    fill(360);
    background(0);
    textAlign(CENTER);
    textSize(64);
    text("GameClear", width / 2, height / 2);
    textSize(32);
    text("Score:" + totalScore, width / 2, height / 2 + 64 + 32);
  }
  
  void keyInsert(){
    if(keyCode == 'Z'){
      gameReset();
      scene_num = STATUS_GAME_TITLE;
    }
  }
}
