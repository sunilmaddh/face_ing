class PulseSurveyAnswerRequest {
  final String questionId;
  final String pulseSurveyQuestion;
  final String answer;

  const PulseSurveyAnswerRequest({
    required this.questionId,
    required this.pulseSurveyQuestion,
    required this.answer,
  });

  Map<String, dynamic> toJson() {
    return {
      "questionId": questionId,
      "pulseSurveyQuestion": pulseSurveyQuestion,
      "answer": answer,
    };
  }

  factory PulseSurveyAnswerRequest.fromJson(Map<String, dynamic> json) {
    return PulseSurveyAnswerRequest(
      questionId: json["questionId"]?.toString() ?? '',
      pulseSurveyQuestion: json["pulseSurveyQuestion"]?.toString() ?? '',
      answer: json["answer"]?.toString() ?? '',
    );
  }

  PulseSurveyAnswerRequest copyWith({
    String? questionId,
    String? pulseSurveyQuestion,
    String? answer,
  }) {
    return PulseSurveyAnswerRequest(
      questionId: questionId ?? this.questionId,
      pulseSurveyQuestion: pulseSurveyQuestion ?? this.pulseSurveyQuestion,
      answer: answer ?? this.answer,
    );
  }
}
