


// permission: WRITE_EXTERNAL_STORAGE
public String getPath(){
  return android.os.Environment.getExternalStoragePublicDirectory(android.os.Environment.DIRECTORY_DCIM).getParentFile().getAbsolutePath() + "/CODING/static";
}

float[][] moves;

void setup(){
  //fullScreen();
  size(1080, 1080);
  
  background(0);
  fill(255);
  stroke(255);
  
  speed = 4096 / 24;
  
  x = new float[] { 0 };
  y = new float[] { 0 };
  
  size = 1;
  
  moves = getMoves();
  
  
  
  
}

float[] x, y;
float size;

float speed;

boolean stop;

void draw(){
  if(stop){
    return;
  }
  background(0);
  doIteration();
  
  translate(width / 2.0, height / 2.0);
  float scale = (width / 2.0) / size;
  float xLast = x[0] * scale;
  float yLast = y[0] * scale;
  for(int i = 1; i < x.length; i ++){
    line(x[i] * scale, y[i] * scale, xLast, yLast);
    xLast = x[i] * scale;
    yLast = y[i] * scale;
  }
  
  
  //text(size + " " + x.length, 0, 0);
  
  
  if(frameCount == 24){
    saveFrame(getPath() + "/icon.png");
    stop = true;
  }
}


public void doIteration(){
  
  if(speed > 1){
    for(int i = 0; i < speed; i ++){
      nevMove();
    }
  } else if(frameCount % (1.0 / speed) < 1){
    nevMove();
  }
}


public void nevMove(){
  float[] nev = tryMoves(x[x.length - 1], y[y.length - 1]);
  x = append(x, nev[0]);
  y = append(y, nev[1]);
  if(abs(nev[0]) > size * 1.0){
    size = abs(nev[0]);
  }
  if(abs(nev[1]) > size * 1.0){
    size = abs(nev[1]);
  }
}