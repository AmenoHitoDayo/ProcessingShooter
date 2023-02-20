PVector createVectorFromLengthAngle(float leng, float angle){
  float vx = leng * cos(angle);
  float vy = leng * sin(angle);
  return new PVector(vx, vy);
}

PVector affineRotate(PVector pos, PVector center, float angle){
  pos.sub(center);
  
  float dx = pos.x * cos(angle) + pos.y * sin(angle) + center.x;
  float dy = pos.x * sin(angle) + pos.y * cos(angle) + center.y;
  
  return new PVector(dx, dy);
}

void drawStar(float x, float y, float size, float angle){
  pushMatrix();
    translate(x, y);
    rotate(angle);
    beginShape();
      for(int i = 0; i < 5; i++){
        vertex(size * cos(radians(i * (360 / 5))), size * sin(radians(i * (360 / 5))));
        vertex(size / 2 * cos(radians(i * (360 / 5) + (360 / 10))), size / 2 * sin(radians(i * (360 / 5) + (360 / 10))));
      }
    endShape(CLOSE);
  popMatrix();
}
