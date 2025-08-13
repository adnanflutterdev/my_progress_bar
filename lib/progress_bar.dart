import 'package:flutter/material.dart';

/// The class [HorizontalProgressBar] is used to create a horizontal progress bar.
/// The required parameters of the [HorizontalProgressBar] are [maxValue], [currentPosition] and [onChanged]
///
/// Use of [HorizontalProgressBar]
///
/// example:
/// ```dart
///  HorizontalProgressBar(
///    maxValue: 10,
///  // [currentPosition] should be declared before its uses
///    currentPosition: currentPosition,
///    onChanged: (val) {
///        setState(() {
///            currentPosition = val;
///        });
///    },
///)
/// ```
///

class HorizontalProgressBar extends StatelessWidget {
  const HorizontalProgressBar(
      {super.key,
      required this.maxValue,
      required this.currentPosition,
      required this.onChanged,
      this.width,
      this.bufferedPosition,
      this.onChangeStart,
      this.onChangeEnd,
      this.bufferedColor = Colors.grey,
      this.progressColor = Colors.blue,
      this.thumbColor = const Color.fromRGBO(13, 71, 161, 1),
      this.thumbDiameter = 15,
      this.trackHeight = 10,
      this.enabledHeight = 10,
      this.isThumbVisible = true});

  /// [maxValue] represents the maximum value of the progress bar, the value ranges from 0 to [maxValue].
  final double maxValue;

  /// [currentPosition] Represents the progressbar's current position.
  final double currentPosition;

  /// [onChanged] Callback function. Called whenever the progressbar's current value gots changed.
  final ValueChanged<double> onChanged;

  /// [onChangeStart] callback function. Called whenever the progressbar's current value starts to be changed.
  /// It only called when the progressbar is dragged.
  final ValueChanged<double>? onChangeStart;

  /// [onChangeEnd] Callback function. Called whenever the progressbar's current value changes ends.
  /// It only called when the progressbar is dragged.
  final ValueChanged<double>? onChangeEnd;

  /// [bufferedPosition] sets the buffer position.
  final double? bufferedPosition;

  /// [bufferedColor] sets buffered area color.
  final Color bufferedColor;

  /// [progressColor] Progress area color.
  final Color progressColor;

  /// [thumbColor] sets the color of the thumb.
  final Color thumbColor;

  /// [thumbDiameter] the diameter of the thumb.
  final double thumbDiameter;

  /// [trackHeight] height of the progress and buffered track.
  final double trackHeight;

  /// [width] sets the width of the progress bar.
  final double? width;

  /// [enabledHeight] sets the height of the progressbar.
  final double enabledHeight;

  /// [isThumbVisible] sets whether the thumb is visible or not.
  final bool isThumbVisible;

