# my_progress_bar

This is the package which can be use to create progress bars.
This progress bar is effective than Slider provided by the flutter itself.
MyProgressBar is easy to customize. This package contains two types of progress bar.
* HorizontalProgressBar()
* VerticalProgressBar() 

> Visit Github repository of [my_progress_bar](https://github.com/adnanflutterdev/my_progress_bar.git) for more information.


## Progress bars preview


[Screenshot](https://github.com/adnanflutterdev/my_progress_bar/blob/main/assets/Screenshot_20250308-114739.jpg?raw=true).
<center><img src="https://github.com/adnanflutterdev/my_progress_bar/blob/main/assets/Screenshot_20250308-114739.jpg?raw=true" height="400"></center>

## Getting started

```
dependencies:
 my_progress_bar: ^1.0.2
```
or
```
flutter pub get my_progress_bar
```
## Usage

Import the following in the your project file.

```
import 'package:my_progress_bar/progress_bar.dart';
```

### For HorizontalProgressBar()
```dart
 HorizontalProgressBar(
    maxValue: 10,
    currentPosition: currentPosition,
    onChanged: (val) {
        setState(() {
            currentPosition = val;
        });
    },
)
```

### For VerticalProgressBar()

```dart
VerticalProgressBar(
    height: 200,
    maxValue: 10,
    currentPosition: currentPosition,
    onChanged: (val) {
        setState(() {
            currentPosition = val;
        });
    },
)
```

#### 