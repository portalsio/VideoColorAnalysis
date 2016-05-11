//simple class for tracking the colors over time
class ColorCounter {
  color farbe;
  int count;
  double factor;
  ColorCounter(color farbcache) {
    farbe=farbcache;
    count=1;
    factor=0.0;
  }
}