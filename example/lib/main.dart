import 'package:flutter/material.dart';
import 'package:my_progress_bar/progress_bar.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My progressbar package',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
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
  double p1 = 0;
  double p2 = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 211, 211, 211),
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text(
          'MyProgressBar example',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text('Horizontal Progressbar example'),
            const SizedBox(
              height: 20,
            ),
            HorizontalProgressBar(
              maxValue: 30,
              currentPosition: p1,
              enabledHeight: 20,
              onChanged: (val) {
                setState(() {
                  p1 = val;
                });
              },
            ),
            const SizedBox(
              height: 50,
            ),
            const Text('Vertical Progressbar example'),
            const SizedBox(
              height: 20,
            ),
            VerticalProgressBar(
              height: 200,
              maxValue: 10,
              currentPosition: p2,
              bufferedPosition: 4,
              // enabledWidth: 50,
              onChanged: (val) {
                setState(() {
                  p2 = val;
                });
              },
            )
          ],
        ),
      ),
    );
  }
}
