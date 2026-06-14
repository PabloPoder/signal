import 'package:signal/features/anomalies/models/anomaly_template.dart';
import 'package:signal/features/anomaly_outcomes/models/entry_seed.dart';

Map<AnomalyMood, List<EntrySeed>> entriesCatalog = {
  AnomalyMood.ghost: [
    EntrySeed(
      title: 'LIVE_COMMS // CHANNEL_07',
      rawContent: '''
--- TRANSMISSION START ---

[22:41:08] OPERATOR: Control, I'm receiving a secondary transmission.
[22:41:12] CONTROL: Negative. Channel 07 is reserved for your uplink only.
[22:41:19] UNKNOWN: I can hear you.
[22:41:25] OPERATOR: ...Control, did you say that?
[22:41:31] CONTROL: Say what?
[22:41:40] UNKNOWN: Don't turn around.

--- SIGNAL LOST ---
''',
    ),
    EntrySeed(
      title: 'RELAY_TRANSCRIPT // CHANNEL_03',
      rawContent: '''
[03:12:01] OPERATOR: Relay station, respond.
[03:12:07] UNKNOWN: I am responding.
[03:12:14] OPERATOR: State your operator ID.
[03:12:21] UNKNOWN: State your operator ID.
[03:12:29] OPERATOR: That's not funny.
[03:12:36] UNKNOWN: That's not funny.
[03:12:47] OPERATOR: ...Who are you?
[03:12:59] UNKNOWN: Operator #12.

No operator #12 has ever been assigned to Relay Station 03.
''',
    ),
    EntrySeed(
      title: 'MAIL_RECOVERY // RELAY_04',
      rawContent: '''
TO: Maintenance Team
FROM: Operator #12

If this message reaches anyone,
please disconnect the relay.

The station answers back.

I don't think it's our signal anymore.''',
    ),
    EntrySeed(
      title: 'AUDIO_TRX // VOICE_LOG_03',
      rawContent: '''
VOICE_LOG // STATION_04

[03:12:01] OPERATOR: I can hear someone breathing.
[03:12:10] CONTROL:  You're alone on that station.
[03:12:18] OPERATOR: Then who just said my name?''',
    ),
    EntrySeed(
      title: 'CONFIG_ORPHAN // NULL_USER',
      rawContent: '''
[REMOTE_SESSION]
operator_id=UNKNOWN
status=DISCONNECTED
session_age=1095_days
telemetry_target=THIS_TERMINAL''',
    ),
  ],

  AnomalyMood.cosmic: [
    EntrySeed(
      title: 'LIVE_COMMS // CHANNEL_07',
      rawContent: '''
--- TRANSMISSION START ---

[22:41:08] OPERATOR: Control, I'm receiving a secondary transmission.
[22:41:12] CONTROL: Negative. Channel 07 is reserved for your uplink only.
[22:41:19] UNKNOWN: I can hear you.
[22:41:25] OPERATOR: ...Control, did you say that?
[22:41:31] CONTROL: Say what?
[22:41:40] UNKNOWN: Don't turn around.

--- SIGNAL LOST ---
''',
    ),
    EntrySeed(
      title: 'RX_COORDINATES // UNKNOWN',
      rawContent: '''
COORDINATE SEARCH:
X: 1842  |  Y: -981  |  Z: 041

SIGNAL_STRENGTH: 97%
KNOWN_OBJECT:    NONE
CLASSIFICATION:  SILENT_BODY''',
    ),
    EntrySeed(
      title: 'SPECTRAL_ANALYSIS // WAVE',
      rawContent: '''
RAW WAVELENGTH:
██░░██░█████░██
██░██░░██░░██░░
█████░██░░░░██░

Pattern repeats every 41.50 seconds.''',
    ),
    EntrySeed(
      title: 'OBSERVATION_LOG // PULSE',
      rawContent: '''
TIME-SERIES DATA:
14:20 — pulse detected
15:01 — pulse repeated
15:42 — pulse repeated
16:23 — pulse repeated

No natural source matches this periodicity.''',
    ),
  ],

  AnomalyMood.temporal: [
    EntrySeed(
      title: 'PARADOX // TIME_DRIFT',
      rawContent: '''
FILE_CREATED: 2084-11-16
CURRENT_DATE: 2026-06-13

Operator,

You are opening this file too early.
Do not intercept the next ping.''',
    ),
    EntrySeed(
      title: 'DUP_ENTRY_FAIL // 4812',
      rawContent: '''
ENTRY_ID: 4812

This file already exists.
This file already exists.
This file already exists.
This file already exists.''',
    ),
    EntrySeed(
      title: 'INVERTED_LOG // SHUTDOWN',
      rawContent: '''
CRITICAL CHRONO LOG:
[SHUTDOWN_SEQUENCE_COMPLETE]
[WARNING: CORE LOSS]
[BOOT_SEQUENCE_INITIATED]
[POWER_ON: USER_LOGIN]''',
    ),
  ],

  AnomalyMood.system: [
    EntrySeed(
      title: 'HEX_DUMP // KERNEL_PANIC',
      rawContent: '''
MEMORY_ADDR: 0x004F
0x53 0x59 0x53 0x20 0x45 0x52 0x52
0x45 0x52 0x52 0x4F 0x52 0x20 0x30
0x30 0x31 0x38 0x20 0x4E 0x55 0x4C''',
    ),
    EntrySeed(
      title: 'STACK_TRACE // INFINITE',
      rawContent: '''
StackTrace (Thread 0x04):
#00 TerminalRenderer.draw()
#01 TerminalRenderer.draw()
#02 TerminalRenderer.draw()
#03 TerminalRenderer.draw()
... [RECURSION_LIMIT_EXCEEDED]''',
    ),
    EntrySeed(
      title: 'SYSTEM_INI // BLOCKED',
      rawContent: '''
[terminal]
status=critical

[cache]
corrupted=true

[user]
active=NULL''',
    ),
  ],

  AnomalyMood.decay: [
    EntrySeed(
      title: 'INCOMPLETE_SECTOR // ROT',
      rawContent: '''
The magnetic storage array has suffe...
The drive can no longer res...
Information integri...
Core system is dy...''',
    ),
    EntrySeed(
      title: 'BIT_ROT // SCATTERED',
      rawContent: '''
SIG_AL DE_AY O_SERVAT_ON

Mic_o-ste_la_ no_se h_s infiltra_ed
The core data is va_ishi_g''',
    ),
    EntrySeed(
      title: 'ISOLATED_WORDS // LEAK',
      rawContent: '''
memory
sector
dust
recover
forget
recover
forget
forget''',
    ),
  ],
  AnomalyMood.hostile: [
    EntrySeed(
      title: 'CRITICAL_ALERT // CORE_EMERG',
      rawContent: '''
!!! WARNING !!!

CORE TEMPERATURE EXCEEDED
HARDWARE INTEGRITY AT 12%

IMMEDIATE TERMINATION ADVISED''',
    ),
    EntrySeed(
      title: 'KERNEL_HALT // REJECTED',
      rawContent: '''
STOP WRITING
STOP WRITING
STOP WRITING
STOP WRITING
STOP WRITING''',
    ),
    EntrySeed(
      title: 'OVERWRITE_BLOCK // ANOM',
      rawContent: '''
####################################

UNAUTHORIZED PROCESS DETECTED
SESSION TERMINATED BY FORCE

####################################''',
    ),
  ],
};
