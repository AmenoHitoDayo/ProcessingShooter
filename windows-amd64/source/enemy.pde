//メモ　ショット情報は一元管理ではなく敵機体ごとにする
abstract class Enemy{
  //String state;
  PVector pos;  //位置
  int HP;  //体力
  int size;  //見かけのサイズ
  float atari;  //当たり判定の大きさ
  color col;  //機体の色
  int count_enemy;  //スポーンしてから何F経過したか
  int status;
  int rate = 5;  //倒した際に加算されるスコアレート
  int lifeTime = 0;  //寿命（制限時間） count_enemyがこの値を超えたら削除(撃ち落されモード移行)
  boolean isInvincible;  //無敵かどうか
  List<tekiDan> bullets = new ArrayList<tekiDan>();
  List<Item> dropItem = new ArrayList<Item>();
  
  AudioPlayer SE_Gekitsui;
  AudioPlayer SE_Hit;
  
  Enemy(float _x, float _y){
    pos = new PVector(_x, _y);
    status = STATUS_ENEMY_ACTIVE;
    count_enemy = 0;
    col = color(0, 100, 100);
    size = 15;
    HP = 20;
    atari = size;
    isInvincible = false;
    for(int i = 0; i < 3; i++){
      dropItem.add(new Item(0, 0, TYPE_ITEM_POINT));
    }
    SE_Gekitsui = minim.loadFile("魔王魂  戦闘18.mp3");
    SE_Hit = minim.loadFile("魔王魂  戦闘07.mp3");
  }
  
  void drawMe(){
    //ボスはisActive = false のときも描画が続くようにして、HP0時の処理で次弾幕開始の位置まで移動する
    if(status == STATUS_ENEMY_ACTIVE){
      fill(col);
      noStroke();
      triangle(pos.x + cos(radians(90)) * size, pos.y + sin(radians(90)) * size,
      pos.x + cos(radians(210)) * size, pos.y + sin(radians(210)) * size,
      pos.x + cos(radians(330)) * size, pos.y + sin(radians(330)) * size);
    }
  }
  
  void updateMe(Jiki jiki){
    if(status == STATUS_ENEMY_ACTIVE){
      enemy_Move();
      enemy_Shot(jiki);
      if(isOutOfScreen() == true){
        status = STATUS_ENEMY_DISACTIVE;
      }
      if(lifeTime > 0 && count_enemy > lifeTime){  //寿命を過ぎたら死
        status = STATUS_ENEMY_SHOOTDOWN;
      }
    }else if(status == STATUS_ENEMY_SHOOTDOWN){
      shootdown();
    }

    updateBullets(jiki);
    drawMe();
    count_enemy++;
  }
  
  abstract void enemy_Move();
  
  abstract void enemy_Shot(Jiki jiki);
  
  void updateBullets(Jiki jiki){
    
    Iterator<tekiDan> it = bullets.iterator();
    while(it.hasNext()){
      tekiDan d = it.next();
      d.updateMe();
      if(jiki.isInvincible() == false){
        if(d.isGrazeJiki(jiki) && d.isGrazed == false){
          println("graze!");
          jiki.executeGraze(d);
          d.isGrazed = true;
        }
        if(d.isHitJiki(jiki) && d.isActive == true){
          println("hit!");
          jiki.HPDown();
          Stage s = getStage();
          expandCircle p = new expandCircle(d.pos.x, d.pos.y, d.size * 4, d.col);
          s.particles.add(p);
          d.isActive = false;
        }
      }
      if(d.isActive == false){
        it.remove();
      }
    }
  }
  
  //撃ち落された時の挙動
  void shootdown(){
    SE_Gekitsui.play();
    Stage s = getStage();
    expandCircle p = new expandCircle(pos.x, pos.y, size * 4, color(360, 50));
    s.particles.add(p);
    for(Item i: dropItem){
      i.pos = new PVector(pos.x + random(-size * 2, size * 2), pos.y + random(-size * 2, size * 2));
      s.items.add(i);
    }
    status = STATUS_ENEMY_DISACTIVE;
  }
  
  void HPDown(int damage){
    HP -= damage;
    if(!SE_Hit.isPlaying())SE_Hit.play(0);
    if(HP <= 0){
     /* ここに撃破エフェクト処理？ */
        status = STATUS_ENEMY_SHOOTDOWN;
    }
  }
  
  void killAllShot(){
    Iterator<tekiDan> it = bullets.iterator();
    while(it.hasNext()){
      tekiDan d = it.next();
      d.isActive = false;
    }
  }
  
  boolean isOutOfScreen(){
    //画面外から出てくる奴がいるわけだから、画面範囲は広めに持ったほうがいいのかも？
    if(pos.x > width + size || pos.x < -size || pos.y > height + size || pos.y < -size){
      return true;
    }
    return false;
  }
  
  List getDropItems(){
    for(Item i: dropItem){
      i.pos = new PVector(pos.x + random(-size * 2, size * 2), pos.y + random(-size * 2, size * 2));
    }
    return dropItem;
  }
}
