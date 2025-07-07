class ApiConfig {
  // Gemini API key
  static const String geminiApiKey = 'AIzaSyDEwB934UnJVFbfTi8g0JR-7iznBaUY1Og';

  // You can initialize the API key from environment variables or secure storage
  static String getGeminiApiKey() {
    // For production, consider using flutter_dotenv or secure storage
    // For now, return the constant
    return geminiApiKey;
  }
}
