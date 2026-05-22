import 'dart:async';

import 'package:flutter/material.dart';
import 'package:signal/core/constants/colors.dart';

class AnomalyPanelWidget extends StatefulWidget {
  const AnomalyPanelWidget({super.key});

  @override
  State<AnomalyPanelWidget> createState() => _AnomalyPanelWidgetState();
}


class _AnomalyPanelWidgetState extends State<AnomalyPanelWidget> {

static const noAnomaly = [
r'''
稳定 ────── 0.12dB
[█████░░░] 64%

▆▅▃▂▂        ▂▂▃▅▅

[NO_ANOMALIES_DETECTED]
''', 

r'''
稳定 ────── 0.12dB
[█████░░░] 64%

▅▆▅▃▂▂        ▂▂▃▅

[NO_ANOMALIES_DETECTED]
''', 

r'''
稳定 ────── 0.12dB
[█████░░░] 64%

▃▅▆▅▃▂▂        ▂▂▃

[NO_ANOMALIES_DETECTED]
''', 

r'''
稳定 ────── 0.11dB
[█████░░░] 64%

▂▃▅▆▅▃▂▂        ▂

[NO_ANOMALIES_DETECTED]
''',

r'''
稳定 ────── 0.11dB
[█████░░░] 64%

  ▂▃▅▆▅▃▂▂      

[NO_ANOMALIES_DETECTED]
''',

r'''
稳定 ────── 0.11dB
[█████░░░] 64%

    ▂▃█▇▅▃▂▂  

[NO_ANOMALIES_DETECTED]
''',

r'''
稳定 ────── 0.12dB
[█████░░░] 64%

      ▂▃█▇▆▅▃▂   

[NO_ANOMALIES_DETECTED]
''',

r'''
稳定 ────── 0.13dB
[█████░░░] 64%

▅        ▂▃▆▇▆▅▃▂

[NO_ANOMALIES_DETECTED]
'''
];
static const anomalyDetected = [
r'''
  /\    SYS_ERR_018
 < O>   SOURCE: [UNKNOWN]
  \/    SECTOR: EAST
[████████] 100%

[CRITICAL_SYSTEM_OVERRIDE]
''',

r'''
  /\    SYS_ERR_018
 < o>   SOURCE: [UNKNOWN]
  \/    SECTOR: EAST
[████████] 100%

[CRITICAL_SYSTEM_OVERRIDE]
''',

r'''
  /\    SYS_ERR_018
 < ->   SOURCE: [UNKNOWN]
  \/    SECTOR: EAST
[████████] 100%

[CRITICAL_SYSTEM_OVERRIDE]
''',

r'''
  /\    SYS_ERR_018
 <  >   SOURCE: [UNKNOWN]
  \/    SECTOR: EAST
[████████] 99%

[TARGET_LOCK_ESTABLISHED]
''',

r'''
  /\    SYS_ERR_018
 < ->   SOURCE: [UNKNOWN]
  \/    SECTOR: EAST
[████████] @*&$

[TARGET_LOCK_ESTABLISHED]
''',

r'''
  /\    SYS_ERR_018
 < o>   SOURCE: [UNKNOWN]
  \/    SECTOR: EAST
[████████] #%?!

[TARGET_LOCK_ESTABLISHED]
''',

r'''
  /\    SYS_ERR_018
 < O>   SOURCE: [UNKNOWN]
  \/    SECTOR: EAST
[████████] XXXXX

[CRITICAL_SYSTEM_OVERRIDE]
''',

r'''
  /\    SYS_ERR_018
 < o>   SOURCE: [UNKNOWN]
  \/    SECTOR: EAST
[████████] 100%

[CRITICAL_SYSTEM_OVERRIDE]
'''
];


  Timer? timer;

  int frame = 0;

  @override
  void initState() {
    super.initState();

    timer = Timer.periodic(
      const Duration(milliseconds: 300), 
      _updateFrameState
      );
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  void _updateFrameState(_) {
    setState(() {
      frame = (frame + 1) % 8;
    });
  }



  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8),
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.transparent,
        border: BoxBorder.fromLTRB(
          bottom: BorderSide(width: 1.5, color: primaryColor.withValues(alpha: 0.35)),
          right: BorderSide(width: 1.5, color: primaryColor.withValues(alpha: 0.35))
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('SIGNAL_ISOLATION // SECURE',
          style: TextStyle(
              color: primaryColor.withValues(alpha: 0.8),
              shadows: [
                Shadow(
                  color: primaryColor.withValues(alpha: 0.8),
                  blurRadius: 2,
                  offset: Offset(0, 0)
                ),
              ],
            ),
          ),
          SizedBox(height: 8),
          Text(
            noAnomaly[frame],
            style: TextStyle(height: 0, color: primaryColor.withValues(alpha: 0.72)),
          ),
        ],
      ),
    );
  }
}