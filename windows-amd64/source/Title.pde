class Title{
  String weaponName = "none";
  int jikiSelectStatus = 0;
  
  Title(){
    
  }
  
  void updateMe(){
    drawMe();
  }
  
  void drawMe(){
    switch(jikiSelectStatus){
      case JIKISELECT_STANDARD:
        weaponName = "standard";
      break;
      case JIKISELECT_RAY:
        weaponName = "ray";
      break;
      case JIKISELECT_HOMING:
        weaponName = "homing";
      break;
      case JIKISELECT_FIRE:
        weaponName = "fire";
      break;
    }
    
    background(0);
    textAlign(CENTER);
    textSize(64);
    text("STGtest", width / 2, height / 2 - 64);
    textSize(32);
    text("Press any key", width / 2, height / 2 - 32);
    text("Weapon", width / 2, height / 2 + 64);
    text(weaponName, width / 2, height / 2 + 96);
  }
  
  void keyInsert(){
      if(keyCode == LEFT){
        switch(jikiSelectStatus){
          case JIKISELECT_STANDARD:
            jikiSelectStatus = JIKISELECT_RAY;
            break;
          case JIKISELECT_RAY:
            jikiSelectStatus = JIKISELECT_HOMING;
            break;
          case JIKISELECT_HOMING:
            jikiSelectStatus = JIKISELECT_FIRE;
            break;
          case JIKISELECT_FIRE:
            jikiSelectStatus = JIKISELECT_STANDARD;
            break;
        }
      }else if(keyCode == RIGHT){
        switch(jikiSelectStatus){
          case JIKISELECT_STANDARD:
            jikiSelectStatus = JIKISELECT_FIRE;
            break;
          case JIKISELECT_RAY:
            jikiSelectStatus = JIKISELECT_STANDARD;
            break;
          case JIKISELECT_HOMING:
            jikiSelectStatus = JIKISELECT_RAY;
            break;
          case JIKISELECT_FIRE:
            jikiSelectStatus = JIKISELECT_HOMING;
            break;
        }
      }else if(keyCode == 'Z'){
        Jiki jiki = new Jiki();
        switch(jikiSelectStatus){
          case JIKISELECT_STANDARD:
            jiki = new standard();
            break;
          case JIKISELECT_RAY:
            jiki = new lay();
            break;
          case JIKISELECT_HOMING:
            jiki = new homing();
            break;
          case JIKISELECT_FIRE:
            jiki = new fire();
            break;
        }
        stage = new stage_1(jiki);
        textAlign(LEFT);
        textSize(mojiSize);
        scene_num = 1;
    }
  }
}
