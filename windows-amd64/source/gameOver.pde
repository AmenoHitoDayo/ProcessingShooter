class GameOver{
  GameOver(){
    
  }
  
  void updateMe(){
    drawMe();
  }
  
  void drawMe(){
    background(0);
    text("Gameover", 0, UI_Height - mojiSize);
    text("Score:" + totalScore, 0, UI_Height);
  }
  
  void keyInsert(){
    if(keyCode == 'Z'){
      gameReset();
      scene_num = STATUS_GAME_TITLE;
    }
  }
}
