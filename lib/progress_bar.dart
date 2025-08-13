import 'package:flutter/material.dart';

/// The class [HorizontalProgressBar] is used to create a horizontal progress bar.
/// The required parameters of the [HorizontalProgressBar] are:
/// [maxValue], [currentPosition], and [onChanged].
///
/// **Use of [HorizontalProgressBar]**
/// ```dart
/// HorizontalProgressBar(
///   maxValue: 10,
///   // [currentPosition] should be declared before its uses
///   currentPosition: currentPosition,
///   onChanged: (val) {
///     setState(() {
///       currentPosition = val;
///     });
///   },
/// )
/// ```
///
/// **Notes:**
/// - Uses `/` for smooth decimal precision (instead of integer division `~/`).
/// - Clamps positions to prevent overflow of thumb or buffered area.
/// - Stores last drag value to use in `onChangeEnd` without errors.
/// - Validation moved to constructor for better error reporting.
///

class HorizontalProgressBar extends StatelessWidget {
  const HorizontalProgressBar({
    super.key,
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
    this.isThumbVisible = true,
  })  : assert(trackHeight < thumbDiameter,
            'trackHeight must be less than thumbDiameter'),
        assert(currentPosition >= 0 && currentPosition <= maxValue,
            'currentPosition must be within 0 and maxValue');

  /// [maxValue] represents the maximum value of the progress bar, the value ranges from 0 to [maxValue].
  final double maxValue;

  /// [currentPosition] Represents the progressbar's current position.
  final double currentPosition;

  /// [onChanged] Callback function. Called whenever the progressbar's current value gets changed.
  final ValueChanged<double> onChanged;

  /// [onChangeStart] Callback function. Called whenever the progressbar's current value starts to be changed.
  /// It is only called when the progressbar is dragged.
  final ValueChanged<double>? onChangeStart;

  /// [onChangeEnd] Callback function. Called whenever the progressbar's current value change ends.
  /// It is only called when the progressbar is dragged.
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
    double? lastValue; // To store value for drag end

