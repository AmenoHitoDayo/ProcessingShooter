//ダミー雑魚(ランダム10way円弾)　これをコピペして敵情報をつくってね
class zako_dummy extends Enemy{
  zako_dummy(float _x, float _y){
    super(_x, _y);
  }
  
  void drawMe(){
    super.drawMe();
  }
  
  void updateMe(Jiki jiki){
    super.updateMe(jiki);
  }
  
  void enemy_Move(){
      pos.y += 1;
  }
  
  void enemy_Shot(Jiki jiki){
    if(count_enemy % 60 == 0){
      int kodo = int(random(36));
      for(int i = 0; i < 10; i++){
        orbDan d = new orbDan(pos.x, pos.y, 1.5, radians(kodo), 16, color(60, 100, 100));
        bullets.add(d);
        kodo += 36;
      }
    }
  }
  
}

class zako_march01 extends Enemy{
    zako_march01(float _x, float _y){
    super(_x, _y);
    HP = 5;
  }
  
  void drawMe(){
    super.drawMe();
  }
  
  void updateMe(Jiki jiki){
    super.updateMe(jiki);
  }
  
  void enemy_Move(){
    pos.y += 1.5;
  }
  
  void enemy_Shot(Jiki jiki){
  }
}

class zako_aim01 extends Enemy{
  zako_aim01(float _x, float _y){
    super(_x, _y);
  }
  
  void drawMe(){
    super.drawMe();
  }
  
  void updateMe(Jiki jiki){
    super.updateMe(jiki);
  }
  
  void enemy_Move(){
    if(count_enemy < 60){
      pos.y += 1;
    }else if(count_enemy >= 60 && count_enemy < 90){
      /* なんもせん */
    }
    else{
      pos.y -= 1;
    }
  }
  
  void enemy_Shot(Jiki jiki){
    if(count_enemy >= 60 && count_enemy < 90){
      if(count_enemy % 10 == 0){
        float angle = atan2(jiki.pos.y - this.pos.y, jiki.pos.x - this.pos.x);
        orbDan d1 = new orbDan(pos.x, pos.y, 1.5, angle - radians(30), 15, color(90, 100, 90));
        orbDan d2 = new orbDan(pos.x, pos.y, 1.5, angle, 15, color(90, 100, 90));
        orbDan d3 = new orbDan(pos.x, pos.y, 1.5, angle + radians(30), 15, color(90, 100, 90));
        bullets.add(d1);
        bullets.add(d2);
        bullets.add(d3);
      }
    }
  }
}

class zako_vortex01 extends Enemy{
  float angle = 0;
  
  zako_vortex01(float _x, float _y){
    super(_x, _y);
  }
  
  void drawMe(){
    super.drawMe();
  }
  
  void updateMe(Jiki jiki){
    super.updateMe(jiki);
  }
  
  void enemy_Move(){
    if(count_enemy < 60){
      pos.y += 1;
    }
    if(count_enemy > 90){
      if(pos.x > width / 2){
        pos.x += 1;
      }else{
        pos.x -= 1;
      }
    }
  }
  
  void enemy_Shot(Jiki jiki){
    if(count_enemy == 60){
      angle = random(0, 360);
    }
    
    if(count_enemy > 60){
      if(count_enemy % 5 == 0){
        riceDan d1 = new riceDan(pos.x, pos.y, 2, angle, 7.5, color(200, 50, 100));
        riceDan d2 = new riceDan(pos.x, pos.y, 1.75, angle, 7.5, color(220, 50, 100));
        riceDan d3 = new riceDan(pos.x, pos.y, 1.5, angle, 7.5, color(240, 50, 100));
        bullets.add(d1);
        bullets.add(d2);
        bullets.add(d3);
        
        angle += radians(360 / 16);
      }
    }
  }
}

class zako_uchikaeshi01 extends Enemy{
  float speed = 2.5;
  PVector def;
  zako_uchikaeshi01(float _x, float _y){
    super(_x, _y);
    def = pos;
    col = color(300, 100, 100);
  }
  
  void drawMe(){
    super.drawMe();
  }
  
  void updateMe(Jiki jiki){
    super.updateMe(jiki);
  }
  
  void enemy_Move(){
    if(count_enemy < 90){
      pos.y += speed;
    }else{
      pos.y += speed;
      if(def.x > width / 2){
        pos.x -= speed;
      }else{
        pos.x += speed;
      }
    }
  }
  
  void enemy_Shot(Jiki jiki){
  }
  
