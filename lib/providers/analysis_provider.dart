import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:image_picker/image_picker.dart';
import '../models/analysis_result.dart';
import '../services/database_service.dart';
import '../services/gemini_service.dart';

class AnalysisProvider extends ChangeNotifier {
  final ImagePicker _picker = ImagePicker();
  final DatabaseService _databaseService = DatabaseService.instance;

  List<AnalysisResult> _results = [];
  bool _isLoading = false;
  String? _error;
  bool _analysisSuccess = false;
  AnalysisResult? _lastAnalysis;

  List<AnalysisResult> get results => _results;
  bool get isLoading => _isLoading;
  String? get error => _error;
  bool get analysisSuccess => _analysisSuccess;
  AnalysisResult? get lastAnalysis => _lastAnalysis;

  Future<void> loadResults() async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      _results = await _databaseService.getAllAnalysisResults();
    } catch (e) {
      _error = 'Sonuçlar yüklenirken hata oluştu: ${e.toString()}';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> pickAndAnalyzeImage() async {
    _isLoading = true;
    _error = null;
    _analysisSuccess = false;
    notifyListeners();

    try {
      final XFile? image = await _picker.pickImage(
        source: ImageSource.gallery,
        maxWidth: 1024,
        maxHeight: 1024,
        imageQuality: 80,
      );

      if (image == null) {
        _isLoading = false;
        notifyListeners();
        return;
      }

      final File imageFile = File(image.path);
      final String analysis = await GeminiService.analyzeImage(imageFile);

      final AnalysisResult result = AnalysisResult(
        imagePath: image.path,
        analysis: analysis,
        timestamp: DateTime.now(),
      );

      final int id = await _databaseService.insertAnalysisResult(result);
      final AnalysisResult resultWithId = result.copyWith(id: id);

      _results.insert(0, resultWithId);
      _lastAnalysis = resultWithId;
      _analysisSuccess = true;
    } catch (e) {
      _error = 'Görüntü analizi sırasında hata oluştu: ${e.toString()}';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> deleteResult(int id) async {
    try {
      await _databaseService.deleteAnalysisResult(id);
      _results.removeWhere((result) => result.id == id);
      notifyListeners();
    } catch (e) {
      _error = 'Sonuç silinirken hata oluştu: ${e.toString()}';
      notifyListeners();
    }
  }

  Future<void> clearAllResults() async {
    try {
      await _databaseService.deleteAllAnalysisResults();
      _results.clear();
      notifyListeners();
    } catch (e) {
      _error = 'Sonuçlar temizlenirken hata oluştu: ${e.toString()}';
      notifyListeners();
    }
  }

  void clearError() {
    _error = null;
    notifyListeners();
  }

  void clearSuccess() {
    _analysisSuccess = false;
    _lastAnalysis = null;
    notifyListeners();
  }
}
