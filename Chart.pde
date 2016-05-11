//function to draw a pie chart for all tracked colors
void pieChart(ArrayList<ColorCounter> colorList, float innerRadius, float outerRadius) {
  float totalFactorSum = 0;
  for (int i=0; i<colorList.size(); i++) {
    ColorCounter f = colorList.get(i);
    totalFactorSum+=f.factor;
  }


  int size = colorList.size();
  float lastAngle = -PI/2.0;
  noStroke();
  for (int i = 0; i < size; i++) {
    ColorCounter f = colorList.get(i);
    color c = f.farbe;
    float angle = (float)f.factor/totalFactorSum*TWO_PI;
    if(totalFactorSum<0) println("count: "+ f.count+", total: "+totalFactorSum);
    fill(c);
    arc(0, 0, outerRadius, outerRadius, lastAngle, lastAngle+angle);

    if (angle/TWO_PI>0.02) {
      pushMatrix();
      rotate(lastAngle+angle/2.0);
      stroke(0);
      line(outerRadius*0.5+5, 0, outerRadius*0.55-2, 0);
      noStroke();
      fill(0);
      textSize(30);
      translate(outerRadius*0.55, 0);
      String percent = round(angle/TWO_PI*100.0)+"%";
      float percentTextWidth = outerRadius*0.03+textWidth(percent);

      if (lastAngle+angle/2.0<PI/2.0) {
        textAlign(LEFT, CENTER);
      } else {
        rotate(PI);
        textAlign(RIGHT, CENTER);
        percentTextWidth*=-1;
      }

      text(percent, 0, 0);
      textSize(8);
      textLeading(10);
      String s = "R: " +int(red(f.farbe)) +"\nG: " + int(green(f.farbe)) +"\nB: " + int(blue(f.farbe));
      text(s, percentTextWidth, 0);
      popMatrix();
    }
    lastAngle += angle;
  }

  //center hole
  fill(100);
  ellipse(0, 0, innerRadius, innerRadius);

  //center text
  fill(255);
  textSize(70);
  textAlign(CENTER, BOTTOM);
  text(size, 0, 25);
  textSize(10);
  textAlign(CENTER, TOP);
  fill(255);
  text("RGB COLORS TRACKED", 0, 25);
}