  void HPDown(int damage){
    super.HPDown(damage);
    if(count_enemy % 3 == 0){
      float angle = random(0, TWO_PI);
      for(int i = 0; i < 3; i++){
        triDan d = new triDan(pos.x, pos.y, 3, angle, 20, color(300, 100, 100));
        bullets.add(d);
        angle += TWO_PI / 3;
      }
    }
  }
}

class zako_laser01 extends Enemy{
  float angle = 0;
  zako_laser01(float _x, float _y){
    super(_x, _y);
  }
  
  void drawMe(){
    super.drawMe();
  }
  
  void updateMe(Jiki jiki){
    super.updateMe(jiki);
  }
  
  void enemy_Move(){
    if(count_enemy < 60){
      pos.y += 1.5;
    }
    if(count_enemy > 90){
      if(pos.x > width / 2){
        pos.x += 1.5;
      }else{
        pos.x -= 1.5;
      }
    }
  }
  
  void enemy_Shot(Jiki jiki){
    if(count_enemy == 60){
      angle = random(0, 360);
    }
    if(count_enemy > 60){
      if(count_enemy % 5 == 0){
        Laser l = new Laser(pos.x, pos.y, 2, angle, 10, 100, color(15, 60, 100));
        bullets.add(l);
        angle += radians(360 / 16);
      }
    }
  }
}

class zako_allrange01 extends Enemy{
  int way = 12;
  
  zako_allrange01(float _x, float _y){
    super(_x, _y);
    HP = 30;
  }
  
  void drawMe(){
    super.drawMe();
  }
  
  void updateMe(Jiki jiki){
    super.updateMe(jiki);
  }
  
  void enemy_Move(){
    if(count_enemy < 60){
      pos.y += 1.5;
    }
    if(count_enemy > 90){
      if(pos.x > width / 2){
        pos.x += 1.5;
      }else{
        pos.x -= 1.5;
      }
    }
  }
  
  void enemy_Shot(Jiki jiki){
    if(count_enemy == 75){
      for(int i = 0; i < way; i++){
        color c = lerpColor(color(0, 70, 70), color(359, 30, 70), 1.0 / way * i);
        float angle = TWO_PI / way * i;
        growDan d = new growDan(pos.x, pos.y, 2.5, angle, 28, c);
        d.blend = ADD;
        bullets.add(d);
      }
    }
  }
}

class zako_allrange02 extends Enemy{
  int way = 20;
  
  zako_allrange02(float _x, float _y){
    super(_x, _y);
  }
  
  void drawMe(){
    super.drawMe();
  }
  
  void updateMe(Jiki jiki){
    super.updateMe(jiki);
  }
  
  void enemy_Move(){
    
    if(count_enemy < 60){
      pos.y += 1.5;
    }
    if(count_enemy > 90){
      pos.y -= 1;
    }
  }
  
  void enemy_Shot(Jiki jiki){
    if(count_enemy > 60 && count_enemy < 120){
      if(count_enemy % 15 == 0){
        float angle = random(TWO_PI);
        for(int i = 0; i < way; i++){
          angle += TWO_PI / way;
          triDan d = new triDan(pos.x, pos.y, 2.5, angle, 20, color(170, 100, 100));
          bullets.add(d);
        }
      }
    }
  }
}

class zako_trail01 extends Enemy{
  float angle;
  zako_trail01(float _x, float _y){
    super(_x, _y);
    lifetime = 180;
    angle = radians(90);
  }
  
  void drawMe(){
    super.drawMe();
  }
  
  void updateMe(Jiki jiki){
    super.updateMe(jiki);
  }
  
  void enemy_Move(){
    if(count_enemy <= 30){
      pos.y += 2;
    }
  }
  
  void enemy_Shot(Jiki jiki){
    if(count_enemy == 60){
      tekiDan d1 = new henyoriDan(pos.x, pos.y, 3, angle, 8, color(210, 100, 100));
      d1.rotate = radians(0.5);
      tekiDan d2 = new henyoriDan(pos.x, pos.y, 3, angle, 8, color(210, 100, 100));
      d2.rotate = radians(-0.5);
      bullets.add(d1);
      bullets.add(d2);
    }
    
    if(count_enemy > 60 && count_enemy % 30 == 0){
      tekiDan d1 = new henyoriDan(pos.x, pos.y, 3, angle + radians(20) * ((count_enemy - 60) / 30), 8, color(210, 100, 100));
      d1.rotate = radians(0.5);
      tekiDan d2 = new henyoriDan(pos.x, pos.y, 3, angle + radians(20) * ((count_enemy - 60) / 30), 8, color(210, 100, 100));
      d2.rotate = radians(-0.5);
      bullets.add(d1);
      bullets.add(d2);
      
      tekiDan d3 = new henyoriDan(pos.x, pos.y, 3, angle - radians(20) * ((count_enemy - 60) / 30), 8, color(210, 100, 100));
      d3.rotate = radians(0.5);
      tekiDan d4 = new henyoriDan(pos.x, pos.y, 3, angle - radians(20) * ((count_enemy - 60) / 30), 8, color(210, 100, 100));
      d4.rotate = radians(-0.5);
      bullets.add(d3);
      bullets.add(d4);
    }
    
  }
}


