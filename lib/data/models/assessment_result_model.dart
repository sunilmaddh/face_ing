class AssessmentResultModel {
  final String predictedScoreDepression;
  final String predictedScoreAnxiety;
  final String? actualScore;
  final String createdAt;

  AssessmentResultModel({
    required this.predictedScoreDepression,
    required this.predictedScoreAnxiety,
    this.actualScore,
    required this.createdAt,
  });

  factory AssessmentResultModel.fromJson(Map<String, dynamic> json) {
    final result = json['result'];
    return AssessmentResultModel(
      predictedScoreDepression: result['predictedScoreDepression'] ?? '',
      predictedScoreAnxiety: result['predictedScoreAnxiety'] ?? '',
      actualScore: result['actualScore'],
      createdAt: result['createdAt'] ?? '',
    );
  }
}
