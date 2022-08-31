import 'dart:isolate';

bool _running = true;

void mainLoop(SendPort sendPort) async {
  const int fps = 50;
  const int second = 1000;
  const double updateTime = second / fps;

  Stopwatch loopWatch = Stopwatch()..start();
  Stopwatch timerWatch = Stopwatch()..start();

  while (_running) {
    if (loopWatch.elapsedMilliseconds >= updateTime) {
      loopWatch.reset();
      sendPort.send(true);
    }

    if (timerWatch.elapsedMilliseconds > second) {
      timerWatch.reset();
    }
  }
}

void stopLoop() {
  _running = false;
}
