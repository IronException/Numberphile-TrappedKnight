


// permission: WRITE_EXTERNAL_STORAGE
public String getPath(){
  return android.os.Environment.getExternalStoragePublicDirectory(android.os.Environment.DIRECTORY_DCIM).getParentFile().getAbsolutePath()
   + "/trappedKnight/" + name;
}

float[][] moves;
String name;

void setup(){
  //fullScreen();
  size(1080, 1080);
  
  background(0);
  fill(255);
  stroke(255);
  
  name = "config.txt"; // this is cuz the act name is set after the config is loaded so I can use this
  String[] data = null;
  try{data = loadStrings(getPath());} catch(Exception e){}
  if(data == null){
    data = new String[]{
      "speed: 8",
      "xStart: 0",
      "yStart: 0",
      "name: trappedKnight",
      "maxMoves: -1",
      "moves: ...?"
    };
    saveStrings(getPath(), data);
  }
  
  HashMap<String, String> vars = getVars(data);
  
  
  
  speed = Float.parseFloat(vars.get("speed"));
  
  float xStart = Float.parseFloat(vars.get("xStart"));
  float yStart = Float.parseFloat(vars.get("yStart"));
  
  x = new float[] { xStart };
  y = new float[] { yStart };
  
  size = 1;
  
  moves = getMoves();
  
  series = new float[] { planeNum(x[0], y[0]) };
  
  
  /*
    // TODO to load:
    name eZ
    moves eZ
    plane how the heck? maybe names -> function...
    speed eZ
    
    maybe a slider for speed?
    maybe max moves eZ
    
    maybe also start coords eZ...
  */
  
  name = vars.get("name");
  maxMoves = Integer.parseInt(vars.get("maxMoves"));
  
}

int maxMoves;

float[] x, y;
float size;

float speed;

boolean stop;

float[] series;

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
  
  
  
}


public void doIteration(){
  
  if(speed > 1){
    for(int i = 0; i < speed; i ++){
      nevMove();
    }
  } else if(frameCount % (1.0 / speed) < 1){
    nevMove();
  }
  
  if(stop){
    
    
    String[] info = new String[series.length];
    for(int i = 0; i < info.length; i ++){
      info[i] = "n(" + i + ") = " + intify(series[i]);
    }
    saveStrings(getPath() + ".txt", info);
    saveFrame(getPath() + ".png");
  }
}


public void nevMove(){
  if(maxMoves > -1 && x.length >= maxMoves){
    stop = true;
  }
  float[] nev = tryMoves(x[x.length - 1], y[y.length - 1]);
  if(stop){
    return;
  }
  x = append(x, nev[0]);
  y = append(y, nev[1]);
  if(abs(nev[0]) > size * 1.0){
    size = abs(nev[0]);
  }
  if(abs(nev[1]) > size * 1.0){
    size = abs(nev[1]);
  }
}


