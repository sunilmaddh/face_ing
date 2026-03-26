import 'package:flutter/material.dart';
import 'package:ntt_data/modules/voice_agent/model/kintsungi_questionaries_response.dart';
import 'phq_radio_option.dart';

class PhqQuestionCard extends StatelessWidget {
  final int questionNumber;
  final QuestionOfKintsugi question;
  final int? selectedValue;
  final Function(int) onOptionSelected;

  const PhqQuestionCard({
    super.key,
    required this.questionNumber,
    required this.question,
    required this.selectedValue,
    required this.onOptionSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '$questionNumber. ${question.question}',
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: Color(0xFF333333),
          ),
        ),
        const SizedBox(height: 16),
        ...question.options!.map(
          (option) => PhqRadioOption(
            text: option.response!,
            isSelected: selectedValue == option.value,
            onTap: () => onOptionSelected(option.value!),
          ),
        ),
      ],
    );
  }
}
