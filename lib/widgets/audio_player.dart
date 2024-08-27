import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:recording/provider/player_provider.dart';
import 'package:recording/utils/colors.dart';

class AudioPlayerWidget extends StatelessWidget {
  final AudioPlayer audioPlayer;
  final List<String> recordings;
  final int initialIndex;

  const AudioPlayerWidget({
    super.key,
    required this.audioPlayer,
    required this.recordings,
    required this.initialIndex,
  });

  @override
  Widget build(BuildContext context) {
    final playerProvider = Provider.of<PlayerProvider>(context);

    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: AppColors.red,
        borderRadius: const BorderRadius.only(
            bottomLeft: Radius.circular(20), bottomRight: Radius.circular(20)),
      ),
      child: Column(
        children: [
          Row(
            children: [
              IconButton(
                icon: const Icon(Icons.skip_previous),
                onPressed: playerProvider.playingIndex > 0
                    ? playerProvider.playPrevious
                    : null,
              ),
              IconButton(
                icon: playerProvider.isPlaying
                    ? const Icon(Icons.pause)
                    : const Icon(Icons.play_arrow),
                onPressed: () {
                  if (playerProvider.isPlaying) {
                    playerProvider.stopPlaying();
                  } else if (playerProvider.playingIndex >= 0) {
                    playerProvider.startPlaying(
                        playerProvider.recordings[playerProvider.playingIndex]);
                  }
                },
              ),
              IconButton(
                icon: const Icon(Icons.skip_next),
                onPressed: playerProvider.playingIndex <
                        playerProvider.recordings.length - 1
                    ? playerProvider.playNext
                    : null,
              ),
              Row(
                children: [
                  const Icon(Icons.volume_down),
                  SizedBox(
                    width: 100,
                    child: Slider(
                      value: playerProvider.volume,
                      min: 0.0,
                      max: 1.0,
                      onChanged: playerProvider.setVolume,
                    ),
                  ),
                  const Icon(Icons.volume_up),
                ],
              ),
            ],
          ),
          Row(
            children: [
              Text(playerProvider
                  .formatDuration(playerProvider.currentPosition)),
              Expanded(
                child: Slider(
                  value: playerProvider.currentPosition.inSeconds.toDouble(),
                  max: playerProvider.totalDuration.inSeconds.toDouble(),
                  onChanged: (value) {
                    playerProvider.seek(Duration(seconds: value.toInt()));
                  },
                ),
              ),
              Text(playerProvider.formatDuration(playerProvider.totalDuration)),
            ],
          ),
        ],
      ),
    );
  }
}
