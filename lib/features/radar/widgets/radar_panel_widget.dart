import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:signal/core/constants/colors.dart';
import 'package:signal/features/radar/models/radar_ping.dart';

final Random random = Random();

class RadarPanelWidget extends StatefulWidget {
  const RadarPanelWidget({super.key});

  @override
  State<RadarPanelWidget> createState() => _RadarPanelWidgetState();
}

class _RadarPanelWidgetState extends State<RadarPanelWidget> {
  static const int rows = 11;
  static const int cols = 23;

  final List<RadarPing> pings = [];

  final int centerX = cols ~/ 2;
  final int centerY = rows ~/ 2;

  double sweepAngle = 0;

  Timer? timer;

  @override
  void initState() {
    super.initState();

    timer = Timer.periodic(const Duration(milliseconds: 70), (_) {
      setState(() {
        sweepAngle = (sweepAngle + 0.08) % (pi * 2);
        _updateRadar();
      });
    });
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  void _updateRadar() {
    if (random.nextDouble() < 0.005) {
      pings.add(
        RadarPing(
          random.nextInt(cols),
          random.nextInt(rows),
          random.nextInt(50) + 10,
        ),
      );
    }

    for (final p in pings) {
      p.life--;
    }

    pings.removeWhere((p) => p.life <= 0);
  }

  bool _isInSweep(int x, int y) {
    final dx = x - centerX;
    final dy = y - centerY;

    double angle = atan2(dy.toDouble(), dx.toDouble());

    if (angle < 0) {
      angle += 2 * pi;
    }

    final diff = (angle - sweepAngle).abs();
    final minDiff = min(diff, 2 * pi - diff);

    return minDiff < 0.4;
  }

  String get radarAscii {
    final buffer = List.generate(rows, (y) {
      return List.generate(cols, (x) {
        // center
        if (x == centerX && y == centerY) {
          return '○';
        }

        // broken leds
        if ((x == 19 && y == 0) || x == 6 && y == 8) {
          return ' ';
        }
        if ((x == 20 && y == 8) || x == 2 && y == 6) {
          return '|';
        }

        RadarPing? ping;

        for (final p in pings) {
          if (p.x == x && p.y == y) {
            ping = p;
            break;
          }
        }

        final inSweep = _isInSweep(x, y);

        if (ping != null) {
          if (inSweep) {
            ping.life += 3;
            return '*';
          }

          if (ping.life > 15) return '@';
          if (ping.life > 8) return '#';
          return '+';
        }

        if (inSweep) return ' ';

        return '·';
      });
    });

    return buffer.map((r) => r.join(' ')).join('\n');
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        border: BoxBorder.fromLTRB(
          right: BorderSide(
            width: 1.5,
            color: primaryColor.withValues(alpha: 0.35),
          ),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('RADAR_MATRIX // ACTIVE', style: secondaryTextStyle),
          Expanded(
            child: FittedBox(
              fit: BoxFit.fill,
              child: Text(
                radarAscii,
                textWidthBasis: TextWidthBasis.longestLine,
                style: tertiaryTextStyle.copyWith(
                  fontFamily: 'Fixedsys62',
                  fontWeight: FontWeight.bold,
                  height: 1.0,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
