class MedicalQuestionAnswerRequest {
  final String id;
  final String question;
  final List<dynamic> answer;

  const MedicalQuestionAnswerRequest({
    required this.id,
    required this.question,
    required this.answer,
  });

  Map<String, dynamic> toJson() {
    return {"id": id, "question": question, "answer": answer};
  }
}
