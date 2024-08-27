import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';

class PlayerProvider extends ChangeNotifier {
  final AudioPlayer _audioPlayer = AudioPlayer();
  bool _isPlaying = false;
  int _playingIndex = 0;
  Duration _currentPosition = Duration.zero;
  Duration _totalDuration = Duration.zero;
  double _volume = 1.0;

  List<String> _recordings = [];

  PlayerProvider() {
    _audioPlayer.onPositionChanged.listen((duration) {
      _currentPosition = duration;
      notifyListeners();
    });

    _audioPlayer.onDurationChanged.listen((duration) {
      _totalDuration = duration;
      notifyListeners();
    });

    _audioPlayer.onPlayerComplete.listen((event) {
      _isPlaying = false;
      _currentPosition = Duration.zero;
      notifyListeners();
      playNext();
    });
  }

  List<String> get recordings => _recordings;
  bool get isPlaying => _isPlaying;
  int get playingIndex => _playingIndex;
  Duration get currentPosition => _currentPosition;
  Duration get totalDuration => _totalDuration;
  double get volume => _volume;
  AudioPlayer get audioPlayer => _audioPlayer;

  set recordings(List<String> value) {
    _recordings = value;
    notifyListeners();
  }

  void setPlayingIndex(int index) {
    _playingIndex = index;
  }

  Future<void> startPlaying(String path) async {
    await _audioPlayer.play(DeviceFileSource(path), volume: _volume);
    _isPlaying = true;
    notifyListeners();
  }

  Future<void> stopPlaying() async {
    await _audioPlayer.stop();
    _isPlaying = false;
    _currentPosition = Duration.zero;
    notifyListeners();
  }

  void playNext() {
    if (_playingIndex < _recordings.length - 1) {
      _playingIndex++;
      startPlaying(_recordings[_playingIndex]);
    }
  }

  void playPrevious() {
    if (_playingIndex > 0) {
      _playingIndex--;
      startPlaying(_recordings[_playingIndex]);
    }
  }

  void seek(Duration position) async {
    await _audioPlayer.seek(position);
    _currentPosition = position;
    notifyListeners();
  }

  void setVolume(double volume) {
    _volume = volume;
    _audioPlayer.setVolume(volume);
    notifyListeners();
  }

  String formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final minutes = twoDigits(duration.inMinutes.remainder(60));
    final seconds = twoDigits(duration.inSeconds.remainder(60));
    return "$minutes:$seconds";
  }
}
