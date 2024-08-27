import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:recording/provider/player_provider.dart';
import 'package:recording/widgets/audio_player.dart';


class RecordDrive extends StatefulWidget {
  const RecordDrive({super.key});

  @override
  State<RecordDrive> createState() => _RecordDriveState();
}

class _RecordDriveState extends State<RecordDrive> {
  @override
  void initState() {
    super.initState();
    _fetchRecordings();
  }

  Future<void> _fetchRecordings() async {
    Directory appDocDir = await getApplicationDocumentsDirectory();
    List<FileSystemEntity> files = appDocDir.listSync();

    final recordings = files
        .where((file) => file.path.endsWith('.wav'))
        .map((file) => file.path)
        .toList();

    final playerProvider = Provider.of<PlayerProvider>(context, listen: false);
    playerProvider.recordings = recordings;
    playerProvider.startPlaying(recordings.isNotEmpty ? recordings[0] : '');
  }

  @override
  Widget build(BuildContext context) {
    final playerProvider = Provider.of<PlayerProvider>(context);

    return Column(
      children: [
        if (playerProvider.recordings.isNotEmpty)
          AudioPlayerWidget(
            audioPlayer: playerProvider.audioPlayer,
            recordings: playerProvider.recordings,
            initialIndex: playerProvider.playingIndex,
          ),
        Expanded(
          child: ListView.builder(
            itemCount: playerProvider.recordings.length,
            itemBuilder: (context, index) {
              String fileName =
                  playerProvider.recordings[index].split('/').last;
              return Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  elevation: 3,
                  child: ListTile(
                    title: Text(fileName),
                    onTap: () {
                      setState(() {
                        playerProvider.setPlayingIndex(index);
                        playerProvider
                            .startPlaying(playerProvider.recordings[index]);
                      });
                    },
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
