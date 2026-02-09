import 'package:injectable/injectable.dart';
import 'package:speech_to_text/speech_to_text.dart';

@lazySingleton
class SpeechService {
  final SpeechToText _speechToText = SpeechToText();
  bool _available = false;

  Future<bool> init() async {
    try {
      _available = await _speechToText.initialize();
    } catch (e) {
      _available = false;
    }
    return _available;
  }

  Future<void> startListening({
    required Function(String) onResult,
    void Function()? onDone,
    Function(String)? onError,
  }) async {
    if (!_available) {
      final initialized = await init();
      if (!initialized) {
        onError?.call('Speech recognition not available or permission denied');
        return;
      }
    }

    try {
      await _speechToText.listen(
        onResult: (result) {
          onResult(result.recognizedWords);
          if (result.finalResult) {
            onDone?.call();
          }
        },
        listenFor: const Duration(seconds: 30),
        pauseFor: const Duration(seconds: 5),
        partialResults: true,
        localeId: 'ru_RU',
        onSoundLevelChange: null,
        cancelOnError: true,
        listenMode: ListenMode.confirmation,
      );
    } catch (e) {
      onError?.call(e.toString());
    }
  }

  Future<void> stopListening() async {
    await _speechToText.stop();
  }
}
