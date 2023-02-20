class standard extends Jiki{
  standard(){
    super();
    col = color(180, 100, 100);
  }
  
  void jiki_Shot(){
    if(count_jiki % 5 == 0){
      if(shift){
        for(int i = -10; i <= 10; i += 5){
          standardShot s = new standardShot(pos.x, pos.y + 4, radians(i - 90));
          shots.add(s);
        }
      }else{
        for(int i = -20; i <= 20; i += 10){
          standardShot s = new standardShot(pos.x, pos.y + 4, radians(i - 90));
          shots.add(s);
        }
      }
    }
  }
}

class standardShot extends jikiDan{
  standardShot(float _x, float _y, float _angle){
    super(_x, _y, 7, _angle, 8, color(180, 100, 100, 50), 1);
  }
  
  void drawMe(){
    pushMatrix();
      translate(pos.x, pos.y);
      rotate(vel.heading());
      noStroke();
      fill(col);
      ellipse(0, 0, size, atari);
    popMatrix();
  }
}

class lay extends Jiki{
  lay(){
    super();
    col = color(155, 100, 100);
  }
  
  void jiki_Shot(){
    if(count_jiki % 12 == 0){
      for(int i = -32; i <= 32; i += 16){
        layShot s1 = new layShot(pos.x + i, pos.y + 4, radians(-90));
        shots.add(s1);
      }
    }
  }
}

class layShot extends jikiDan{
  PVector bpos;
  layShot(float _x, float _y, float _angle){
    super(_x, _y, 12, _angle, 8, color(155, 100, 100, 50), 4);
    accel = createVectorFromLengthAngle(0.5, _angle);
    bpos = pos;
    HP = 10;
  }
  
  void drawMe(){
    //fill(360);
    //ellipse(pos.x, pos.y, size, size);
    HenyoriTail henyo = new HenyoriTail(pos.x, pos.y, bpos.x, bpos.y, size, col);
    henyo.lifetime = 5;
    Stage s = getStage();
    s.particles.add(henyo);
    bpos = new PVector(pos.x, pos.y);
  }
}

class homing extends Jiki{
  homing(){
    super();
    col = color(100, 100, 100);
  }
  
  void jiki_Shot(){
    if(count_jiki % 10 == 0){
      homingShot s1 = new homingShot(pos.x - 8, pos.y - 4);
      homingShot s2 = new homingShot(pos.x + 8, pos.y - 4);
      shots.add(s1);
      shots.add(s2);
    }
    if(count_jiki % 5 == 0){
      for(int i = -10; i <= 10; i += 10){
        standardShot s = new standardShot(pos.x + i, pos.y - 4, radians(-90));
        s.damage = 1;
        s.col = color(75, 100, 100, 25);
        shots.add(s);
      }
    }
  }
}

class homingShot extends jikiDan{
  Enemy targetEnemy;
  homingShot(float _x, float _y){
    super(_x, _y, 5, radians(-90), 16, color(140, 100, 100, 50), 1);
    targetEnemy = getTarget();
  }
  
  //追跡対象を設定（弾の追跡対象は途中で変わらない）
  Enemy getTarget(){
    Enemy nearByEnemy = null;
    float kyori = 1000;
    Stage s = getStage();
    if(s != null){
      List es = s.getEnemyArray();
      Iterator<Enemy> it = es.iterator();
      while(it.hasNext()){
        Enemy e = it.next();
        if(e.status == STATUS_ENEMY_ACTIVE){
          float kyoriNow = dist(pos.x, pos.y, e.pos.x, e.pos.y);
          if (kyoriNow <= kyori) {
            kyori = kyoriNow;
            nearByEnemy = e;
          }
        }
      }
    }
    return nearByEnemy;
  }
  
  void updateMe(){
    super.updateMe();
    homing();
  }

  void homing() {  //最初にホーミング弾の対象を決めて、上書きされないようにしたい
    if (targetEnemy != null && targetEnemy.status == STATUS_ENEMY_ACTIVE) {
      PVector vecToEnem = PVector.sub(targetEnemy.pos, pos).normalize();
      this.vel = vecToEnem.mult(5);
    }
  }
}

class fire extends Jiki{
  fire(){
    super();
    col = color(330, 100, 100);
  }
  
  void jiki_Shot(){
    fireShot s = new fireShot(pos.x, pos.y - 16);
    shots.add(s);
  }
}

class fireShot extends jikiDan{
  fireShot(float x, float y){
    super(x, y, 10 + random(-3, 3), radians(random(-15, 15) - 90), 50, color(330, 100, 100, 30), 7);
  }
  
  void drawMe(){
    fill(col);
    noStroke();
    ellipse(pos.x, pos.y, atari, atari);
    atari -= 1.5;
    if(atari <= 0){
      isActive = false;
    }
  }
}
