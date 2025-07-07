class AnalysisResult {
  final int? id;
  final String imagePath;
  final String analysis;
  final DateTime timestamp;

  AnalysisResult({
    this.id,
    required this.imagePath,
    required this.analysis,
    required this.timestamp,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'imagePath': imagePath,
      'analysis': analysis,
      'timestamp': timestamp.toIso8601String(),
    };
  }

  factory AnalysisResult.fromMap(Map<String, dynamic> map) {
    return AnalysisResult(
      id: map['id'],
      imagePath: map['imagePath'],
      analysis: map['analysis'],
      timestamp: DateTime.parse(map['timestamp']),
    );
  }

  AnalysisResult copyWith({
    int? id,
    String? imagePath,
    String? analysis,
    DateTime? timestamp,
  }) {
    return AnalysisResult(
      id: id ?? this.id,
      imagePath: imagePath ?? this.imagePath,
      analysis: analysis ?? this.analysis,
      timestamp: timestamp ?? this.timestamp,
    );
  }
}