    return LayoutBuilder(builder: (context, constraints) {
      final maxLength = (width ?? constraints.maxWidth) - thumbDiameter;
      final partition = maxLength / maxValue;
      final top = (thumbDiameter + enabledHeight) / 2 - trackHeight / 2;
      return GestureDetector(
        onTapDown: (details) {
          onChanged((details.localPosition.dx / partition).clamp(0, maxValue));
        },
        onHorizontalDragStart: (details) {
          double value =
              (details.localPosition.dx / partition).clamp(0, maxValue);
          lastValue = value;
          if (onChangeStart != null) onChangeStart!(value);
        },
        onHorizontalDragUpdate: (details) {
          double value =
              (details.localPosition.dx / partition).clamp(0, maxValue);
          lastValue = value;
          onChanged(value);
        },
        onHorizontalDragEnd: (_) {
          if (lastValue != null && onChangeEnd != null) {
            onChangeEnd!(lastValue!);
          }
        },
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: thumbDiameter / 2),
          child: Container(
            width: maxLength,
            height: thumbDiameter + enabledHeight,
            color: Colors.transparent,
            child: Stack(
              children: [
                // Base track
                Positioned(
                  top: top,
                  left: 0,
                  child: Container(
                    width: maxLength,
                    height: trackHeight,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(trackHeight / 2),
                    ),
                  ),
                ),
                // Buffered area
                if (bufferedPosition != null)
                  Positioned(
                    top: top,
                    left: 0,
                    child: Container(
                      width: bufferedPosition!.clamp(0, maxValue) * partition,
                      height: trackHeight,
                      decoration: BoxDecoration(
                        color: bufferedColor,
                        borderRadius: BorderRadius.circular(trackHeight / 2),
                      ),
                    ),
                  ),
                // Progress area
                Positioned(
                  top: top,
                  left: 0,
                  child: Container(
                    width: currentPosition.clamp(0, maxValue) * partition,
                    height: trackHeight,
                    decoration: BoxDecoration(
                      color: progressColor,
                      borderRadius: BorderRadius.circular(trackHeight / 2),
                    ),
                  ),
                ),
                // Thumb
                if (isThumbVisible)
                  Positioned(
                    top: enabledHeight / 2,
                    left: (currentPosition * partition - thumbDiameter / 2)
                        .clamp(0, maxLength - thumbDiameter),
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
    });
  }
}

/// The class [VerticalProgressBar] is used to create a vertical progress bar.
/// The required parameters of the [VerticalProgressBar] are:
/// [height], [maxValue], [currentPosition], and [onChanged].
///
/// **Use of [VerticalProgressBar]**
/// ```dart
/// VerticalProgressBar(
///   height: 200,
///   maxValue: 10,
///   // [currentPosition] should be declared before its uses
///   currentPosition: currentPosition,
///   onChanged: (val) {
///     setState(() {
///       currentPosition = val;
///     });
///   },
/// )
/// ```
///
/// **Notes:**
/// - Same fixes as Horizontal: smooth precision, clamping, and safe drag end handling.
/// - Full height used for touch detection.

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
  })  : assert(trackWidth < thumbDiameter,
            'trackWidth must be less than thumbDiameter'),
        assert(currentPosition >= 0 && currentPosition <= maxValue,
            'currentPosition must be within 0 and maxValue');

  /// [height] sets the height of the progress bar.
  final double height;

  /// [maxValue] Represents the maximum value the progressbar can have.
  final double maxValue;

  /// [currentPosition] Represents the progressbar's current position.
  final double currentPosition;

  /// [onChanged] Callback function. Called whenever the progressbar's current value gets changed.
  final ValueChanged<double> onChanged;

  /// [onChangeStart] Callback function. Called whenever the progressbar's current value starts to be changed.
  /// It is only called when the progressbar is dragged.
  final ValueChanged<double>? onChangeStart;

  /// [onChangeEnd] Callback function. Called whenever the progressbar's current value change ends.
  /// It is only called when the progressbar is dragged.
  final ValueChanged<double>? onChangeEnd;

  /// [bufferedPosition] Represents the buffered value.
  final double? bufferedPosition;

  /// [bufferedColor] Buffered area color.
  final Color bufferedColor;

  /// [progressColor] Progress area color.
  final Color progressColor;

  /// [thumbColor] Thumb color.
  final Color thumbColor;

  /// [thumbDiameter] The diameter of the thumb; it should be greater than [trackWidth].
  final double thumbDiameter;

  /// [trackWidth] Width of the progress and buffered track.
  final double trackWidth;

  /// [enabledWidth] Width of the gesture detector used for dragging.
  final double enabledWidth;

  /// [isThumbVisible] sets whether the thumb is visible or not.
  final bool isThumbVisible;

  @override
  Widget build(BuildContext context) {
    final maxLength = height - thumbDiameter;
    final partition = maxLength / maxValue;
    final left = (thumbDiameter + enabledWidth) / 2 - trackWidth / 2;

    double? lastValue; // To store value for drag end

    return GestureDetector(
      onTapDown: (details) {
        onChanged(((maxLength - details.localPosition.dy) / partition)
            .clamp(0, maxValue));
      },
      onVerticalDragStart: (details) {
        double value = ((maxLength - details.localPosition.dy) / partition)
            .clamp(0, maxValue);
        lastValue = value;
        if (onChangeStart != null) onChangeStart!(value);
      },
      onVerticalDragUpdate: (details) {
        double value = ((maxLength - details.localPosition.dy) / partition)
            .clamp(0, maxValue);
        lastValue = value;
        onChanged(value);
      },
      onVerticalDragEnd: (_) {
        if (lastValue != null && onChangeEnd != null) {
          onChangeEnd!(lastValue!);
        }
      },
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: thumbDiameter / 2),
        child: Container(
          width: thumbDiameter + enabledWidth,
          height: height,
          color: Colors.transparent,
          child: Stack(
            children: [
              // Base track
              Positioned(
                bottom: 0,
                left: left,
                child: Container(
                  height: maxLength,
                  width: trackWidth,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(trackWidth / 2),
                  ),
                ),
              ),
              // Buffered area
              if (bufferedPosition != null)
                Positioned(
                  bottom: 0,
                  left: left,
                  child: Container(
                    height: bufferedPosition!.clamp(0, maxValue) * partition,
                    width: trackWidth,
                    decoration: BoxDecoration(
                      color: bufferedColor,
                      borderRadius: BorderRadius.circular(trackWidth / 2),
                    ),
                  ),
                ),
              // Progress area
              Positioned(
                bottom: 0,
                left: left,
                child: Container(
                  height: currentPosition.clamp(0, maxValue) * partition,
                  width: trackWidth,
                  decoration: BoxDecoration(
                    color: progressColor,
                    borderRadius: BorderRadius.circular(trackWidth / 2),
                  ),
                ),
              ),
              // Thumb
              if (isThumbVisible)
                Positioned(
                  left: enabledWidth / 2,
                  bottom: (currentPosition * partition - thumbDiameter / 2)
                      .clamp(0, maxLength - thumbDiameter),
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
