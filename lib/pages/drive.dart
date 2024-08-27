import 'dart:io';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

class RecordDrive extends StatefulWidget {
  const RecordDrive({super.key});

  @override
  State<RecordDrive> createState() => _RecordDriveState();
}

class _RecordDriveState extends State<RecordDrive> {
  List<FileSystemEntity> _recordings = [];
  final _audioPlayer = AudioPlayer();
  bool _isPlaying = false;
  int playingIndex = -1;

  @override
  void initState() {
    super.initState();
    _fetchRecordings();
  }

  Future<void> _startPlaying(String path) async {
    await _audioPlayer.play(DeviceFileSource(path));

    setState(() {
      _isPlaying = true;
    });

    _audioPlayer.onPlayerComplete.listen((event) {
      setState(() {
        _isPlaying = false;
      });
    });
  }

  Future<void> _stopPlaying() async {
    await _audioPlayer.stop();

    setState(() {
      playingIndex = -1;
      _isPlaying = false;
    });
  }

  Future<void> _fetchRecordings() async {
    Directory appDocDir = await getApplicationDocumentsDirectory();
    List<FileSystemEntity> files = appDocDir.listSync();
    setState(() {
      _recordings = files.where((file) => file.path.endsWith('.wav')).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        itemCount: _recordings.length,
        itemBuilder: (context, index) {
          String fileName = _recordings[index].path.split('/').last;
          return ListTile(
            title: Text(fileName),
            trailing: IconButton(
                icon: playingIndex == index
                    ? const Icon(Icons.pause)
                    : const Icon(Icons.play_arrow),
                onPressed: () {
                  if (!_isPlaying) {
                    _startPlaying(_recordings[index].path);
                    playingIndex = index;
                  } else {
                    _stopPlaying();
                  }
                }),
          );
        },
      ),
    );
  }
}