/* ここから中ボス系 */
class midboss_baramaki extends Enemy{
  float angle = 0;
  midboss_baramaki(float _x, float _y){
    super(_x, _y);
    this.HP = 500;
    this.size = 30;
    lifetime = 500;
    dropItem.add(new Item(0, 0, TYPE_ITEM_LIFE));
    isInvincible = true;  //登場時は無敵にする
  }
  
  void drawMe(){
    super.drawMe();
  }
  
  void updateMe(Jiki jiki){
    super.updateMe(jiki);
  }
  
  void enemy_Move(){
    if(count_enemy < 90){
      pos.y += 1.5;
    }else if(count_enemy == 90){
      isInvincible = false;
    }
  }
  
  void enemy_Shot(Jiki jiki){
    if(count_enemy > 90){
      if(count_enemy % 10 == 0){
        angle = atan2(jiki.pos.y - this.pos.y, jiki.pos.x - this.pos.x);
        for(int i = 0; i < 6; i++){
          starDan d = new starDan(pos.x, pos.y, 2, angle + radians(random(-60, 60)), 16, color(random(0, 360), 25, 100, 75));
          bullets.add(d);
          angle += radians(60);
        }
      }
      if((HP < 100 || count_enemy > 400) && count_enemy % 16 == 0){
        angle = atan2(jiki.pos.y - this.pos.y, jiki.pos.x - this.pos.x);
        for(int i = 0; i <= 16; i++){
          growDan d = new growDan(pos.x, pos.y, 3, angle, 16, color(0, 100, 100));
          d.blend = ADD;
          bullets.add(d);
          angle += TWO_PI / 16;
        }
      }
    }
  }
  
  void shootdown(){
    super.shootdown();
  }
}

class midboss_geometric extends Enemy{
  float angle = 0;
  float angle2 = 0;
  midboss_geometric(float _x, float _y){
    super(_x, _y);
    this.HP = 500;
    this.size = 30;
    lifetime = 500;
    dropItem.add(new Item(0, 0, TYPE_ITEM_LIFE));
    isInvincible = true;  //登場時は無敵にする
  }
  
  void drawMe(){
    super.drawMe();
  }
  
  void updateMe(Jiki jiki){
    super.updateMe(jiki);
  }
  
  void enemy_Move(){
    if(count_enemy < 90){
      pos.y += 1.5;
    }else if(count_enemy == 90){
      isInvincible = false;
    }
  }
  
  void enemy_Shot(Jiki jiki){
    if(count_enemy > 90 && count_enemy % 60 == 0){
      int way = 10;
      int kado = 6;//何角形にするか
      float a = angle;
      for(int i = 0; i < kado; i++){
        makeLineShot(1, a, 360 / kado / 2, way, color(240, 50, 100));
        a += TWO_PI / kado;
      }
      angle += radians(10);
    }
  }
  
  void makeLineShot(float baseSpeed, float baseAngle, float maxGap, int way, color c){
    float gapPlus = maxGap / way;
    float maxSpd = baseSpeed / cos(maxGap);
    for(float i = 0; i < maxGap /2; i += gapPlus){
      tekiDan d1 = new orbDan(pos.x, pos.y, baseSpeed / cos(i), baseAngle + i, 12, c);
      tekiDan d2 = new orbDan(pos.x, pos.y, baseSpeed / cos(i), baseAngle - i, 12, c);
      bullets.add(d1);
      bullets.add(d2);
    }
  }
  
  void shootdown(){
    super.shootdown();
  }
}

/* ここからボス系 */
class boss_01 extends Enemy{
  boss_01(float _x, float _y){
    super(_x, _y);
    size = 36;
  }
  
  void drawMe(){
    super.drawMe();
  }
  
  void updateMe(Jiki jiki){
    super.updateMe(jiki);
  }
  
  void enemy_Move(){
      pos.y += 1;
  }
  
  void enemy_Shot(Jiki jiki){
    
  }
}
