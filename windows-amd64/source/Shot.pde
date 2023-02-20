abstract class Dan {  //おーい、Enemyよりしたになって見づらいのやが
  PVector pos;
  PVector vel;
  PVector accel;
  float atari;  //判定サイズ
  float size;  //見かけサイズ(グレイズする範囲でもある)
  color col;  //色
  int count_dan = 0;  //生まれてからのカウント
  DanShape shape = DanShape.orb;
  float befx, befy;  //前の位置
  int lifetime;  //削除予定時刻
  boolean isActive = false;  //有効な弾かどうか

  Dan(float _x, float _y, float _speed, float _angle, float _size, color _col) {
    //state = "active";
    pos = new PVector(_x, _y);
    vel = createVectorFromLengthAngle(_speed, _angle);
    accel = new PVector(0, 0);
    size = _size;
    atari = size / 1.5;
    col = _col;
    isActive = true;
  }

  //おーーばーらいど、加速度と角速度つけられるやつ
  Dan(float _x, float _y, float _speed, float _accel, float _angle, float _rotate, float _size, color _col) {
    //state = "active";
    pos = new PVector(_x, _y);
    vel = createVectorFromLengthAngle(_speed, _angle);
    accel = createVectorFromLengthAngle(_accel, _rotate);
    size = _size;
    atari = size / 1.5;
    col = _col;
  }

  void drawMe() {
    
  }

  void updateMe() {
    vel.add(accel);
    pos.add(vel);

    isOutOfScreen();
    count_dan++;
    if((lifetime > 0 && count_dan > lifetime) || isOutOfScreen() == true){
      isActive = false;
    }
    
    drawMe();
  }
  
  //画面内にあるか（画面外にあるなら削除する）
  boolean isOutOfScreen(){
    if(pos.x > width + size || pos.x < 0 - size || pos.y > height + size || pos.y < 0 - size){
      return true;
    }
    return false;
  }
}

//敵弾クラス
class tekiDan extends Dan{
  boolean isGrazed = false;
  color icol;  //弾内側の色
  
  tekiDan(float _x, float _y, float _speed, float _angle, float _size, color _col) {
    super(_x,  _y, _speed, _angle, _size, _col);
    icol = color(0, 0, 100);
  }

  //おーーばーらいど、加速度と角速度つけられるやつ
  tekiDan(float _x, float _y, float _speed, float _accel, float _angle, float _rotate, float _size, color _col) {
    super(_x, _y, _speed, _accel, _angle, _rotate, _size, _col);
    icol = color(0, 0, 100);
  }
  
  void updateMe(){
    super.updateMe();
  }
  
  boolean isHitJiki(Jiki jiki){
    float d = dist(jiki.pos.x, jiki.pos.y, this.pos.x, this.pos.y);
    if(d <= jiki.atari + this.atari){
      return true;
    }else{
      return false;
    }
  }
  
  boolean isGrazeJiki(Jiki jiki){
    float d = dist(jiki.pos.x, jiki.pos.y, this.pos.x, this.pos.y);
    if(d <= jiki.graze + this.atari && this.isGrazed == false){
      return true;
    }else{
      return false;
    }
  }
}

class orbDan extends tekiDan{  //敵弾（丸型）
  orbDan(float _x, float _y, float _speed, float _angle, float _size, color _col) {
    super(_x,  _y, _speed, _angle, _size, _col);
  }

  //おーーばーらいど、加速度と角速度つけられるやつ
  orbDan(float _x, float _y, float _speed, float _accel, float _angle, float _rotate, float _size, color _col) {
    super(_x, _y, _speed, _accel, _angle, _rotate, _size, _col);
  }
  
  void drawMe(){
    fill(col);
    noStroke();
    ellipse(pos.x, pos.y, size, size);
    fill(icol);
    ellipse(pos.x, pos.y, atari, atari);
  }
}

class riceDan extends tekiDan{  //敵弾（楕円形）
  riceDan(float _x, float _y, float _speed, float _angle, float _size, color _col) {
    super(_x,  _y, _speed, _angle, _size, _col);
  }

  //おーーばーらいど、加速度と角速度つけられるやつ
  riceDan(float _x, float _y, float _speed, float _accel, float _angle, float _rotate, float _size, color _col) {
    super(_x, _y, _speed, _accel, _angle, _rotate, _size, _col);
  }
  