  @override
  Widget build(BuildContext context) {
    assert(trackHeight < thumbDiameter,
        'trackHeight: $trackHeight must be less than thumbDiameter : $thumbDiameter');
    assert(currentPosition <= maxValue,
        'Currentposition : $currentPosition is greater than the maxValue');

    double maxLength = width ?? MediaQuery.of(context).size.width;
    maxLength = maxLength - thumbDiameter;
    final partition = maxLength / maxValue;
    final top = (thumbDiameter + enabledHeight) / 2 - trackHeight / 2;

    return GestureDetector(
      onTapDown: (details) {
        onChanged((details.localPosition.dx ~/ partition)
            .clamp(0, maxValue)
            .toDouble());
      },
      onHorizontalDragStart: (details) {
        if (onChangeStart != null) {
          onChangeStart!((details.localPosition.dx ~/ partition)
              .clamp(0, maxValue)
              .toDouble());
        }
      },
      onHorizontalDragEnd: (details) {
        if (onChangeEnd != null) {
          onChangeEnd!((details.localPosition.dx ~/ partition)
              .clamp(0, maxValue)
              .toDouble());
        }
      },
      onHorizontalDragUpdate: (details) {
        onChanged((details.localPosition.dx ~/ partition)
            .clamp(0, maxValue)
            .toDouble());
      },
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: thumbDiameter / 2),
        child: Container(
          width: maxLength,
          height: thumbDiameter + enabledHeight,
          color: Colors.transparent,
          child: Stack(
            children: [
              Positioned(
                top: top,
                left: 0,
                child: Container(
                  width: maxLength,
                  height: trackHeight,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(trackHeight / 2)),
                ),
              ),
              if (bufferedPosition != null)
                Positioned(
                  top: top,
                  left: 0,
                  child: Container(
                    width: bufferedPosition! * partition,
                    height: trackHeight,
                    decoration: BoxDecoration(
                        color: bufferedColor,
                        borderRadius: BorderRadius.circular(trackHeight / 2)),
                  ),
                ),
              Positioned(
                top: top,
                left: 0,
                child: Container(
                  width: currentPosition * partition,
                  height: trackHeight,
                  decoration: BoxDecoration(
                      color: progressColor,
                      borderRadius: BorderRadius.circular(trackHeight / 2)),
                ),
              ),
              if (isThumbVisible)
                Positioned(
                  top: enabledHeight / 2,
                  left: currentPosition * partition - thumbDiameter / 2,
                  child: Container(
                    width: thumbDiameter,
                    height: thumbDiameter,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: thumbColor,
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

/// The class [VerticalProgressBar] is used to create a vertical progress bar.
/// The required parameters of the [VerticalProgressBar] are [height], [maxValue], [currentPosition] and [onChanged]
///
/// Use of [VerticalProgressBar]
///
/// example:
/// ```dart
///VerticalProgressBar(
///    height: 200,
///    maxValue: 10,
///  // [currentPosition] should be declared before its uses
///    currentPosition: currentPosition,
///    onChanged: (val) {
///        setState(() {
///            currentPosition = val;
///        });
///    },
///)
/// ```
///

class VerticalProgressBar extends StatelessWidget {
  const VerticalProgressBar({
    super.key,
    required this.height,
    required this.maxValue,
    required this.currentPosition,
    required this.onChanged,
    this.bufferedPosition,
    this.onChangeStart,
    this.onChangeEnd,
    this.bufferedColor = Colors.grey,
    this.progressColor = Colors.blue,
    this.thumbColor = const Color.fromRGBO(13, 71, 161, 1),
    this.thumbDiameter = 18,
    this.trackWidth = 10,
    this.enabledWidth = 10,
    this.isThumbVisible = true,
  });

  /// [height] sets the height of the progress bar
  final double height;

  /// [maxValue] Represents the maximum value the progressbar can have.
  final double maxValue;

  /// [currentPosition] Represents the progressbar's current position.
  final double currentPosition;

  /// [onChanged] Callback function. Called whenever the progressbar's current value gots changed.
  final ValueChanged<double> onChanged;

  /// [onChangeStart] callback function. Called whenever the progressbar's current value starts to be changed.
  /// It only called when the progressbar is dragged.
  final ValueChanged<double>? onChangeStart;

  /// [onChangeEnd] Callback function. Called whenever the progressbar's current value changes ends.
  /// It only called when the progressbar is dragged.
  final ValueChanged<double>? onChangeEnd;

  /// [bufferedPosition] Represents the buffered value.
  final double? bufferedPosition;

  /// [bufferedColor] Buffered area color.
  final Color bufferedColor;

  /// [progressColor] Progress area color.
  final Color progressColor;

  /// [thumbColor] Thumb color.
  final Color thumbColor;

  /// [thumbDiameter] The diameter of the thumb it should be less than [trackWidth].
  final double thumbDiameter;

  /// [trackWidth] Height of the progress and buffered track
  final double trackWidth;

  /// [enabledWidth] refers the width of the gesture detector which can be used for dragging
  final double enabledWidth;

  /// [isThumbVisible] sets whether the thumb is visible or not.
  final bool isThumbVisible;

  @override
  Widget build(BuildContext context) {
    final maxLength = height - thumbDiameter;
    final partition = maxLength / maxValue;
    final left = (thumbDiameter + enabledWidth) / 2 - trackWidth / 2;

    assert(trackWidth < thumbDiameter,
        'trackWidth: $trackWidth must be less than thumbDiameter : $thumbDiameter');
    assert(currentPosition <= maxValue,
        'Currentposition : $currentPosition is greater than the maxValue');

    return GestureDetector(
      onTapDown: (details) {
        onChanged(((maxLength - details.localPosition.dy) ~/ partition)
            .clamp(0, maxValue)
            .toDouble());
      },
      onVerticalDragStart: (details) {
        if (onChangeStart != null) {
          onChangeStart!(((maxLength - details.localPosition.dy) ~/ partition)
              .clamp(0, maxValue)
              .toDouble());
        }
      },
      onVerticalDragEnd: (details) {
        if (onChangeEnd != null) {
          onChangeEnd!(((maxLength - details.localPosition.dy) ~/ partition)
              .clamp(0, maxValue)
              .toDouble());
        }
      },
      onVerticalDragUpdate: (details) {
        onChanged(((maxLength - details.localPosition.dy) ~/ partition)
            .clamp(0, maxValue)
            .toDouble());
      },
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: thumbDiameter / 2),
        child: Container(
          width: thumbDiameter + enabledWidth,
          height: maxLength,
          color: Colors.transparent,
          child: Stack(
            children: [
              Positioned(
                bottom: 0,
                left: left,
                child: Container(
                  height: maxLength,
                  width: trackWidth,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(trackWidth / 2)),
                ),
              ),
              if (bufferedPosition != null)
                Positioned(
                  bottom: 0,
                  left: left,
                  child: Container(
                    height: bufferedPosition! * partition,
                    width: trackWidth,
                    decoration: BoxDecoration(
                        color: bufferedColor,
                        borderRadius: BorderRadius.circular(trackWidth / 2)),
                  ),
                ),
              Positioned(
                bottom: 0,
                left: left,
                child: Container(
                  height: currentPosition * partition,
                  width: trackWidth,
                  decoration: BoxDecoration(
                      color: progressColor,
                      borderRadius: BorderRadius.circular(trackWidth / 2)),
                ),
              ),
              if(isThumbVisible)
              Positioned(
                left: enabledWidth / 2,
                bottom: (currentPosition * partition) - thumbDiameter / 2,
                child: Container(
                  width: thumbDiameter,
                  height: thumbDiameter,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: thumbColor,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
