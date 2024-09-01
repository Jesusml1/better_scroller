import 'package:flutter/material.dart';

class CustomScrollPhysics extends ScrollPhysics {
  final double speedFactor;

  const CustomScrollPhysics({
    super.parent,
    this.speedFactor = 1.0,
  });

  @override
  CustomScrollPhysics applyTo(ScrollPhysics? ancestor) {
    return CustomScrollPhysics(
      parent: buildParent(ancestor),
      speedFactor: speedFactor,
    );
  }

  @override
  Simulation? createBallisticSimulation(
    ScrollMetrics position,
    double velocity,
  ) {
    final Simulation? simulation =
        super.createBallisticSimulation(position, velocity);
    if (simulation != null) {
      return ClampingScrollSimulation(
        position: position.pixels,
        velocity: velocity * speedFactor,
      );
    }
    return simulation;
  }
}
