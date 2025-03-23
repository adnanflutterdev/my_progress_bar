import 'package:flutter/material.dart';
import 'package:my_progress_bar/loaders.dart';
import 'package:my_progress_bar/progress_bar.dart';
// import 'package:my_progress_bar/progress_bar.dart';

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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 211, 211, 211),
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text(
          'my_progress_bar package',
          style: TextStyle(color: Colors.white, fontSize: 20),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextButton(
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => ProgressBarExample(),
                  ));
                },
                child: Text('Progress bar example')),
            TextButton(
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => LoaderExample(),
                  ));
                },
                child: Text('Loader example')),
          ],
        ),
      ),
    );
  }
}

class ProgressBarExample extends StatefulWidget {
  const ProgressBarExample({super.key});

  @override
  State<ProgressBarExample> createState() => _ProgressBarExampleState();
}

class _ProgressBarExampleState extends State<ProgressBarExample> {
  double p1 = 0;
  double p2 = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Progress bar example",
          style: TextStyle(color: Colors.white, fontSize: 20),
        ),
        backgroundColor: Colors.blue,
      ),
      backgroundColor: const Color.fromARGB(255, 211, 211, 211),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Horizontal Progressbar example'),
            const SizedBox(
              height: 20,
            ),
            HorizontalProgressBar(
              maxValue: 30,
              currentPosition: p1,
              enabledHeight: 20,
              isThumbVisible: false,
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
              onChanged: (val) {
                setState(() {
                  p2 = val;
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}

class LoaderExample extends StatefulWidget {
  const LoaderExample({super.key});

  @override
  State<LoaderExample> createState() => _LoaderExampleState();
}

class _LoaderExampleState extends State<LoaderExample> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Loader example",
          style: TextStyle(color: Colors.white, fontSize: 20),
        ),
        backgroundColor: Colors.blue,
      ),
      backgroundColor: const Color.fromARGB(255, 211, 211, 211),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Spacer(),
            Text('RotatingCirclesLoader() example'),
            const SizedBox(
              height: 15,
            ),
            RotatingCirclesLoader(
              ballsCount: 7,
              ballRadius: 6,
              loaderRadius: 30,
              ballsColor: Colors.white,
            ),
            const Spacer(),
            Text('DottedLoader() example'),
            const SizedBox(
              height: 15,
            ),
            DottedLoader(
              ballRadius: 10,
              loaderWidth: 300,
              ballsCount: 6,
              ballsFillColor: Colors.red,
            ),
            const Spacer(),
            Text('JumpingCirclesLoader() example'),
            const SizedBox(
              height: 15,
            ),
            JumpingCirclesLoader(
              ballRadius: 10,
              jumpHeight: 30,
            ),
            const Spacer(),
            Text('ExpandingBoxLoader() example'),
            const SizedBox(
              height: 15,
            ),
            ExpandingBoxLoader(
              maxHeight: 60,
              minHeight: 10,
              boxWidth: 20,
            ),
            const Spacer(),
          ],
        ),
      ),
    );
  }
}
