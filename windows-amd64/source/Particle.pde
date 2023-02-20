class Particle{
  PVector pos;
  PVector vel = new PVector(0, 0);
  float alpha = 255;
  float size = 10;
  color c;
  int count = 0;
  int lifetime;
  boolean isActive = false;
  PertType type;
  
  Particle(float _x, float _y, color _c){
    pos = new PVector(_x, _y);
    vel = new PVector(0, 0);
    c = _c;
    isActive = true;
  }
  
  void drawMe(){
    fill(c, alpha);
    noStroke();
    ellipse(pos.x, pos.y, size, size);
  }
  
  void updateMe(){
    pos.add(vel);
    count++;
    if(count > lifetime){
      isActive = false;
    }
    drawMe();
  }
  
}

class HenyoriTail extends Particle{
  PVector pos2;
  PertType type;
  color d_col;
  
  HenyoriTail(float _x1, float _y1, float _x2, float _y2, float _size, color _col){
    super(_x1, _y1, color(0, 0, 100));
    pos2 = new PVector(_x2, _y2);
    size = _size;
    d_col = _col;
  }
  
  void drawMe(){
    stroke(c, alpha);
    strokeWeight(size);
    line(pos.x, pos.y, pos2.x, pos2.y);
    noStroke();
  }
  
  void updateMe(){
    float s_plus = (saturation(d_col)) / lifetime;
    float v_plus = (100 - brightness(d_col)) / lifetime;
    if(alpha > 0){
      c = color(hue(d_col), saturation(c) + s_plus, brightness(c) - v_plus);
      alpha -= 255 / lifetime;
    }else{
      isActive = false;
    }
    super.updateMe();
  }
  
}

class popParticle extends Particle{
  float defSize;
  popParticle(float _x, float _y, float speed, float angle, float _size, color _c){
    super(_x, _y, _c);
    vel = createVectorFromLengthAngle(speed, angle);
    size = _size;
    lifetime = 10;
    defSize = size;
  }
  
  void drawMe(){
    fill(c);
    noStroke();
    drawStar(pos.x, pos.y, size, radians(count * 2));
    size -= defSize / lifetime;
  }
}

class expandCircle extends Particle{
  float maxSize;
  color defC;
  
  expandCircle(float _x, float _y, float _maxSize, color _c){
    super(_x, _y, _c);
    defC = c;
    lifetime = 10;
    maxSize = _maxSize;
  }
  
  void drawMe(){
    lerpColor(defC, color(hue(defC), saturation(defC), brightness(defC), 0), count / lifetime);
    stroke(c);
    strokeWeight(3);
    noFill();
    float size = maxSize / lifetime * count;
    ellipse(pos.x, pos.y, size, size);
  }
}
