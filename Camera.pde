class Camera {
  float x;
  float y;
  float z;
  
  float fl;
  float dfl;
  
  float t = 0;
  
  Camera(float pos_x, float pos_y, float pos_z, float focal_length) {
    x = pos_x;
    y = pos_y;
    z = pos_z;
    dfl = focal_length;
    fl = 1;
  }
  
  void fly() {
    // drift up and down slowly
    t+=.001;

    fl += (dfl-fl)*.004;
    z+=1;
  }    
}
