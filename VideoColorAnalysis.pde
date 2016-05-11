import processing.video.*;
import  java.util.*;

//Capture video;
Movie video;
//ArrayList farben;
HashMap<Integer, ColorCounter> colorMap;
ArrayList<ColorCounter> colorList;
int videoFrameCount=0;


void setup() {
  size(1200, 700);
  frameRate(15);
  selectInput("Select a video file:", "fileSelected");
  colorMap = new HashMap();
  colorList = new ArrayList();

  textSize(7);
}

void fileSelected(File file) {
  video = new Movie(this, file.getAbsolutePath());
  video.play();
  video.volume(0);
  colorMap = new HashMap();
  colorList = new ArrayList();
}






// Called every time a new frame is available to read
void movieEvent(Movie video) {
  videoFrameCount++;
  video.read();
  video.filter(POSTERIZE, 10);
  
  
    //FARBEN ZURÜCKSETZEN
  for (int i=colorList.size()-1; i>=0; i--) {
   ColorCounter f = colorList.get(i);
    f.count=0;
  }

  //FARBEN SAMMELN
  int totalPixelCount = video.pixels.length;
  for (int i=0; i<totalPixelCount; i++) {
    int pixel = video.pixels[i];
    ColorCounter f = colorMap.get(pixel);
    if (f!=null) {
      f.count++;
    } else {
      colorMap.put(pixel, new ColorCounter(pixel));
    }
  }
  
      //FARBEN GESAMTWERT 
  for (int i=colorList.size()-1; i>=0; i--) {
   ColorCounter f = colorList.get(i);
      double ratio = (double) f.count/totalPixelCount;
      f.factor+=ratio;
  }

  //FARBEN AUFLISTEN
  colorList = new ArrayList<ColorCounter>(colorMap.values());

  //FARBEN FILTERN
  //int removed=0;
  //for (int i=colorList.size()-1; i>=0; i--) {
  //  ColorCounter f = colorList.get(i);
  //  if (f.avgcount<0.01) { 
  //    colorMap.remove(f.farbe);
  //    colorList.remove(i);
  //    removed++;
  //  }
  //}
  //println(removed);
  //FARBEN SORTIEREN
  Collections.sort(colorList, new CountComparator());
}


void draw() {
  background(100);
  pushMatrix();
  translate(width/4*3, height/2);
  pieChart(colorList, 200, 330);
  popMatrix();

  if (video!=null) {
    pushMatrix();
    translate(width/4, height/2);
    imageMode(CENTER);
    image(video, 0, 0, width/40*16, width/40*9);
    popMatrix();
  }
}