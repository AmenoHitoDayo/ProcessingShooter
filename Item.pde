class Item{
  PVector pos;
  PVector vel;
  float speed;
  int type;
  color col;
  float atari;
  float suiyose_hani;  //吸い寄せ範囲に入ると自動回収なる
  boolean isAutoKaishu;  //回収ラインより上にいくと自動で回収されるようになる
  boolean isActive = false;
  
  Item(float _x, float _y,  int _type){
    pos = new PVector(_x, _y);
    speed = 1.25;
    vel = new PVector(0, speed);
    type = _type;
    atari = 10;
    suiyose_hani = 60;
    isAutoKaishu = false;
    switch(type){
      case TYPE_ITEM_POINT:
        col = color(240, 50, 100, 50);
      break;
      case TYPE_ITEM_LIFE:
        col = color(330, 50, 100, 50);
      break;
      case TYPE_ITEM_BOMB:
        col = color(150, 50, 100, 50);
      break;
    }
    isActive = true;
  }
  
  void drawMe(){
    noStroke();
    fill(col);
    quad(pos.x + cos(radians(0)) * atari, pos.y + sin(radians(0)) * atari,
         pos.x + cos(radians(90)) * atari, pos.y + sin(radians(90)) * atari,
         pos.x + cos(radians(180)) * atari, pos.y + sin(radians(180)) * atari,
         pos.x + cos(radians(270)) * atari, pos.y + sin(radians(270)) * atari);
  }
  
  void updateMe(){
    pos.add(vel);
    //corrisionToItem(this);
    if(isOutOfScreen()){isActive = false;}
    drawMe();
  }
  
  void attract(Jiki jiki){
    float angle = atan2(jiki.pos.y - this.pos.y, jiki.pos.x - this.pos.x);
    vel.x = 10 * cos(angle);
    vel.y = 10 * sin(angle);
  }

  boolean corrisionToJiki(Jiki jiki){
    float d = dist(jiki.pos.x, jiki.pos.y, pos.x, pos.y);
    boolean ans = false;
    if(d <= jiki.atari + atari){
      ans = true;
    }
    return ans;
  }
  
  boolean suiyoseToJiki(Jiki jiki){
    float d = dist(jiki.pos.x, jiki.pos.y, pos.x, pos.y);
    boolean ans = false;
    if(d <= jiki.atari + suiyose_hani){
      ans = true;
    }
    return ans;
  }
  
  boolean isOutOfScreen(){
    if(pos.x > width + atari || pos.x < 0 - atari || pos.y > height + atari || pos.y < 0 - atari){
      return true;
    }
    return false;
  }
}
