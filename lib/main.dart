import 'dart:async';
import 'package:flutter/material.dart';
import 'package:my_progress_bar/my_progress_bar.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool isPlaying = false;
  Timer? timer;
  double currentPosition = 0;

  void play() {
    isPlaying = !isPlaying;
    setState(() {});
    if (isPlaying) {
      timer = Timer.periodic(Duration(seconds: 1), (a) {
        currentPosition++;
        if (currentPosition > 19) {
          timer!.cancel();
          isPlaying = false;
          currentPosition = 0;
        }
        setState(() {});
      });
    } else {
      if (timer != null && timer!.isActive) {
        timer!.cancel();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[200],
      appBar: AppBar(
        backgroundColor: Colors.blue[900],
        title: Text(
          'Progress Bar Example',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            MyProgressBar(
              trackHeight: 10,
              currentPosition: currentPosition,
              maxValue: 20,
              onChanged: (value) {
                setState(() {
                  currentPosition = value;
                });
              },
              bufferedPosition: 10,
              bufferedColor: Colors.grey,
              thumbDiameter: 20,
            ),
            SizedBox(
              height: 20,
            ),
            IconButton(
                onPressed: play,
                icon: Icon(
                  isPlaying ? Icons.pause : Icons.play_arrow,
                  color: Colors.white,
                  size: 40,
                ))
          ],
        ),
      ),
    );
  }
}
