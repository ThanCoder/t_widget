import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

enum TLoaderTypes {
  FadingCircle,

  RotatingPlain,
  DoubleBounce,
  Wave,
  WanderingCubes,
  FadingFour,
  FadingCube,

  Pulse,
  ChasingDots,
  ThreeBounce,
  Circle,
  CubeGrid,

  RotatingCircle,
  FoldingCube,
  PumpingHeart,
  HourGlass,
  PouringHourGlass,
  PouringHourGlassRefined,

  FadingGrid,
  Ring,
  Ripple,
  SpinningCircle,
  SpinningLines,
  SquareCircle,

  DualRing,
  PianoWave,
  DancingSquare,
  ThreeInOut,
  WaveSpinner,
  PulsingGrid;

  static List<Widget> getWidgetList({
    double loaderSize = 50,
    Color color = Colors.black,
    Duration duration = const Duration(milliseconds: 3000),
    AnimationController? controller,
  }) {
    return TLoaderTypes.values
        .map(
          (type) => getLoaderWidget(
            type,
            loaderSize: loaderSize,
            color: color,
            duration: duration,
            controller: controller,
          ),
        )
        .toList();
  }

  static Widget getLoaderWidget(
    TLoaderTypes types, {
    required double loaderSize,
    required Color color,
    Duration duration = const Duration(milliseconds: 3000),
    AnimationController? controller,
  }) {
    switch (types) {
      case TLoaderTypes.FadingCircle:
        return SpinKitFadingCircle(
          size: loaderSize,
          color: color,
          duration: duration,
          controller: controller,
        );
      case TLoaderTypes.ChasingDots:
        return SpinKitChasingDots(
          size: loaderSize,
          color: color,
          duration: duration,
        );
      case TLoaderTypes.DoubleBounce:
        return SpinKitDoubleBounce(
          size: loaderSize,
          color: color,
          duration: duration,
          controller: controller,
        );
      case TLoaderTypes.Wave:
        return SpinKitWave(
          size: loaderSize,
          color: color,
          duration: duration,
          controller: controller,
        );
      case TLoaderTypes.WanderingCubes:
        return SpinKitWanderingCubes(
          size: loaderSize,
          color: color,
          duration: duration,
        );
      case TLoaderTypes.FadingFour:
        return SpinKitFadingFour(
          size: loaderSize,
          color: color,
          duration: duration,
          controller: controller,
        );
      case TLoaderTypes.FadingCube:
        return SpinKitFadingCube(
          size: loaderSize,
          color: color,
          duration: duration,
          controller: controller,
        );
      case TLoaderTypes.Pulse:
        return SpinKitPulse(
          size: loaderSize,
          color: color,
          duration: duration,
          controller: controller,
        );
      case TLoaderTypes.ThreeBounce:
        return SpinKitThreeBounce(
          size: loaderSize,
          color: color,
          duration: duration,
          controller: controller,
        );
      case TLoaderTypes.Circle:
        return SpinKitCircle(
          size: loaderSize,
          color: color,
          duration: duration,
          controller: controller,
        );
      case TLoaderTypes.CubeGrid:
        return SpinKitCubeGrid(
          size: loaderSize,
          color: color,
          duration: duration,
          controller: controller,
        );
      case TLoaderTypes.RotatingCircle:
        return SpinKitRotatingCircle(
          size: loaderSize,
          color: color,
          duration: duration,
          controller: controller,
        );
      case TLoaderTypes.FoldingCube:
        return SpinKitFoldingCube(
          size: loaderSize,
          color: color,
          duration: duration,
          controller: controller,
        );
      case TLoaderTypes.PumpingHeart:
        return SpinKitPumpingHeart(
          size: loaderSize,
          color: color,
          duration: duration,
          controller: controller,
        );
      case TLoaderTypes.FadingGrid:
        return SpinKitFadingGrid(
          size: loaderSize,
          color: color,
          duration: duration,
          controller: controller,
        );
      case TLoaderTypes.Ripple:
        return SpinKitRipple(
          size: loaderSize,
          color: color,
          duration: duration,
          controller: controller,
        );
      case TLoaderTypes.SpinningCircle:
        return SpinKitSpinningCircle(
          size: loaderSize,
          color: color,
          duration: duration,
          controller: controller,
        );
      case TLoaderTypes.SquareCircle:
        return SpinKitSquareCircle(
          size: loaderSize,
          color: color,
          duration: duration,
          controller: controller,
        );
      case TLoaderTypes.PianoWave:
        return SpinKitPianoWave(
          size: loaderSize,
          color: color,
          duration: duration,
          controller: controller,
        );
      case TLoaderTypes.DancingSquare:
        return SpinKitDancingSquare(
          size: loaderSize,
          color: color,
          duration: duration,
          controller: controller,
        );
      case TLoaderTypes.ThreeInOut:
        return SpinKitThreeInOut(
          size: loaderSize,
          color: color,
          duration: duration,
          controller: controller,
        );
      case TLoaderTypes.PulsingGrid:
        return SpinKitPulsingGrid(
          size: loaderSize,
          color: color,
          duration: duration,
          controller: controller,
        );
      case TLoaderTypes.RotatingPlain:
        return SpinKitRotatingPlain(
          size: loaderSize,
          color: color,
          duration: duration,
          controller: controller,
        );
      // need color value
      case TLoaderTypes.HourGlass:
        return SpinKitHourGlass(
          size: loaderSize,
          color: color,
          duration: duration,
          controller: controller,
        );
      case TLoaderTypes.PouringHourGlass:
        return SpinKitPouringHourGlass(
          size: loaderSize,
          color: color,
          duration: duration,
          controller: controller,
        );
      case TLoaderTypes.PouringHourGlassRefined:
        return SpinKitPouringHourGlassRefined(
          size: loaderSize,
          color: color,
          duration: duration,
          controller: controller,
        );
      case TLoaderTypes.Ring:
        return SpinKitRing(
          size: loaderSize,
          color: color,
          duration: duration,
          controller: controller,
        );
      case TLoaderTypes.SpinningLines:
        return SpinKitSpinningLines(
          size: loaderSize,
          color: color,
          duration: duration,
          controller: controller,
        );
      case TLoaderTypes.DualRing:
        return SpinKitDualRing(
          size: loaderSize,
          color: color,
          duration: duration,
          controller: controller,
        );
      case TLoaderTypes.WaveSpinner:
        return SpinKitWaveSpinner(
          size: loaderSize,
          color: color,
          duration: duration,
          controller: controller,
        );
    }
  }
}
