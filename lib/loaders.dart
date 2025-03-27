import 'dart:async';
import 'package:flutter/material.dart';
import 'dart:math';

/// A loader that displays rotating circles around a central point.
/// Usage example
/// ``` dart
/// RotatingCirclesLoader()
/// ```
///
/// Also you sets the following parameters to customize the loader
///
/// [ballsCount] -> sets the number of rotating balls.
///
/// [loaderRadius] -> sets the radius of the loader.
///
/// [ballRadius] -> sets the radius to the rotating balls.
///
/// [ballsColor] -> sets the color of the balls.
class RotatingCirclesLoader extends StatefulWidget {
  /// Creates a rotating circles loader.
  const RotatingCirclesLoader({
    super.key,
    this.ballsCount = 6,
    this.loaderRadius = 30,
    this.ballRadius = 5,
    this.ballsColor = Colors.white,
  });

  /// The radius of each ball in the loader.
  final double ballRadius;

  /// The radius of the entire loader circle.
  final double loaderRadius;

  /// The number of balls in the loader.
  final int ballsCount;

  /// The color of the balls.
  final Color ballsColor;

  @override
  State<RotatingCirclesLoader> createState() => _RotatingCirclesLoaderState();
}

class _RotatingCirclesLoaderState extends State<RotatingCirclesLoader>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
        vsync: this, duration: Duration(milliseconds: 2000));
    _animation = Tween<double>(begin: 0, end: 2 * pi)
        .animate(CurvedAnimation(parent: _controller, curve: Curves.easeIn));
    _controller.repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.transparent,
      width: widget.loaderRadius * 2,
      height: widget.loaderRadius * 2,
      child: AnimatedBuilder(
          animation: _controller,
          builder: (context, child) {
            double center = widget.loaderRadius - widget.ballRadius;
            double r = (widget.loaderRadius - widget.ballRadius);
            return Transform(
              alignment: Alignment.center,
              transform: Matrix4.identity()..rotateZ(_animation.value),
              child: Stack(
                children: List.generate(widget.ballsCount, (index) {
                  final top =
                      center + r * sin((index * 2 * pi) / widget.ballsCount);
                  final left =
                      center + r * cos((index * 2 * pi) / widget.ballsCount);
                  return Positioned(
                      top: top,
                      left: left,
                      child: Container(
                        width: widget.ballRadius * 2,
                        height: widget.ballRadius * 2,
                        decoration: BoxDecoration(
                            color: widget.ballsColor, shape: BoxShape.circle),
                      ));
                }),
              ),
            );
          }),
    );
  }
}

/// A loader that displays a row of dots that are filled sequentially.
/// Usage example
/// ``` dart
/// DottedLoader()
/// ```
///
/// Also you sets the following parameters to customize the loader
///
/// [ballsCount] -> sets the number of rotating balls.
///
/// [loaderWidth] -> sets the width of the loader.
///
/// [ballRadius] -> sets the radius to the rotating balls.
///
/// [ballsColor] -> sets the color of the balls.
///
/// [ballsFillColor] -> sets the color of the progress balls.
class DottedLoader extends StatefulWidget {
  const DottedLoader(
      {super.key,
      this.ballsCount = 5,
      this.loaderWidth = 150,
      this.ballRadius = 5,
      this.ballsColor = Colors.white,
      this.ballsFillColor = Colors.black});

  /// The radius of each ball in the loader.
  final double ballRadius;

  /// The width of the entire loader.
  final double loaderWidth;

  /// The number of balls in the loader.
  final int ballsCount;

  /// The color of the balls when they are not filled.
  final Color ballsColor;

  /// The color of the balls when they are filled.
  final Color ballsFillColor;

  @override
  State<DottedLoader> createState() => _DottedLoaderState();
}

class _DottedLoaderState extends State<DottedLoader>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<int> _animation;

  @override
  void initState() {
    super.initState();
    _controller =
        AnimationController(vsync: this, duration: Duration(seconds: 1));
    _animation = IntTween(begin: 0, end: widget.ballsCount.toInt() + 1)
        .animate(CurvedAnimation(parent: _controller, curve: Curves.easeIn));
    _controller.repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.loaderWidth,
      child: AnimatedBuilder(
          animation: _controller,
          builder: (context, child) {
            return Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: List.generate(widget.ballsCount, (index) {
                return Container(
                  width: widget.ballRadius * 2,
                  height: widget.ballRadius * 2,
                  decoration: BoxDecoration(
                      color: _animation.value - 1 >= index
                          ? widget.ballsFillColor.withValues(
                              alpha: ((index + 1) / (widget.ballsCount - 1))
                                  .clamp(0.0, 1.0))
                          : Colors.white,
                      shape: BoxShape.circle),
                );
              }),
            );
          }),
    );
  }
}

/// A loader that displays three jumping or waving circles.
///
/// Usage example
/// ``` dart
/// JumpingCirclesLoader()
/// ```
///
/// Also you sets the following parameters to customize the loader
///
/// [ballRadius] -> sets the radius to the rotating balls.
///
/// [ballsColor] -> sets the color of the balls.
///
/// [jumpHeight] -> sets the maximum height the ball jumps to up and down
class JumpingCirclesLoader extends StatefulWidget {
  /// Creates a jumping circles loader.
  const JumpingCirclesLoader({
    super.key,
    this.ballRadius = 10,
    this.ballsColor = Colors.white,
    this.jumpHeight = 20,
  });

