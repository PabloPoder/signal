import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:signal/core/constants/colors.dart';
import 'package:signal/core/utils/date_parser.dart';
import 'package:signal/features/anomalies/models/anomaly.dart';
import 'package:signal/features/anomalies/providers/anomaly_provider.dart';
import 'package:signal/features/radar/models/radar_ping.dart';

enum RadarEvent { persistentPing, acceleratedSweep, interference }

class RadarPanelWidget extends ConsumerStatefulWidget {
  const RadarPanelWidget({super.key});

  @override
  ConsumerState<RadarPanelWidget> createState() => _RadarPanelWidgetState();
}

class _RadarPanelWidgetState extends ConsumerState<RadarPanelWidget> {
  static const int rows = 13;
  static const int cols = 23;
  final List<RadarPing> pings = [];
  final int centerX = cols ~/ 2;
  final int centerY = rows ~/ 2;
  double sweepAngle = 0;
  Timer? timer;

  final Random random = Random();

  /// Anomaly event
  Anomaly? lastProcessedAnomaly;

  RadarEvent? activeEvent;
  Timer? eventTimer;

  @override
  void initState() {
    super.initState();

    final initialAnomalies = ref.read(anomalyProvider);
    if (initialAnomalies.isNotEmpty) {
      lastProcessedAnomaly = initialAnomalies.last;
    }

    timer = Timer.periodic(const Duration(milliseconds: 100), (_) {
      if (!mounted) return;
      setState(() {
        final double speed = (activeEvent == RadarEvent.acceleratedSweep)
            ? 0.50
            : (activeEvent == RadarEvent.interference)
            ? 0.0
            : 0.08;
        sweepAngle = (sweepAngle + speed) % (pi * 2);

        _updateRadar();
      });
    });
  }

  @override
  void dispose() {
    timer?.cancel();
    eventTimer?.cancel();
    super.dispose();
  }

  void _triggerAnomalyEvent() {
    final event = RadarEvent.values[random.nextInt(RadarEvent.values.length)];
    switch (event) {
      case RadarEvent.persistentPing:
        _startPersistentPing();
      case RadarEvent.acceleratedSweep:
        _startAcceleratedSweep();
      case RadarEvent.interference:
        _startInterference();
    }
    _scheduleEventReset();
  }

  void _scheduleEventReset() {
    eventTimer?.cancel();
    eventTimer = Timer(const Duration(seconds: 8), () {
      if (!mounted) return;
      setState(() {
        activeEvent = null;
        pings.removeWhere((p) => p.life > 100);
      });
    });
  }

  //* EVENTS *//
  void _startPersistentPing() {
    activeEvent = RadarEvent.persistentPing;
    pings.add(RadarPing(random.nextInt(cols), random.nextInt(rows), 999));
  }

  void _startAcceleratedSweep() {
    activeEvent = RadarEvent.acceleratedSweep;
  }

  void _startInterference() {
    activeEvent = RadarEvent.interference;
  }

  void _updateRadar() {
    /// Spawn a ping
    if (random.nextDouble() < 0.0001) {
      pings.add(
        RadarPing(
          random.nextInt(cols),
          random.nextInt(rows),
          random.nextInt(50) + 10,
        ),
      );
    }

    /// low down ping's life
    for (final p in pings) {
      p.life--;
    }

    /// Remove dead pings from the list
    pings.removeWhere((p) => p.life <= 0);
  }

  bool _isInSweep(int x, int y) {
    final dx = x - centerX;
    final dy = y - centerY;

    double angle = atan2(dy.toDouble(), dx.toDouble());
    if (angle < 0) angle += 2 * pi;

    final diff = (angle - sweepAngle).abs();
    final minDiff = min(diff, 2 * pi - diff);

    return minDiff < 0.4;
  }

  String get radarAscii {
    final buffer = List.generate(rows, (y) {
      return List.generate(cols, (x) {
        if (x == centerX && y == centerY) return ' ';

        if (activeEvent == RadarEvent.interference &&
            random.nextDouble() < 0.18) {
          const noiseChars = ['%', '#', '§', '?', 'i', '*', 'X'];
          return noiseChars[random.nextInt(noiseChars.length)];
        }

        if (random.nextDouble() < 0.0001) return ' ';

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

          if (ping.life > 100) return '@';
          if (ping.life > 15) return '@';
          if (ping.life > 8) return '#';
          return '+';
        }

        return inSweep ? ' ' : '·';
      });
    });

    return buffer.map((r) => r.join(' ')).join('\n');
  }

  String get telemetry {
    String stateString = 'NOMINAL';
    if (activeEvent == RadarEvent.interference) {
      stateString = 'ERR_INTERFERENCE';
    }
    if (activeEvent == RadarEvent.persistentPing) stateString = 'ANOM_TRACKED';
    if (activeEvent == RadarEvent.acceleratedSweep) stateString = 'OVERCLOCK';

    final last = lastProcessedAnomaly != null
        ? formatTimeHour(lastProcessedAnomaly!.detectedAt)
        : 'CLEAR';

    return '''
PINGS: ${pings.length.toString().padLeft(2, '0')}  ANGLE: ${(sweepAngle * 180 / pi).round()}°
STATE: $stateString 
LAST: $last''';
  }

  @override
  Widget build(BuildContext context) {
    final anomalies = ref.watch(anomalyProvider);
    final latestAnomaly = anomalies.isNotEmpty ? anomalies.last : null;

    if (latestAnomaly != null && latestAnomaly.id != lastProcessedAnomaly?.id) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (!mounted) return;
        setState(() {
          lastProcessedAnomaly = latestAnomaly;
          _triggerAnomalyEvent(); // Dispara la ruleta de eventos analógicos
        });
      });
    }

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
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                FittedBox(
                  fit: BoxFit.contain,
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
                Text(telemetry, style: tertiaryTextStyle),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
