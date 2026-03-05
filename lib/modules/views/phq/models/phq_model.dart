class PhqOption {
  final int value;
  final String response;

  PhqOption({required this.value, required this.response});
}

class PhqQuestion {
  final String question;
  final List<PhqOption> options;

  PhqQuestion({required this.question, required this.options});
}

class PhqAssessment {
  final String type;
  final List<PhqQuestion> questions;

  PhqAssessment({required this.type, required this.questions});
}
