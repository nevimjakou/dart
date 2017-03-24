import "dart:html";
import "dart:math";
import "dart:async";

const int elmWidth = 2;
const int elmHeight = 2;
int _x = ((500 - elmWidth) / 2).toInt();
int _y = ((500 - elmHeight) / 2).toInt();
int updatesCount = 0;
Random random;
CanvasElement myCanvas;
CanvasRenderingContext2D renderingContext;

void drawBackground() {
  renderingContext.setFillColorRgb(255, 100, 100);
  renderingContext.fillRect(0, 0, 500, 500);
}

void draw() {
  renderingContext.setFillColorRgb(255, 255, 255);
  renderingContext.fillRect(_x, y, elmWidth, elmHeight);
}

void update(Timer timer) {
  x = random.nextInt(10);
  y = random.nextInt(10);

  draw();

  //window.console.log(x);
}

get x => _x;
set x(int value) {
  var plusMinus = random.nextInt(2) > 0 ? 1 : -1;
  plusMinus = _x >= 500 - elmWidth ? -1 : _x <= 0 ? 1 : plusMinus;

  _x += value * plusMinus;
  lastX = value;
}

int _lastX = 0;
get lastX => _lastX;
set lastX(int value) {
  _lastX = value;
}

get y => _y;
set y(int value) {
  var plusMinus = random.nextInt(2) > 0 ? 1 : -1;
  plusMinus = _y >= 500 - elmWidth ? -1 : _y <= 0 ? 1 : plusMinus;

  _y += value * plusMinus;
  lastY = value;
}

int _lastY = 0;
get lastY => _lastY;
set lastY(int value) {
  _lastY = value;
}

void mouseMoveOnCanvas(MouseEvent e) {
  window.console.log(e.target.toString() + " pos: " + e.toString());
}

void run() {
  Timer timer =
      new Timer.periodic(const Duration(milliseconds: 40), (Timer timer) {
    if (updatesCount > 50000) {
      restart();
    }

    update(timer);
    updatesCount++;
  });
}

void restart() {
  _x = ((500 - elmWidth) / 2).toInt();
  _y = ((500 - elmHeight) / 2).toInt();
  updatesCount = 0;
  drawBackground();
}

void main() {
  myCanvas = querySelector("#myCanvas");
  renderingContext = myCanvas.context2D;
  myCanvas.onMouseMove.listen(mouseMoveOnCanvas);

  drawBackground();

  random = new Random();
  run();
  window.console.log("test");
}
