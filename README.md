# Flutter Audio Recorder App

This Flutter app enables users to record audio, save it permanently, and play it back. It displays a list of all saved recordings, allowing playback directly from the list.

## Features

- Record audio using the device's microphone.
- Save recordings permanently in the app's document directory.
- Display a list of saved recordings.
- Play back recordings directly from the list.

## Getting Started

### Prerequisites

- [Flutter SDK](https://flutter.dev/docs/get-started/install)
- [Dart SDK](https://dart.dev/get-dart)
- Compatible IDE: [Android Studio](https://developer.android.com/studio), [Visual Studio Code](https://code.visualstudio.com/)

### Dependencies

This project uses the following dependencies:

```yaml
dependencies:
  flutter:
    sdk: flutter
  record: ^4.5.6
  permission_handler: ^11.2.0
  path_provider: ^2.0.14
  audioplayers: ^1.1.1
  provider: ^6.2.3
```

### Installation

1. **Clone the repository:**

   ```bash
   git clone https://github.com/yourusername/flutter-audio-recorder.git
   cd flutter-audio-recorder
   ```

2. **Install dependencies:**

   ```bash
   flutter pub get
   ```

3. **Run the app:**

   ```bash
   flutter run
   ```

### Project Structure

```
lib/
├── main.dart            # Main entry point of the application
├── pages/               # Contains all the pages/screens of the app
├── utils/               # Contains utility functions and classes
├── widgets/             # Contains reusable widgets
├── providers/           # Contains state management providers
```

### Usage

1. Tap the microphone icon to start recording.
2. Tap the stop icon to stop the recording.
3. Scroll through the list to see all saved recordings.
4. Tap a recording in the list to start playing it.

### Permissions

This app requires the following permissions:

- **Microphone:** To record audio.
- **Storage:** To save and retrieve audio files.
