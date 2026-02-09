import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import '../constants/secrets.dart';

@lazySingleton
class OpenAIService {
  final Dio _dio;

  OpenAIService(this._dio);

  Future<String> improveProductDescription(String input) async {
    try {
      final response = await _dio.post(
        'https://api.openai.com/v1/chat/completions',
        options: Options(
          headers: {
            'Authorization': 'Bearer ${Secrets.openAiApiKey}',
            'Content-Type': 'application/json',
          },
        ),
        data: {
          'model': 'gpt-3.5-turbo',
          'messages': [
            {
              'role': 'system',
              'content':
                  'You are a helpful assistant for a furniture CRM. Correct spelling and improve the description of furniture items in Russian.',
            },
            {'role': 'user', 'content': input},
          ],
        },
      );

      if (response.statusCode == 200) {
        return response.data['choices'][0]['message']['content'];
      }
      return input;
    } catch (e) {
      // Handle error
      return input;
    }
  }
}
