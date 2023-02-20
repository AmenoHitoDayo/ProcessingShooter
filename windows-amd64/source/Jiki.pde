class Jiki{
  //String state;
  PVector pos;
  int HP;
  int Bomb;
  float speed;
  int size;
  float atari;
  color col;
  int count_jiki;
  float graze;
  int muteki_frame;
  List<jikiDan> shots;
  JikiWeapon weapon;
  int grazeCount;
  AudioPlayer SE_Graze;
  AudioPlayer SE_Gekitsui;
  
  Jiki(){
    //state = "active";
    pos = new PVector(width / 2, height / 2);
    HP = 10;
    Bomb = 3;
    speed = 2.5;
    size = 15;
    col = color(180, 100, 100);
    count_jiki = 0;
    atari = size / 4;
    graze = size;
    weapon = JikiWeapon.none;
    grazeCount = 0;
    shots = new ArrayList<jikiDan>();
    SE_Graze = minim.loadFile("魔王魂 効果音 システム26.mp3");
    SE_Gekitsui = minim.loadFile("魔王魂 効果音 システム09.mp3");
  }
  
  void HPDown(){  //HPを減らす処理をするときはこれをやろうね
    SE_Gekitsui.play(0);
    HP--;
    muteki(20);
  }
  
  void muteki(int frame){  //指定フレームだけ時期を無敵にする
    muteki_frame = count_jiki + frame;
  }
  
  void drawMe(){
    noStroke();
    if(shift == true){  //低速ときに判定見えるようにするやつ
      fill(col);
      ellipse(pos.x, pos.y, atari * 2, atari * 2);
      fill(col, 50);
    }else{
      fill(col);
    }
    triangle(pos.x + cos(radians(30)) * size, pos.y + sin(radians(30)) * size,
    pos.x + cos(radians(150)) * size, pos.y + sin(radians(150)) * size,
    pos.x + cos(radians(270)) * size, pos.y + sin(radians(270)) * size);
  }
  
  void updateMe(){
    jiki_Move();
    if(z == true){
      jiki_Shot();
    }
    updateBullets();
    
    count_jiki++;
    drawMe();
  }
  
  //自機操作用
  void jiki_Move(){
    float movespeed = speed;
    
    if(shift == true) movespeed *= 0.5;
    
    if((up == true || down == true) && (left == true || right == true)){
      movespeed *= 0.71;
    }
    
    if(right == true){
      pos.x += movespeed;
      if(pos.x > (width / 2 + Play_Haba / 2) - size) pos.x = (width / 2 + Play_Haba / 2) - size;
    }
    if(left == true){
      pos.x -= movespeed;
      if(pos.x < (width / 2 - Play_Haba / 2) + size) pos.x = (width / 2 - Play_Haba / 2) + size;
    }
    if(up == true){
      pos.y -= movespeed;
      if(pos.y < size) pos.y = size;
    }
    if(down == true){
      pos.y += movespeed;
      if(pos.y > height - size) pos.y = height - size;
    }
  }
  
  void jiki_Shot(){
  
  }
  
  void shootDown(){
    
  }
  
  //自機ショット更新
  void updateBullets(){
    Iterator<jikiDan> it = shots.iterator();
    while(it.hasNext()){
      jikiDan d = it.next();
      if(d.isActive){
        d.updateMe();
      }else{
        it.remove();
      }
    }
  }
  
  void executeGraze(tekiDan d){
    SE_Graze.play(0);
    Stage s = getStage();
    for(int i = 0; i < 3; i++){  //グレイズエフェクト：対レーザーだと変なところにエフェクト出るからなんかしたほうがいいかもしれん。
      PVector v = PVector.mult(PVector.sub(d.pos, pos).normalize(), size);
      popParticle p = new popParticle(pos.x + v.x, pos.y + v.y, 1, random(TWO_PI), d.size / 2, d.col);
      s.particles.add(p);
    }
    grazeCount++;
  }
  
  //無敵時間さん！？かどうか
  boolean isInvincible(){
    if(muteki_frame > count_jiki){
      return true;
    }else{
      return false;
    }
  }
}

class jikiDan extends Dan {
  int HP;  //貫通力、この回数だけ敵に当たれる、貫通ショットを作りたければここ増やせばいい
  int damage;  //敵に与えるダメージ
  Enemy targetEnemy = null;

  jikiDan(float _x, float _y, float _speed, float _angle, int _size, color _col, int _damage) {
    super(_x, _y, _speed, _angle, _size, _col);
    HP = 1;
    atari = _size;
    damage = _damage;
  }

  void drawMe() {
    fill(col);
    noStroke();
    ellipse(pos.x, pos.y, atari, atari);
  }

  void updateMe() {
    super.updateMe();
    if(HP <= 0){isActive = false;}
    drawMe();
  }
  
  boolean isHitEnemy(Enemy e){
    float d = dist(e.pos.x, e.pos.y, this.pos.x, this.pos.y);
    if(d < e.atari + this.atari){
      return true;
    }else{
      return false;
    }
  }
}
