## [1.0.0] - September 6, 2024
* Updated for Flutter 3.x and Dart 2.14+ to use `Object.hash()` and `Object.hashAll()` instead of 
  `hashValues()` and `hashList()`
* Updated to use `flutter_color_models` 2.0.0 and `color_models` 2.0.0 which also now support Flutter 3.x
* Added a example app which illustrates the use of the package and the differences in gradients that can be
  achieved with the different available color models.  This example was tested on android, ios, web, macosx
  and windows. 

## [0.1.1] - March 21, 2021

* Override the equality operators on [LinearGradientPainter],
[RadialGradientPainter], and [SweepGradientPainter].

## [0.1.0] - March 18, 2021

* Initial release.
