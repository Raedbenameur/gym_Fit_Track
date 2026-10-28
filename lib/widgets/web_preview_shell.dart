import 'dart:math' as math;

import 'package:flutter/material.dart';

class WebPreviewShell extends StatelessWidget {
  const WebPreviewShell({super.key, required this.child});

  final Widget child;

  static const _background = Color(0xFF080B10);
  static const _accent = Color(0xFF86E36B);

  @override
  Widget build(BuildContext context) {
    return DefaultTextStyle.merge(
      style: const TextStyle(decoration: TextDecoration.none),
      child: LayoutBuilder(
        builder: (context, constraints) {
          if (constraints.maxWidth < 760) {
            return child;
          }

          return Container(
            color: _background,
            child: Stack(
              children: [
                SafeArea(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 24,
                      vertical: 12,
                    ),
                    child: Column(
                      children: [
                        _buildHeading(
                          compact: constraints.maxHeight < 560,
                          showTitle: constraints.maxHeight >= 340,
                        ),
                        const SizedBox(height: 12),
                        Expanded(
                          child: LayoutBuilder(
                            builder: (context, previewConstraints) {
                              return Center(
                                child: _buildPhonePreview(
                                  context,
                                  maxWidth: previewConstraints.maxWidth,
                                  maxHeight: previewConstraints.maxHeight,
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildHeading({required bool compact, required bool showTitle}) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: compact ? 26 : 30,
              height: compact ? 26 : 30,
              decoration: BoxDecoration(
                color: _accent,
                borderRadius: BorderRadius.circular(9),
              ),
              child: const Icon(
                Icons.fitness_center_rounded,
                color: _background,
                size: 18,
              ),
            ),
            SizedBox(width: compact ? 8 : 10),
            Text(
              'GYMTRACK',
              style: TextStyle(
                color: Colors.white,
                fontSize: compact ? 12 : 14,
                fontWeight: FontWeight.w800,
                letterSpacing: 2,
              ),
            ),
            SizedBox(width: compact ? 10 : 14),
            Container(
              padding: EdgeInsets.symmetric(
                horizontal: compact ? 7 : 9,
                vertical: 5,
              ),

              child: const Row(
                children: [
                  Icon(Icons.circle, size: 6, color: _accent),
                  SizedBox(width: 6),
                  Text(
                    'LIVE PREVIEW',
                    style: TextStyle(
                      color: _accent,
                      fontSize: 9,
                      fontWeight: FontWeight.w700,
                      letterSpacing: 1,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        if (showTitle) ...[
          SizedBox(height: compact ? 8 : 15),
          Text(
            'Your training, in motion.',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white,
              fontSize: compact ? 18 : 23,
              fontWeight: FontWeight.w700,
              letterSpacing: -0.5,
            ),
          ),
        ],
      ],
    );
  }

  Widget _buildPhonePreview(
    BuildContext context, {
    required double maxWidth,
    required double maxHeight,
  }) {
    const framePadding = 9.0;
    const appDesignSize = Size(372, 826);
    final width = math.min(390.0, math.min(maxWidth, maxHeight * (390 / 844)));
    final height = width * (844 / 390);
    final mediaQuery = MediaQuery.of(context);

    return Container(
      width: width,
      height: height,
      padding: const EdgeInsets.all(framePadding),
      decoration: BoxDecoration(
        color: const Color(0xFF171A1F),
        borderRadius: BorderRadius.circular(48),
        border: Border.all(color: const Color(0xFF343940), width: 1.5),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.55),
            blurRadius: 60,
            offset: const Offset(0, 30),
          ),
          BoxShadow(
            color: _accent.withValues(alpha: 0.07),
            blurRadius: 70,
            spreadRadius: 2,
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(38),
        child: Stack(
          children: [
            Positioned.fill(
              child: MediaQuery(
                data: mediaQuery.copyWith(
                  size: appDesignSize,
                  padding: const EdgeInsets.only(top: 25),
                  viewPadding: const EdgeInsets.only(top: 25),
                  viewInsets: EdgeInsets.zero,
                ),
                child: FittedBox(
                  fit: BoxFit.contain,
                  child: SizedBox.fromSize(size: appDesignSize, child: child),
                ),
              ),
            ),
            Positioned(
              top: 8,
              left: 0,
              right: 0,
              child: Center(
                child: Container(
                  width: 96,
                  height: 22,
                  decoration: BoxDecoration(
                    color: const Color(0xFF050607),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Center(
                    child: Container(
                      width: 34,
                      height: 4,
                      decoration: BoxDecoration(
                        color: const Color(0xFF25292E),
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
