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
