import 'package:fitnessrun/utils/time_util.dart';
import 'package:flutter/material.dart';

class TableScreen extends StatelessWidget {
  const TableScreen({Key? key, required this.lapTimes}) : super(key: key);
  final List<Duration> lapTimes;

  Duration calculateAverageLapTime() {
    if (lapTimes.isEmpty) {
      return Duration.zero;
    }

    final totalMilliseconds = lapTimes
        .map((lapTime) => lapTime.inMilliseconds)
        .reduce((value, element) => value + element);

    final averageMilliseconds = totalMilliseconds ~/ lapTimes.length;

    return Duration(milliseconds: averageMilliseconds);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Lap Times"),
      ),
      bottomNavigationBar: BottomAppBar(
        child: Center(
          child: Text(
              "Average Lap Time: ${formatStopwatchTime(calculateAverageLapTime())}"),
        ),
      ),
      body: ListView.builder(
        itemCount: lapTimes.length,
        itemBuilder: (BuildContext context, int index) {
          return SizedBox(
            height: 50,
            child: Center(
                child: Text(
                    'Lap ${index + 1}: ${formatStopwatchTime(lapTimes[index])}')),
          );
        },
      ),
    );
  }
}
