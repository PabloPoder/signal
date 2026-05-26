// import 'dart:math';

// import 'package:media_kit/media_kit.dart';
// import 'package:signal/core/audio/audio_assets.dart';

// enum AudioType {
//   keyPress,
//   enter,
//   warning,
// }

// class AudioService {
//   AudioService._();

//   static final instance = AudioService._();

//   final _random = Random();

//   bool enabled = true;

//   late final Player _player;

//   final List<String> _keySounds = [
//     AudioAssets.key1,
//     AudioAssets.key2,
//     AudioAssets.key3,
//     AudioAssets.key4,
//     AudioAssets.key5,
//   ];

//   Future<void> init() async {
//     _player = Player();
//   }

//   Future<void> play(AudioType type) async {
//     if (!enabled) return;

//     switch (type) {
//       case AudioType.keyPress:
//         await _playRandomKey();
//         break;

//       case AudioType.enter:
//         await _playAsset(AudioAssets.enter);
//         break;

//       case AudioType.warning:
//         break;
//     }
//   }

//   Future<void> _playRandomKey() async {
//     final sound = _keySounds[
//       _random.nextInt(_keySounds.length)
//     ];

//     await _playAsset(sound);
//   }

//   Future<void> _playAsset(String path) async {
//     await _player.open(
//       Media(
//         'asset://assets/$path',
//       ),
//       play: true,
//     );
//   }
// }