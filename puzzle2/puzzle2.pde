import ketai.ui.*;                                      // Libreria para la deteccion de gestos en movil
import android.view.MotionEvent;

int cols = 3;
int rows = 3;
int numCells = cols * rows;
int scl = 800 / cols;
//int[] cells = new int[numCells];

PFont font; 

KetaiGesture gesture;      

int index;
int up;
int right;
int down;
int left ;
int cont=0;

PImage photo;
PImage cells[];
PImage partsCorrect[];
int  n=3;   //Numero de piezas es igual al valor de n al cuadrado -1
int w,h,x,y;

void setup() {
  orientation(PORTRAIT);  //vertical
  gesture = new KetaiGesture(this);  
  size(800, 800);
  /*size(801, 801);
  reset();
  font = createFont("Arial", 48);*/
  w = 800/n;
  h = 800/n;
  photo=loadImage("happyface.jpg");    //carga de imagen
  photo.resize(800,800);
  cells = new PImage[n*n];        //array para almacenar partes de la img
  partsCorrect = new PImage[n*n]; //array para comprar el orden correcto 
  int k=0;
  for(int j=0;j<n;j++){
      for(int i=0;i<n;i++){
        if(k>8) break;
          cells[j*n+i]=photo.get(i*w,j*h,w,h);
          partsCorrect[j*n+i]=photo.get(i*w,j*h,w,h);
          k++;
    }
  }
}

void draw() {
  background(255);
  
  /*for (int i = 0; i < cols; i++) {
    for (int j = 0; j < rows; j++) {
      index = i + j * cols;
      
      stroke(0);
      noFill();
      if (cells[index] > 0) {
        fill(90, 90, 90);
      }
      rect(i*scl, j*scl, scl, scl);
      
      if (cells[index] > 0) {
        fill(0, 255, 0);
        textSize(48);
        textFont(font);
        textAlign(CENTER, CENTER);
        text(cells[index], i*scl + scl/2, j*scl + scl/2);
      }
    }
  }*/
  int k=0;
  for(int j=0;j<n;j++){
    for(int i=0;i<n;i++){
      stroke(0);
    //  if(x!=i||y!=j){
        if(k>8) break;
        image(cells[j*n+i],i*w,j*h);
    //  }
     noFill();
     rect(i*w,j*h,w,h);
     k++;
    }
  }
}


public boolean surfaceTouchEvent(MotionEvent event) { 
  //call to keep mouseX and mouseY constants updated
  super.surfaceTouchEvent(event);
  //forward events
  return gesture.surfaceTouchEvent(event);
}


void onFlick( float x, float y, float px, float py, float v) 
{

   index = findZero(cells);
   up = index - cols;
   right = index + 1;
   down = index + cols;
   left = index - 1;
  
  if (index < cols) {
    up = index;
  } else if (index % cols == cols - 1) {
    right = index;
  } else if (index > numCells - cols) {
    down = index;
  } else if (index % cols == 0) {
    left = index;
  }
  
  //if (surfaceTouchEvent()) {
    if (py<y){
      swap(cells, index, down);
      println("py:" + py + ",y" + y);
    } else if (px<x){
      swap(cells, index, left);
    } else if (py>y) {
      swap(cells, index, up);
    } else if (px>x) {
      swap(cells, index, right);
    }
  //}

  cont++;
}
/*
void reset() {
  for (int i = 0; i < numCells; i++) {
    cells[i] = i + 1;
  }
  
  swap(cells, numCells-3, numCells-2);
  cells[numCells-1] = 0;
  
}
*/
int findZero(PImage[] arr) {
  int index = -1;
  
  for (int i = 0; i < arr.length; i++) {
    if (arr[i] != null) {
      index = i;
      break;
    }
  }
  
  return index;
}

void swap(PImage[] arr, int i, int j) {
  PImage temp = arr[i];
  arr[i] = arr[j];
  arr[j] = temp;
}
