import 'package:flutter/material.dart';

class FastPageController extends PageController {
  final double speedFactor;

  FastPageController({
    this.speedFactor = 2.0,
    super.initialPage,
  });

  @override
  ScrollPosition createScrollPosition(
    ScrollPhysics physics,
    ScrollContext context,
    ScrollPosition? oldPosition,
  ) {
    return FastScrollPosition(
      physics: physics,
      context: context,
      oldPosition: oldPosition,
      speedFactor: speedFactor,
    );
  }
}

class FastScrollPosition extends ScrollPositionWithSingleContext {
  final double speedFactor;
  FastScrollPosition({
    required super.physics,
    required super.context,
    super.oldPosition,
    this.speedFactor = 2.0,
  });

  @override
  Future<void> animateTo(
    double to, {
    required Duration duration,
    required Curve curve,
  }) {
    return super.animateTo(
      to,
      duration: Duration(
          milliseconds: (duration.inMilliseconds / speedFactor).round()),
      curve: curve,
    );
  }
}
