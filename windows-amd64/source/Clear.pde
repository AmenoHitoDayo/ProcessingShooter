class Clear{
  
  Clear(){
    
  }
  
  void updateMe(){
    drawMe();
  }
  
  void drawMe(){
    background(0);
  }
  
  void keyInsert(){
    if(keyCode == 'Z'){
      gameReset();
      scene_num = STATUS_GAME_TITLE;
    }
  }
}
