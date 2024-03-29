import 'package:flutter/material.dart';

import '../../constants/app_constants.dart';
import '../atoms/diamond.dart';

/// Top left corner of diamond decorated box.
class TopLeftBoxCorner extends StatelessWidget {
  const TopLeftBoxCorner({
    Key? key,
    required this.colour,
  }) : super(key: key);

  final Color colour;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            CustomPaint(
              painter: Diamond(colour: colour),
              child: const SizedBox(
                height: kDiamondBoxCornerHeight,
                width: kDiamondBoxCornerWidth,
              ),
            ),
            CustomPaint(
              painter: LeftHalfDiamond(colour: colour),
              child: const SizedBox(
                height: kDiamondBoxCornerHeight,
                width: kDiamondBoxCornerWidth / 2,
              ),
            ),
          ],
        ),
        Row(
          children: [
            CustomPaint(
              painter: TopHalfDiamond(colour: colour),
              child: const SizedBox(
                height: kDiamondBoxCornerHeight / 2,
                width: kDiamondBoxCornerWidth,
              ),
            ),
            CustomPaint(
              painter: TopLeftQuarterDiamond(colour: colour),
              child: const SizedBox(
                height: kDiamondBoxCornerHeight / 2,
                width: kDiamondBoxCornerWidth / 2,
              ),
            ),
          ],
        ),
      ],
    );
  }
}

/// Top Right corner of diamond decorated box.
class TopRightBoxCorner extends StatelessWidget {
  const TopRightBoxCorner({
    Key? key,
    required this.colour,
  }) : super(key: key);

  final Color colour;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            CustomPaint(
              painter: RightHalfDiamond(colour: colour),
              child: const SizedBox(
                height: kDiamondBoxCornerHeight,
                width: kDiamondBoxCornerWidth / 2,
              ),
            ),
            CustomPaint(
              painter: Diamond(colour: colour),
              child: const SizedBox(
                height: kDiamondBoxCornerHeight,
                width: kDiamondBoxCornerWidth,
              ),
            ),
          ],
        ),
        Row(
          children: [
            CustomPaint(
              painter: TopRightQuarterDiamond(colour: colour),
              child: const SizedBox(
                height: kDiamondBoxCornerHeight / 2,
                width: kDiamondBoxCornerWidth / 2,
              ),
            ),
            CustomPaint(
              painter: TopHalfDiamond(colour: colour),
              child: const SizedBox(
                height: kDiamondBoxCornerHeight / 2,
                width: kDiamondBoxCornerWidth,
              ),
            ),
          ],
        ),
      ],
    );
  }
}

/// Down left corner of diamond decorated box.
class DownLeftBoxCorner extends StatelessWidget {
  const DownLeftBoxCorner({
    Key? key,
    required this.colour,
  }) : super(key: key);

  final Color colour;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            CustomPaint(
              painter: DownHalfDiamond(colour: colour),
              child: const SizedBox(
                height: kDiamondBoxCornerHeight / 2,
                width: kDiamondBoxCornerWidth,
              ),
            ),
            CustomPaint(
              painter: DownLeftQuarterDiamond(colour: colour),
              child: const SizedBox(
                height: kDiamondBoxCornerHeight / 2,
                width: kDiamondBoxCornerWidth / 2,
              ),
            ),
          ],
        ),
        Row(
          children: [
            CustomPaint(
              painter: Diamond(colour: colour),
              child: const SizedBox(
                height: kDiamondBoxCornerHeight,
                width: kDiamondBoxCornerWidth,
              ),
            ),
            CustomPaint(
              painter: LeftHalfDiamond(colour: colour),
              child: const SizedBox(
                height: kDiamondBoxCornerHeight,
                width: kDiamondBoxCornerWidth / 2,
              ),
            ),
          ],
        ),
      ],
    );
  }
}

/// Down right corner of diamond decorated box.
class DownRightBoxCorner extends StatelessWidget {
  const DownRightBoxCorner({
    Key? key,
    required this.colour,
  }) : super(key: key);

  final Color colour;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            CustomPaint(
              painter: DownRightQuarterDiamond(colour: colour),
              child: const SizedBox(
                height: kDiamondBoxCornerHeight / 2,
                width: kDiamondBoxCornerWidth / 2,
              ),
            ),
            CustomPaint(
              painter: DownHalfDiamond(colour: colour),
              child: const SizedBox(
                height: kDiamondBoxCornerHeight / 2,
                width: kDiamondBoxCornerWidth,
              ),
            ),
          ],
        ),
        Row(
          children: [
            CustomPaint(
              painter: RightHalfDiamond(colour: colour),
              child: const SizedBox(
                height: kDiamondBoxCornerHeight,
                width: kDiamondBoxCornerWidth / 2,
              ),
            ),
            CustomPaint(
              painter: Diamond(colour: colour),
              child: const SizedBox(
                height: kDiamondBoxCornerHeight,
                width: kDiamondBoxCornerWidth,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
