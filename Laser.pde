class Laser extends tekiDan{  //れーざー:線当たり判定にする(太さは、並べて作るとかでできるか？)
  PVector base;  //ケツの位置
  PVector def;
  float len;  //長さ
  //sizeを太さとして扱う。

  Laser(float _x, float _y, float _speed, float _angle, float _wid, float _len, color _col) {
    //state = "active";
    super(_x,  _y, _speed, _angle, _wid, _col);
    base = new PVector(pos.x, pos.y);
    def = new PVector(pos.x, pos.y);  //posを直接参照してしまうとposの値が描き変わったときにdefの値も書き変わってしまうらしいです。
    atari = size / 2;
    len = _len;
    col = _col;
    icol = color(0, 0, 100);
  }

  void drawMe() {
    strokeWeight(size);
    stroke(col);
    line(base.x, base.y, pos.x, pos.y);
    strokeWeight(atari);
    stroke(icol);
    line(base.x, base.y, pos.x, pos.y);
    noStroke();
    fill(col);
    ellipse(base.x, base.y, size * 2, size * 2);
    /*fill(col);
     quad(axD, ayD, bxD, byD, cxD, cyD, dxD, dyD);
     fill(icol);
     quad(ax, ay, bx, by, cx, cy, dx, dy);*/
    noStroke();
  }

  void updateMe() {
    super.updateMe();
    
    base = PVector.sub(pos, PVector.mult(vel.normalize(null), len));  //normalize 引数nullにしないとvelが上書きされる。
    
    
    if(vel.x > 0){
      if(base.x < def.x){
        base.x = def.x;
      }
    }else if(vel.x < 0){
      if(base.x > def.x){
        base.x = def.x;
      }
    }
    if(vel.y > 0){
      if(base.y < def.y){
        base.y = def.y;
      }
    }else if(vel.y < 0){
      if(base.y > def.y){
        base.y = def.y;
      }
    }
    
    
  }
  
  boolean isOutOfScreen(){
    if (base.x > width || base.x < 0 || base.y > height || base.y < 0) {
      return true;
    }
    return false;
  }
  
  //直線と円の当たり判定をatari * 2（左右分）本束ねて判定
  //
  boolean isHitJiki(Jiki jiki){
    if(lineCollisionToJiki(jiki, jiki.atari, pos.x, pos.y, base.x, base.y)){return true;}
    
    for(int i = 1; i <= atari; i++){
      PVector posMinusI = new PVector(pos.x + i * cos(vel.heading()), pos.y + i * sin(vel.heading()));
      PVector posPlusI = new PVector(pos.x + i * cos(vel.heading() + PI), pos.y + i * sin(vel.heading() + PI));
      PVector baseMinusI = new PVector(base.x + i * cos(vel.heading()), base.y + i * sin(vel.heading()));
      PVector basePlusI = new PVector(base.x + i * cos(vel.heading() + PI), base.y + i * sin(vel.heading() + PI));
      
      if(lineCollisionToJiki(jiki, jiki.atari, posMinusI.x, posMinusI.y, baseMinusI.x, baseMinusI.y)){return true;}
      if(lineCollisionToJiki(jiki, jiki.atari, posPlusI.x, posPlusI.y, basePlusI.x, basePlusI.y)){return true;}
    }
    
    return false;
  }
  
  boolean isGrazeJiki(Jiki jiki){
    if(lineCollisionToJiki(jiki, jiki.atari, pos.x, pos.y, base.x, base.y)){return true;}
    
    for(int i = 1; i <= atari / 2; i++){
      PVector posMinusI = new PVector(pos.x + i * cos(vel.heading()), pos.y + i * sin(vel.heading()));
      PVector posPlusI = new PVector(pos.x + i * cos(vel.heading() + PI), pos.y + i * sin(vel.heading() + PI));
      PVector baseMinusI = new PVector(base.x + i * cos(vel.heading()), base.y + i * sin(vel.heading()));
      PVector basePlusI = new PVector(base.x + i * cos(vel.heading() + PI), base.y + i * sin(vel.heading() + PI));
      
      if(lineCollisionToJiki(jiki, jiki.graze, posMinusI.x, posMinusI.y, baseMinusI.x, baseMinusI.y)){return true;}
      if(lineCollisionToJiki(jiki, jiki.graze, posPlusI.x, posPlusI.y, basePlusI.x, basePlusI.y)){return true;}
    }
    
    return false;
  }
  
  boolean lineCollisionToJiki(Jiki jiki, float _atari, float headX, float headY, float rootX, float rootY){
    PVector head = new PVector(headX, headY);
    PVector root = new PVector(rootX, rootY);
    
    PVector lineVec = PVector.sub(root, head); //線分のベクトル
    PVector headToAtari = PVector.sub(jiki.pos, head);  //自機の中心から線分の頭まで
    PVector rootToAtari = PVector.sub(jiki.pos, root);  //自機の中心から線分のケツまで
    
    PVector lineNorm = lineVec.normalize();
    PVector cross01 = lineNorm.cross(headToAtari);  //線分に向かって中心からおろしたベクター
    
    //内積と円の半径を比較
    if(cross01.mag() < _atari){
      //当たっているかもしれない
      float d1 = lineVec.dot(headToAtari);
      float d2 = lineVec.dot(rootToAtari);
      
      //2つの内積の掛け算の結果が0より小さいなら当たっている？
      if(d1 * d2 <= 0){
        return true;
      }else{
        //このとき、当たり判定の中心は線分上にない。
        //が、範囲が頭かケツにかすっている可能性があるので、それを見る
        if(dist(jiki.pos.x, jiki.pos.y, head.x, head.y) <= _atari || dist(jiki.pos.x, jiki.pos.y, root.x, root.y) <= _atari){
          return true;
        }
      }
    }else{
      //当たってない
      return false;
    }
    return false;
  }
}