  void drawMe(){
    float angle = vel.heading();
    pushMatrix();
      translate(pos.x, pos.y);
      rotate(angle);
      fill(col);
      noStroke();
      ellipse(0, 0, size * 1.55, size);
      fill(icol);
      ellipse(0, 0, atari * 1.5, atari);
    popMatrix();
  }
}

class triDan extends tekiDan{  //敵弾（三角形）
  triDan(float _x, float _y, float _speed, float _angle, float _size, color _col) {
    super(_x,  _y, _speed, _angle, _size, _col);
  }

  //おーーばーらいど、加速度と角速度つけられるやつ
  triDan(float _x, float _y, float _speed, float _accel, float _angle, float _rotate, float _size, color _col) {
    super(_x, _y, _speed, _accel, _angle, _rotate, _size, _col);
  }
  
  void drawMe(){
    float angle = vel.heading();
    fill(col);
    noStroke();
    triangle(pos.x + cos(angle) * size / 2, pos.y + sin(angle) * size / 2,
      pos.x + cos(angle + radians(120)) * size / 2, pos.y + sin(angle + radians(120)) * size / 2,
      pos.x + cos(angle - radians(120)) * size / 2, pos.y + sin(angle - radians(120)) * size / 2);
    fill(icol);
    triangle(pos.x + cos(angle) * atari / 2, pos.y + sin(angle) * atari / 2,
      pos.x + cos(angle + radians(120)) * atari / 2, pos.y + sin(angle + radians(120)) * atari / 2,
      pos.x + cos(angle - radians(120)) * atari / 2, pos.y + sin(angle - radians(120)) * atari / 2);
  }
}

class starDan extends tekiDan{  //敵弾（星形弾）
  starDan(float _x, float _y, float _speed, float _angle, float _size, color _col) {
    super(_x,  _y, _speed, _angle, _size, _col);
  }

  //おーーばーらいど、加速度と角速度つけられるやつ
  starDan(float _x, float _y, float _speed, float _accel, float _angle, float _rotate, float _size, color _col) {
    super(_x, _y, _speed, _accel, _angle, _rotate, _size, _col);
  }
  
  void drawMe(){
    fill(col);
    noStroke();
    drawStar(pos.x, pos.y, size, radians(count_dan * 2));
    noFill();
    strokeWeight(0.5);
    stroke(icol);
    drawStar(pos.x, pos.y, atari, radians(count_dan * 2));
    fill(icol);
    noStroke();
    ellipse(pos.x, pos.y, atari, atari);
  }
}

class growDan extends tekiDan{  //光弾（見づらいすぎ、キレそう）
  int step = 6;  //光のぼかし鮮明さ
  
  growDan(float _x, float _y, float _speed, float _angle, float _size, color _col) {
    super(_x,  _y, _speed, _angle, _size, _col);
  }

  //おーーばーらいど、加速度と角速度つけられるやつ
  growDan(float _x, float _y, float _speed, float _accel, float _angle, float _rotate, float _size, color _col) {
    super(_x, _y, _speed, _accel, _angle, _rotate, _size, _col);
  }
  
  void drawMe(){
    for(int i = 0; i < step; i++){
      float s = atari + (size * 2 - atari) / step * i;
      //println(s);
      color c = color(hue(col), saturation(col), brightness(col), alpha(col) / step);
      //println(c);
      noStroke();
      fill(c);
      ellipse(pos.x, pos.y, s, s);
    }
    fill(icol);
    stroke(col);
    strokeWeight(3);
    ellipse(pos.x, pos.y, atari, atari);
  }
}

class henyoriDan extends tekiDan{  //敵弾（へにょりレーザー）
  PVector bef = new PVector(0, 0);
  
  henyoriDan(float _x, float _y, float _speed, float _angle, float _size, color _col) {
    super(_x,  _y, _speed, _angle, _size, _col);
  }

  //おーーばーらいど、加速度と角速度つけられるやつ
  henyoriDan(float _x, float _y, float _speed, float _accel, float _angle, float _rotate, float _size, color _col) {
    super(_x, _y, _speed, _accel, _angle, _rotate, _size, _col);
  }
  
  void drawMe(){
    println("shot rendering");
    fill(col);
    noStroke();
    ellipse(pos.x, pos.y, size, size);
    fill(icol);
    ellipse(pos.x, pos.y, atari, atari);
    if (count_dan != 0)createhenyo();
  }

  void createhenyo() {
    HenyoriTail henyo =  new HenyoriTail(pos.x, pos.y, bef.x, bef.y, size, col);
    henyo.lifetime = 15;
    Stage s = getStage();
    s.particles.add(henyo);
    bef = pos;
  }
}
