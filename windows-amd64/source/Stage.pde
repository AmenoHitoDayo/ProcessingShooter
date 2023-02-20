//stageクラス
class Stage{
  protected int stageNum;
  List<Enemy> enemys;
  List<Item> items;
  List<Particle> particles;
  Jiki jiki;
  boolean isCounting;
  int scoreRate = 0;
  int count = 0;
  AudioPlayer bgm_Stage;
  AudioPlayer SE_ScoreItem;
  AudioPlayer SE_LifeUP;
  
  Stage(Jiki j){
    jiki = j;
    stageNum = 0;
    enemys = new ArrayList<Enemy>();
    particles = new ArrayList<Particle>();
    items = new ArrayList<Item>();
    isCounting = true;
    //実行中のステージを通知
    stageCode = stageNum;
    SE_ScoreItem = minim.loadFile("魔王魂 効果音 ジッポ-開ける音.mp3");
    SE_LifeUP = minim.loadFile("魔王魂  マジカル15.mp3");
  }
  
  void updateMe(){
    if(!bgm_Stage.isPlaying()){bgm_Stage.loop();}
    if(isCounting == true){
      count++;
    }
    
    executeBG();
    
    Iterator<Particle> itP = particles.iterator();
    while(itP.hasNext()){
      Particle p = itP.next();
      executeParticle(p);
      if(p.isActive == false){
        println("particle removed");
        itP.remove();
      }
    }
    Iterator<Item> itI = items.iterator();
    while(itI.hasNext()){
      Item i = itI.next();
      executeItem(i);
      if(i.isActive == false){
        switch(i.type){
          case TYPE_ITEM_POINT:
            SE_ScoreItem.play(0);
            totalScore += 10 + scoreRate * ((int)jiki.grazeCount / 10 + 1);
            println(totalScore);
          break;
          case TYPE_ITEM_LIFE:
              if(!SE_LifeUP.isPlaying())SE_LifeUP.play(0);
            if(jiki.HP < 10){
              jiki.HP++;
              println("HPUP");
            }else{
              totalScore += 10000;
            }
          break;
          case TYPE_ITEM_BOMB:
            if(jiki.Bomb < 10){
              jiki.Bomb++;
            }else{
              totalScore += 10000;
            }
          break;
        }
        itI.remove();
      }
    }
    
    executeJiki();
    
    Iterator<Enemy> itE = enemys.iterator();
    while(itE.hasNext()){
      Enemy e = itE.next();
      executeEnemy(e);
      
      //敵が無効化済みかつ、敵機に所属する弾がなくなったら、敵機を削除
      if(e.status == STATUS_ENEMY_DISACTIVE && e.bullets.size() == 0){
        itE.remove();
        //println("enemyRemoved!");
      }
    }
    
    if(enemys.size() == 0 && isCounting == false){
      isCounting = true;
      count++;
    }
    executeUI();
  }
  
  //敵を実行
  void executeEnemy(Enemy e){
    e.updateMe(jiki);
  }
  
  //自機を実行
  void executeJiki(){
    jiki.updateMe();
    
    //自機弾を動かす
    Iterator<jikiDan> itS = jiki.shots.iterator();
    while(itS.hasNext()){
      jikiDan s = itS.next();
      judgeEnemysToJikidanCollision(s);
      if(!s.isActive){
        itS.remove();
      }
    }
    
    if(jiki.HP <= 0){
      scene_num = STATUS_GAME_GAMEOVER;
    }
  }
  
  void executeItem(Item i){
    i.updateMe();
    /* 自機の位置が特定の位置より大きければ自動回収モードにする */
    if(i.suiyoseToJiki(jiki) == true || jiki.pos.y < height / 4){
      i.isAutoKaishu = true;
    }
    if(i.isAutoKaishu == true){
      i.attract(jiki);
    }
    if(i.corrisionToJiki(jiki) == true){
      i.isActive = false;
    }
  }
  
  void executeParticle(Particle p){
    p.updateMe();
  }
  
  //UIを描画する
  void executeUI(){
     
    noStroke();
    fill(180, 50, 50, 50);
    rect(0, 0, width / 2 - Play_Haba / 2, height);
    rect(width / 2 + Play_Haba / 2, 0, width, height);
    
    fill(255);
    text("Score:" + totalScore, 0, UI_Height);
    text("Rate:" + scoreRate, 0, UI_Height + mojiSize);
    text("Graze:" + jiki.grazeCount, 0, UI_Height + mojiSize * 2);
    text("LIFE:" + jiki.HP, width / 2 + Play_Haba / 2, UI_Height);
    text("Bomb:" + jiki.Bomb, width / 2 + Play_Haba / 2, UI_Height + mojiSize);
  }
  
