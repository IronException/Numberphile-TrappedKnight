

public float planeNum(float x, float y){
  return x * x + y * y;
}


public float[][] getMoves(){
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
  };
}

public float[] tryMoves(float x, float y){
  
  float xShift, yShift, shiftNum = Float.MAX_VALUE;
  xShift = 0;
  yShift = 0;
  float xCur, yCur, sCur;
  xCur = 0;
  yCur = 0;
  for(int i = 0; i < moves.length; i ++){
    xCur = x + moves[i][0];
    yCur = y + moves[i][1];
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
    stop = true;
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