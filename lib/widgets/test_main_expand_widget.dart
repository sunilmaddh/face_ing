import 'package:flutter/material.dart';

class StressInfoCard extends StatelessWidget {
  final String vitalName;
  final bool isExpanded;
  final String titleText;
  final String statusText;
  final String valueText;
  final String unitText;

  const StressInfoCard({
    Key? key,
    required this.vitalName,
    required this.isExpanded,
    required this.titleText,
    required this.statusText,
    required this.valueText,
    required this.unitText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Divider(height: 1, color: Color(0xffD9D9D9)),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    titleText,
                    style: const TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.w400,
                      color: Color(0xff575656),
                    ),
                  ),
                  Text(
                    statusText,
                    style: const TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.w400,
                      color: Color(0xff575656),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: valueText,
                          style: const TextStyle(
                            fontSize: 26,
                            fontWeight: FontWeight.w400,
                            color: Color(0xff4A4949),
                          ),
                        ),
                        TextSpan(
                          text: unitText,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Icon(Icons.info_rounded),
                ],
              ),
            ],
          ),
        ),
        // const Divider(
        //   color: Colors.grey,
        //   thickness: 1,
        //   indent: 16,
        //   endIndent: 16,
        // ),
      ],
    );
  }
}
