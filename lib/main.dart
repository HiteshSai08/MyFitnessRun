import 'package:fitnessrun/viewscreen/home_screen.dart';
import 'package:fitnessrun/viewscreen/table_screen.dart';
import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: "home_screen",
      routes: {
        "home_screen": (context) => const HomeScreen(),
        "table_screen": (context) {
          Object? args = ModalRoute.of(context)?.settings.arguments;

          var argument = args as Map;
          List<Duration> lapTimes = argument['lapTimes'];

          return TableScreen(lapTimes: lapTimes);
        },
      },
    );
  }
}
