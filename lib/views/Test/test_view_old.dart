// import 'package:flutter/material.dart';
// import 'package:flutter_sound/flutter_sound.dart';
// import 'dart:async';
// // import 'package:tflite/tflite.dart';
// import 'package:tflite_audio/tflite_audio.dart';

// class TestView extends StatefulWidget {
//   const TestView({Key? key, required this.word, required this.file})
//       : super(key: key);
//   final String word;
//   final String file;
//   @override
//   State<TestView> createState() => _TestViewState();
// }

// class _TestViewState extends State<TestView> {
//   // final _exampleAudioFilePathMP3 =
//   //     'https://file-examples-com.github.io/uploads/2017/11/file_example_MP3_700KB.mp3';
//   FlutterSoundPlayer? _mPlayer = FlutterSoundPlayer();
//   bool _mPlayerIsInited = false;
//   String _sound = "Press the button to start";
//   bool _recording = false;
//   Stream<Map<dynamic, dynamic>>? result;
//   @override
//   void initState() {
//     super.initState();
//     TfliteAudio.loadModel(
//       model: 'assets/tfmodel.tflite',
//       label: 'assets/labels.txt',
//       numThreads: 1,
//       isAsset: true,
//       inputType: 'decodedWav',
//     );
//     _mPlayer!.openPlayer().then((value) {
//       setState(() {
//         _mPlayerIsInited = true;
//       });
//     });
//   }

//   void _recorder() {
//     String recognition = "";
//     if (!_recording) {
//       setState(() => _recording = true);
//       result = TfliteAudio.startAudioRecognition(
//         numOfInferences: 1,
//         // inputType: 'rawAudio',
//         sampleRate: 44100,
//         // recordingLength: 44032,
//         bufferSize: 22016,
//       );
//       result?.listen((event) {
//         recognition = event["recognitionResult"];
//       }).onDone(() {
//         setState(() {
//           _recording = false;
//           _sound = recognition.split(" ")[1];
//         });
//       });
//     }
//   }

//   void _stop() {
//     TfliteAudio.stopAudioRecognition();
//     setState(() => _recording = false);
//   }

//   @override
//   void dispose() {
//     stopPlayer();
//     // Be careful : you must `close` the audio session when you have finished with it.
//     _mPlayer!.closePlayer();
//     _mPlayer = null;

//     super.dispose();
//   }

//   // -------  Here is the code to playback a remote file -----------------------

//   void play() async {
//     await _mPlayer!.startPlayer(
//         fromURI: widget.file,
//         codec: Codec.mp3,
//         whenFinished: () {
//           setState(() {});
//         });
//     setState(() {});
//   }

//   Future<void> stopPlayer() async {
//     if (_mPlayer != null) {
//       await _mPlayer!.stopPlayer();
//     }
//   }

//   // --------------------- UI -------------------

//   getPlaybackFn() {
//     if (!_mPlayerIsInited) {
//       return null;
//     }
//     return _mPlayer!.isStopped
//         ? play
//         : () {
//             stopPlayer().then((value) => setState(() {}));
//           };
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Test'),
//       ),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Image.asset('assets/lesson1/${widget.word}.png'),
//             const SizedBox(height: 15),
//             Container(
//               margin: const EdgeInsets.symmetric(horizontal: 10),
//               padding: const EdgeInsets.all(10),
//               height: 60,
//               width: double.infinity,
//               alignment: Alignment.center,
//               decoration: BoxDecoration(
//                 borderRadius: BorderRadius.circular(10),
//                 color: const Color(0xFFFAF0E6),
//                 border: Border.all(
//                   color: Colors.indigo,
//                   width: 3,
//                 ),
//               ),
//               child: Row(
//                 children: [
//                   ElevatedButton(
//                     onPressed: getPlaybackFn(),
//                     child: Text(_mPlayer!.isPlaying ? 'Stop' : 'Play'),
//                   ),
//                   const SizedBox(
//                     width: 20,
//                   ),
//                   Text(_mPlayer!.isPlaying ? 'Playing' : 'Click on Play'),
//                 ],
//               ),
//             ),
//             const SizedBox(height: 20),
//             MaterialButton(
//               height: 80,
//               color: Colors.grey[200],
//               shape: const CircleBorder(),
//               onPressed: () {},
//               child: const Icon(
//                 Icons.mic,
//                 size: 50,
//               ),
//             ),
//             const Divider(),
//             MaterialButton(
//               onPressed: _recorder,
//               color: _recording ? Colors.grey : Colors.pink,
//               textColor: Colors.white,
//               child: Icon(Icons.mic, size: 60),
//               shape: CircleBorder(),
//               padding: EdgeInsets.all(25),
//             ),
//             Text(
//               '$_sound',
//               style: Theme.of(context).textTheme.headline5,
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
