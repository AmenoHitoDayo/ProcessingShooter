enum PertType{
  normal,
  henyori
}

enum DanState{
  normal,
  homing,  //敵を追尾(つつーか自動照準)する
  fire  //時間経過で小さくなって消える
};

enum JikiState{  //KORAIL空港鉄道
  normal,
  dead  //被弾後無敵時間さんを作るならいるんじゃないかとおもj
}

enum JikiWeapon{
  none,  //普通の直進弾
  homing,  //追尾弾
  splead,  //広がる弾
  penetrate,  //貫通弾・・・なんだけど同じ敵に複数あたっちゃう問題が解決できないので封印中
  fire  //炎弾、近距離高火力
}

enum EnemyType{
  none,
  zako_dummy,
  zako_aim01,
  zako_circle01,
  zako_vortex01,
  midboss_baramaki01,
  zako_uchikaeshi01,
  zako_march01,
  zako_laser01,
  zako_henyo01,
  boss_01,
  bit_01
}

enum ItemType{  //アイテム実装すんの？
  LifePlus,
  BombPlus,
  Point,
  splead,
  homing,
  fire
}

enum DanShape{  //ショット形状・・・そこまで実装してる余裕があるのか
  orb,  //普通に丸
  rice,  //楕円形　短い半径部分がサイズと思う
  tri,  //三角　メタ的にいうと敵と同じ形だから面倒そう
  davidstar,  //星形　三角を2つ重ねれば六芒星はできる思う
  henyori  //へにょりれーざー（仮）　通った後に軌跡をおく特殊処理がいるよね
}
