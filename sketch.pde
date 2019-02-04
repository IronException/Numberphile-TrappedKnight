


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
  
  
  textSize(height / 32.0);
  
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
      "background: " + color(0),
      "pos: [0, 100]",
      "cols: ["
        + color(64) + ", "
        + color(255) + "]",
      "moves: [(1/2), "
        + "(-1/2), "
        + "(-2/-1), "
        + "(-2/1), "
        + "(2/1), "
        + "(2/-1), "
        + "(-1/-2), "
        + "(1/-2), "
        + "(0/0)]"
    };
    saveStrings(getPath(), data);
  }
  
  
  
  HashMap<String, String> vars = getVars(data);
  
  bgCol = Integer.parseInt(vars.get("background"));
  frontCol = color(255 - red(bgCol), 255 - green(bgCol), 255 - blue(bgCol));
  
  println(frontCol + " " + color(255));
  background(bgCol);
  
  pos = getPos(vars.get("pos"));
  cols = getCols(vars.get("cols"));
  
  speed = Float.parseFloat(vars.get("speed"));
  
  float xStart = Float.parseFloat(vars.get("xStart"));
  float yStart = Float.parseFloat(vars.get("yStart"));
  
  x = new float[] { xStart };
  y = new float[] { yStart };
  
  size = 1;
  
  moves = getMoves(vars.get("moves"));
  
  
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

int biggest = 0;

int bgCol, frontCol;

int maxMoves;

float[] x, y;
float size;

float speed;

boolean stop;

float[] series;


float[] pos;
int[] cols;


void draw(){
  if(stop){
    return;
  }
  background(bgCol);
  doIteration();
  
  
  fill(frontCol);
  String txt = "last: n(" + (series.length - 1) + ") = " + intify(series[series.length - 1])
    + "  (" + intify(x[series.length - 1]) + "/" + intify(y[series.length - 1]) + ")";
  text(txt, textAscent(), 2.0 * textAscent());
  
  txt = "biggest: n(" + biggest + ") = " + intify(series[biggest])
    + "  (" + intify(x[biggest]) + "/" + intify(y[biggest]) + ")";
  text(txt, textAscent(), 4.0 * textAscent());
  
  
  
  translate(width / 2.0, height / 2.0);
  float scale = (width / 2.0) / size;
  float xLast = x[0] * scale;
  float yLast = y[0] * scale;
  float val;
  for(int i = 1; i < x.length; i ++){
    val = i * 100.0 / x.length;
    
    stroke(convertColor(val, pos, cols));
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
    
    lastAction();
    
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
  
  
  if(planeNum(nev[0], nev[1]) > planeNum(x[biggest], y[biggest])){
    biggest = series.length - 1;
  }
}

public void lastAction(){
  String[] info = new String[series.length];
    for(int i = 0; i < info.length; i ++){
      info[i] = "n(" + i + ") = " + intify(series[i]);
    }
    saveStrings(getPath() + ".txt", info);
    saveFrame(getPath() + ".png");
    
}
