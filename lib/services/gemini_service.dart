import 'dart:io';
import 'package:google_generative_ai/google_generative_ai.dart';

class GeminiService {
  static const String _basePrompt = '''
  Bu görüntüyü analiz et ve mystik bir şekilde yorumla. Sonuçlarını Türkçe olarak ver.
  
  Lütfen:
  - Görüntüdeki unsurları mistik bir perspektifle yorumla
  - Renklerin, şekillerin ve kompozisyonun anlamını açıkla
  - Olumlu ve ilham verici bir dil kullan
  - Kaba, uygunsuz veya zararlı içerik üretme
  - Yanıtını 200-300 kelime arasında tut
  - Analizi şiirsel ve büyülü bir üslupla sun
  ''';

  static GenerativeModel? _model;

  static void initialize(String apiKey) {
    _model = GenerativeModel(
      model: 'gemini-2.0-flash',
      apiKey: apiKey,
    );
  }

  static Future<String> analyzeImage(File imageFile) async {
    if (_model == null) {
      throw Exception(
          'Gemini service is not initialized. Please provide API key.');
    }

    try {
      final imageBytes = await imageFile.readAsBytes();
      final image = DataPart('image/jpeg', imageBytes);

      final prompt = TextPart(_basePrompt);

      // Gemini 2.0 Flash enhanced configuration
      final response = await _model!.generateContent(
        [
          Content.multi([prompt, image])
        ],
        generationConfig: GenerationConfig(
          temperature: 0.7,
          topP: 0.9,
          topK: 40,
          maxOutputTokens: 500,
        ),
      );

      final text = response.text;
      if (text == null || text.isEmpty) {
        throw Exception('Görüntü analizi yapılamadı. Lütfen tekrar deneyin.');
      }

      // Content filtering - basic inappropriate content check
      if (_containsInappropriateContent(text)) {
        return 'Bu görüntü için uygun bir analiz üretilemedi. Lütfen farklı bir görüntü deneyin.';
      }

      return text;
    } catch (e) {
      throw Exception('Görüntü analizi sırasında hata oluştu: ${e.toString()}');
    }
  }

  static bool _containsInappropriateContent(String text) {
    final inappropriateWords = [
      'küfür', 'hakaret', 'şiddet', 'uygunsuz', 'zararlı',
      // Add more inappropriate words as needed
    ];

    final lowerText = text.toLowerCase();
    return inappropriateWords.any((word) => lowerText.contains(word));
  }
}
