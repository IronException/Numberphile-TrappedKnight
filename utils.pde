


public String intify(float num){
  String rV = num + "";
  try{
    if(rV.split("\\.")[1].equals("0")){
      rV = rV.split("\\.")[0];
    }
  } catch(Exception e){}
  return rV;
}

public float planeNum(float x, float y){
  x *= -1;
  y *= 1;
  
  float zw = x;
  x = y;
  y = zw;
  
  float a = abs(abs(x) - abs(y)) + abs(x) + abs(y);
  float rV = a * a + (a + x - y) * sign(x + y + 0.1) + 1.0;

  //rV =  x * x + y * y;
  
  return rV;
}

public float sign(float in){
  if(in < 0){
    return -1;
  } else if(in > 0){
    return 1;
  }
  return in; // cuz if 0 its 0
}


// to here add to git/AllApi... // TODO

public float[][] getMoves(String moves){
  //moves = moves.substring(1, moves.length() - 2);
  
  String[] coords = moves.split("\\), \\(");
  coords[0] = coords[0].substring(2);
  coords[coords.length - 1] = coords[coords.length - 1].substring(0, coords[coords.length - 1].length() - 2);
  float[][] rV = new float[coords.length][];
  String[] sp;
  for(int i = 0; i < rV.length; i ++){
    
    sp = coords[i].split("/");
    
    rV[i] = new float[]{Float.parseFloat(sp[0]), Float.parseFloat(sp[1])};
  }
  
  return rV;
  /*
  return new float[][]{
    new float[]{ 1, 2 },
    new float[]{ -1, 2 },
    new float[]{ -2, -1 },
    new float[]{ -2, 1 },
    
    new float[]{ 2, 1 },
    new float[]{ 2, -1 },
    new float[]{ -1, -2 },
    new float[]{ 1, -2 },
    
    new float[]{ 0, 0 }
  };*/
}

public float[] tryMoves(float xP, float yP){
  
  float xShift, yShift, shiftNum = Float.MAX_VALUE;
  xShift = 0;
  yShift = 0;
  float xCur, yCur, sCur;
  xCur = 0;
  yCur = 0;
  for(int i = 0; i < moves.length; i ++){
    xCur = xP + moves[i][0];
    yCur = yP + moves[i][1];
    if(!isAlreadyTaken(xCur, yCur)){
      sCur = planeNum(xCur, yCur);
      if(isBetter(shiftNum, sCur)){
        xShift = xCur;
        yShift = yCur;
        shiftNum = sCur;
        //println(xCur + " " + yCur + " -> " + shiftNum);
      }
    }
    
    
  }
  if(shiftNum == Float.MAX_VALUE){
    println("stopped after " + series.length);
    
    stop = true;
  } else {
    series = append(series, (int) shiftNum);
  }
  
  return new float[] { xShift, yShift };
}

public boolean isBetter(float old, float nev){
  if(abs(nev) < old){
    return true;
  }
  return false;
}


public boolean isAlreadyTaken(float xC, float yC){
  for(int i = 0; i < x.length; i ++){
    if(x[i] == xC && y[i] == yC){
      return true;
    }
  }
  return false;
}


/*
  
  
  formula:
  A=||x|−|y||+|x|+|y|;

R=A2+(A+x−y)sgn(x+y+0.1)+1;

x,y∈Z

float a = abs(abs(x) - abs(y)) + abs(x) + abs(y);
float rV = a * a + (a + x - y) * sign(x + y + 0.1) + 1.0;

from https://math.stackexchange.com/questions/163080/on-a-two-dimensional-grid-is-there-a-formula-i-can-use-to-spiral-coordinates-in
  
*/


public HashMap<String, String> getVars(String[] data){
  HashMap<String, String> rV = new HashMap<String, String>();
  String[] sp;
  for(int i = 0; i < data.length; i ++){
    sp = data[i].split(": ");
    try{
      rV.put(sp[0], sp[1]);
    } catch(Exception e){}
  }
  return rV;
}




public float[] getPos(String in){
  //moves = moves.substring(1, moves.length() - 2);
  // ignore that it says coords
  String[] coords = in.split(", ");
  coords[0] = coords[0].substring(1);
  coords[coords.length - 1] = coords[coords.length - 1].substring(0, coords[coords.length - 1].length() - 1);
  float[] rV = new float[coords.length];
  String[] sp;
  for(int i = 0; i < rV.length; i ++){
    
    rV[i] = Float.parseFloat(coords[i]);
  }
  
  return rV;
}



public int[] getCols(String in){
  //moves = moves.substring(1, moves.length() - 2);
  // ignore that it says coords
  String[] coords = in.split(", ");
  coords[0] = coords[0].substring(1);
  coords[coords.length - 1] = coords[coords.length - 1].substring(0, coords[coords.length - 1].length() - 1);
  int[] rV = new int[coords.length];
  String[] sp;
  for(int i = 0; i < rV.length; i ++){
    
    rV[i] = Integer.parseInt(coords[i]);
  }
  
  return rV;
}



public int convertColor(float value, float[] pos, int[] cols){
  for(int i = 0; i < pos.length; i ++){
    if(value < pos[i]){
      int down = cols[i - 1];
      int up = cols[i];
      float dif = (value - pos[i - 1]) / (pos[i] - pos[i - 1]);
      
      return color(
        red(down) + dif * (red(up) - red(down)),
        green(down) + dif * (green(up) - green(down)),
        blue(down) + dif * (blue(up) - blue(down)));
    }
  }
  return cols[cols.length - 1];
}


