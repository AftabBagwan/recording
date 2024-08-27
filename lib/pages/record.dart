import 'dart:async';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:record/record.dart';
import 'package:recording/utils/colors.dart';
import 'package:recording/widgets/time_column.dart';

class Record extends StatefulWidget {
  const Record({super.key});

  @override
  State<Record> createState() => _RecordState();
}

class _RecordState extends State<Record> {
  late final AudioRecorder _recorder;
  bool isRecording = false;
  Timer? _timer;
  int _seconds = 0;

  @override
  void initState() {
    super.initState();
    _recorder = AudioRecorder();
  }

  @override
  void dispose() {
    _recorder.dispose();
    _timer?.cancel();
    super.dispose();
  }

  Future<void> startRecording() async {
    String path = await getApplicationDocumentsDirectory().then((value) =>
        "${value.path}/${DateTime.now().microsecondsSinceEpoch}.wav");
    debugPrint("recording path $path");
    startTimer();

    await _recorder.start(
      const RecordConfig(encoder: AudioEncoder.wav),
      path: path,
    );
  }

  String getFormattedTime(int value) {
    return value.toString().padLeft(2, '0');
  }

  Future<void> stopRecording() async {
    _timer?.cancel();
    await _recorder.stop();
  }

  void record() async {
    if (isRecording == false) {
      final status = await Permission.microphone.request();

      if (status == PermissionStatus.granted) {
        setState(() {
          isRecording = true;
        });
        await startRecording();
      } else if (status == PermissionStatus.permanentlyDenied) {
        debugPrint('Permission permanently denied');
      }
    } else {
      await stopRecording();

      setState(() {
        isRecording = false;
      });
    }
  }

  void startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        _seconds++;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    int hours = _seconds ~/ 3600;
    int minutes = (_seconds % 3600) ~/ 60;
    int seconds = _seconds % 60;
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TimeColumn(label: getFormattedTime(hours), time: 'h'),
            TimeColumn(label: getFormattedTime(minutes), time: 'm'),
            TimeColumn(label: getFormattedTime(seconds), time: 's'),
          ],
        ),
        const Text(
          "Press the button to record",
          style: TextStyle(fontSize: 16),
        ),
        const SizedBox(
          height: 20,
        ),
        Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: AppColors.red,
          ),
          child: IconButton(
            icon: Icon(
              isRecording ? Icons.stop : Icons.mic,
              size: 44,
              color: AppColors.white,
            ),
            onPressed: () {
              record();
            },
          ),
        ),
      ],
    );
  }
}