  /// The radius of each ball in the loader.
  final double ballRadius;

  /// The color of the balls.
  final Color ballsColor;

  /// The maximum height the balls jump.
  final double jumpHeight;

  @override
  State<StatefulWidget> createState() => _JumpingCirclesLoaderState();
}

class _JumpingCirclesLoaderState extends State<JumpingCirclesLoader>
    with TickerProviderStateMixin {
  late AnimationController _circle1;
  late AnimationController _circle2;
  late AnimationController _circle3;

  late Tween<double> _tween;

  @override
  void initState() {
    super.initState();
    _circle1 =
        AnimationController(vsync: this, duration: Duration(milliseconds: 600));
    _circle2 =
        AnimationController(vsync: this, duration: Duration(milliseconds: 600));
    _circle3 =
        AnimationController(vsync: this, duration: Duration(milliseconds: 600));

    _tween = Tween<double>(begin: 0.0, end: widget.jumpHeight);
    Timer(Duration.zero, () {
      _circle1.repeat(reverse: true);
      Timer(Duration(milliseconds: 200), () {
        _circle2.repeat(reverse: true);
        Timer(Duration(milliseconds: 200), () {
          _circle3.repeat(reverse: true);
        });
      });
    });
  }

  @override
  void dispose() {
    _circle1.dispose();
    _circle2.dispose();
    _circle3.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    List controllers = [_circle1, _circle2, _circle3];
    return SizedBox(
      width: widget.ballRadius * 6 + (widget.ballRadius * 2),
      height: widget.ballRadius * 2 + widget.jumpHeight,
      child: AnimatedBuilder(
          animation: Listenable.merge([_circle1, _circle2, _circle3]),
          builder: (context, child) {
            return Stack(
              children: List.generate(3, (index) {
                return Positioned(
                  top: _tween.evaluate(controllers[index]),
                  left: index * (widget.ballRadius * 3),
                  child: Container(
                    width: widget.ballRadius * 2,
                    height: widget.ballRadius * 2,
                    decoration: BoxDecoration(
                        color: widget.ballsColor, shape: BoxShape.circle),
                  ),
                );
              }),
            );
          }),
    );
  }
}

/// A loader that displays three expanding boxes.
///
/// Usage example
/// ``` dart
/// ExpandingBoxLoader()
/// ```
///
/// Also you sets the following parameters to customize the loader
///
/// [boxWidth] -> sets the width to the boxes.
///
/// [minHeight] -> sets the minimum height of the boxes.
///
/// [maxHeight] -> sets the maximum height the boxes.
///
/// [boxColor] -> sets the color of the boxes.
class ExpandingBoxLoader extends StatefulWidget {
  const ExpandingBoxLoader({
    super.key,
    this.boxWidth = 20,
    this.minHeight = 20,
    this.maxHeight = 60,
    this.boxColor = Colors.white,
  });
  final Color boxColor;
  final double boxWidth;
  final double minHeight;
  final double maxHeight;

  @override
  State<StatefulWidget> createState() => _ExpandingBoxLoaderState();
}

class _ExpandingBoxLoaderState extends State<ExpandingBoxLoader>
    with TickerProviderStateMixin {
  late AnimationController _box1;
  late AnimationController _box2;
  late AnimationController _box3;

  late Tween<double> _height;
  late Tween<double> _top;

  @override
  void initState() {
    super.initState();
    _box1 =
        AnimationController(vsync: this, duration: Duration(milliseconds: 600));
    _box2 =
        AnimationController(vsync: this, duration: Duration(milliseconds: 600));
    _box3 =
        AnimationController(vsync: this, duration: Duration(milliseconds: 600));

    _height = Tween<double>(begin: widget.minHeight, end: widget.maxHeight);
    _top = Tween<double>(
        begin: (widget.maxHeight - widget.minHeight) / 2, end: 0.0);

    Timer(Duration.zero, () {
      _box1.repeat(reverse: true);
      Timer(Duration(milliseconds: 200), () {
        _box2.repeat(reverse: true);
        Timer(Duration(milliseconds: 200), () {
          _box3.repeat(reverse: true);
        });
      });
    });
  }

  @override
  void dispose() {
    _box1.dispose();
    _box2.dispose();
    _box3.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    List controllers = [_box1, _box2, _box3];
    return Container(
      color: Colors.transparent,
      width: widget.boxWidth * 3 + (widget.boxWidth / 2 + 5) * 2,
      height: widget.maxHeight,
      child: Stack(
        children: List.generate(3, (index) {
          return AnimatedBuilder(
              animation: Listenable.merge([_box1, _box2, _box3]),
              builder: (context, child) {
                return Positioned(
                  top: _top.evaluate(controllers[index]),
                  left: (widget.boxWidth + (widget.boxWidth / 2 + 5)) *
                      index.toDouble(),
                  child: Container(
                    width: widget.boxWidth,
                    height: _height.evaluate(controllers[index]),
                    decoration: BoxDecoration(
                        color: widget.boxColor,
                        borderRadius:
                            BorderRadius.circular(widget.boxWidth / 4)),
                  ),
                );
              });
        }),
      ),
    );
  }
}
