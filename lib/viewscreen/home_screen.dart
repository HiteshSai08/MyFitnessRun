import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final Stopwatch _stopwatch = Stopwatch();
  final Duration _interval = const Duration(milliseconds: 30);
  final List<Duration> _lapTimes = [];
  int _lapNumber = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _stopwatch.isRunning
                ? ElevatedButton(
                    onPressed: () {
                      setState(() {
                        _lapNumber++;
                        if (_stopwatch.isRunning) {
                          _lapTimes.add(_stopwatch.elapsed);
                        }
                      });
                    },
                    child: const Text(
                      'New Run',
                      style: TextStyle(fontSize: 28.0),
                    ),
                  )
                : ElevatedButton.icon(
                    onPressed: () async {
                      List<Duration> manipulateLapTimes() {
                        List<Duration> finalArr = [];
                        if (_lapTimes.isNotEmpty) {
                          for (var i = 0; i < _lapTimes.length; i++) {
                            if (i == 0) {
                              finalArr.add(_lapTimes[i]);
                            } else {
                              finalArr.add(_lapTimes[i] - _lapTimes[i - 1]);
                            }
                          }
                          if (_lapTimes.last != _stopwatch.elapsed) {
                            finalArr.add(_stopwatch.elapsed - _lapTimes.last);
                          }
                        } else if (_stopwatch.elapsed.inMilliseconds != 0) {
                          finalArr.add(_stopwatch.elapsed);
                        }
                        return finalArr;
                      }

                      await Navigator.pushNamed(
                        context,
                        "table_screen",
                        arguments: {"lapTimes": manipulateLapTimes()},
                      );
                    },
                    icon: const Icon(
                      Icons.run_circle,
                    ),
                    style: ButtonStyle(
                      iconSize: MaterialStateProperty.all(80.0),
                    ),
                    label: const Text(
                      "My Fitness Run",
                      style: TextStyle(fontSize: 28.0),
                    ),
                  ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  children: [
                    const Text("Lap Number"),
                    Text(
                      _lapNumber.toString(),
                      style: const TextStyle(
                        fontSize: 40.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                Column(
                  children: [
                    const Text("Total Time"),
                    Text(
                      formatStopwatchTime(_stopwatch.elapsed),
                      style: const TextStyle(
                        fontSize: 40.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 20),
            InkWell(
              onDoubleTap: () {
                setState(() {
                  _stopwatch.stop();
                  _stopwatch.reset();
                  _lapTimes.clear();
                  _lapNumber = 0;
                });
              },
              onTap: () {
                setState(() {
                  if (_stopwatch.isRunning) {
                    _stopwatch.stop();
                  } else {
                    _stopwatch.start();
                    _startTimer();
                    if (_lapNumber == 0) _lapNumber++;
                  }
                });
              },
              child: Image.asset(_stopwatch.isRunning
                  ? "assets/stopwatch_red.png"
                  : "assets/stopwatch_green.png"),
            ),
            const SizedBox(height: 20),
            Column(
              children: [
                const Text("Lap Time"),
                Text(
                  _lapNumber > 0
                      ? _lapTimes.isEmpty
                          ? formatStopwatchTime(_stopwatch.elapsed)
                          : formatStopwatchTime(
                              _stopwatch.elapsed - _lapTimes.last)
                      : '00:00.00',
                  style: const TextStyle(
                    fontSize: 40.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  void _startTimer() {
    Future.delayed(_interval, () {
      if (_stopwatch.isRunning) {
        setState(() {});
        _startTimer();
      }
    });
  }

  String formatStopwatchTime(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    String twoDigitCentiseconds(int n) =>
        (n % 10).toString() + (n ~/ 10).toString();
    String twoDigitSeconds(int n) => twoDigits(n % 60);
    String twoDigitMinutes(int n) => twoDigits(n % 3600 ~/ 60);

    final minutes = twoDigitMinutes(duration.inSeconds);
    final seconds = twoDigitSeconds(duration.inSeconds);
    final centiseconds =
        twoDigitCentiseconds((duration.inMilliseconds ~/ 10) % 100);

    return '$minutes:$seconds.$centiseconds';
  }
}