  //背景を描画する
  void executeBG(){
    background(0);
  }
  
  void endStage(){
    bgm_Stage.pause();
    enemys.clear();
  }
  
  //弾が敵と当たっているか調べる・・・これ重くない？大丈夫？
  void judgeEnemysToJikidanCollision(jikiDan s){
    Iterator<Enemy> itE = enemys.iterator();
    while(itE.hasNext()){
      Enemy e = itE.next();
      if(s.isHitEnemy(e) && e.status == STATUS_ENEMY_ACTIVE && e.isInvincible == false){
        s.HP--;
        if(!s.isOutOfScreen()){
          for(int i = 0; i < 3; i++){
            popParticle p = new popParticle(s.pos.x, s.pos.y, 5, random(TWO_PI), s.atari, s.col);
            particles.add(p);
          }
        }
        e.HPDown(s.damage);
        scoreRate += e.rate;
      }
    }
  }
  
  List<Enemy> getEnemyArray(){
    return enemys;
  }
  /* ステージ末尾の敵のステータスが削除済になったらステージ終了 */
}

class stage_1 extends Stage{
  PImage BG;
  stage_1(Jiki j){
    super(j);
    count = 0;
    stageNum = 1;
    bgm_Stage = minim.loadFile("ghost.mp3");
    bgm_Stage.setVolume(50);
    BG = loadImage("patter.png");
  }
  
  void updateMe(){
    super.updateMe();
    if(count <= 300){
      if(count % 60 == 0){
        enemys.add(new zako_march01(width / 2 + 50, 0));
        enemys.add(new zako_march01(width / 2 + 70, 0));
      }
    }
    if(count > 150 && count <= 150 + 300){
      if(count % 60 == 0){
        enemys.add(new zako_march01(width / 2  - 50, 0));
        enemys.add(new zako_march01(width / 2  - 70, 0));
      }
    }
    if(count > 360 && count <= 360 + 300){
      if(count % 60 == 0){
        enemys.add(new zako_aim01(random(width / 2 - Play_Haba / 2, width / 2 + Play_Haba / 2), 0));
      }
    }
    if(count > 600 && count < 900){
      if(count % 60 == 0){
        enemys.add(new zako_vortex01(random(width / 2 - Play_Haba / 2, width / 2 + Play_Haba / 2), 0));
      }
    }
    if(count > 960 && count < 1200){
      if(count % 60 == 0){
        enemys.add(new zako_uchikaeshi01(random(width / 2 - Play_Haba / 2, width / 2), 0));
        enemys.add(new zako_uchikaeshi01(random(width / 2 + Play_Haba / 2, width / 2), 0));
      }
    }
    if(count == 1260 && isCounting == true){
      isCounting = false;
      enemys.add(new midboss_baramaki(width / 2, 0));
    }
    if(count > 1260 && count < 1260 + 60 * 5){
      if(count % 60 == 0){
        enemys.add(new zako_laser01(random(width / 2 - Play_Haba / 2, width / 2 + Play_Haba / 2), 0));
      }
    }
    if(count > 1760 && count < 1760 + 60 * 5){
      if(count % 60 == 0){
        enemys.add(new zako_allrange02(random(width / 2 - Play_Haba / 2, width / 2 + Play_Haba / 2), 0));
      }
    }
    if(count > 2160 && count < 2400){
      if(count % 60 == 0){
        enemys.add(new zako_allrange01(random(width / 2 - Play_Haba / 2, width / 2 + Play_Haba / 2), 0));
      }
    }
    if(count > 2400 && enemys.size() == 0 && items.size() == 0){
      endStage();
    }
  }
  
  void executeBG(){
    super.executeBG();
    push();
      tint(100);
      image(BG, 0, frameCount % height);
      image(BG, 0, frameCount % height - height);
    pop();
  }
  
  void endStage(){
    super.endStage();
    scene_num = STATUS_GAME_CLEAR;
  }
}

class stage1_Boss extends Stage{
  stage1_Boss(Jiki j){
    super(j);
    count = 0;
    stageNum = 2;
  }
}
