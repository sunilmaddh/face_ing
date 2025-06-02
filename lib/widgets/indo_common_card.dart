import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ntt_data/core/constants/app_assets.dart';
import 'package:ntt_data/core/utils/app_dimentions.dart';
import 'package:ntt_data/widgets/cards/common_card.dart';

class IndoCommonCard extends StatefulWidget {
  final String vitalName;
  final String vitalStatus;
  final String vitalValue;
  final String vitalHeading;
  final String vitalDescription;
  final String vitalCondition;
  final String vitalMass;

  const IndoCommonCard({
    Key? key,
    this.vitalName = "",
    this.vitalStatus = "",
    this.vitalValue = "",
    this.vitalHeading = "",
    this.vitalDescription = "",
    this.vitalCondition = "",
    this.vitalMass = "",
  }) : super(key: key);

  @override
  State<IndoCommonCard> createState() => _CommonCardState();
}

class _CommonCardState extends State<IndoCommonCard> {
  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    Color statusColor = const Color(0xFF1BC76D);
    late String imageAsset;
    switch (widget.vitalStatus.toLowerCase()) {
      case 'high':
        imageAsset = AppAssets.highAsset;
        break;
      case 'medium':
        imageAsset = AppAssets.mediumAsset;
        break;
      default:
        imageAsset = AppAssets.lowAsset;
    }

    return CommonCard(
      widget: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: AppDimensions.height(10),
          vertical: AppDimensions.height(10),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                // Left section
                Container(
                  width: 150,
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SvgPicture.asset(imageAsset, width: 37, height: 37),
                      const SizedBox(height: 10),
                      Text(
                        widget.vitalName,
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: Color(0xff575656),
                        ),
                        textAlign: TextAlign.center,
                      ),
                      Text(
                        widget.vitalCondition,
                        style: const TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.w400,
                          color: Color(0xff575656),
                        ),
                      ),
                      RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: widget.vitalValue,
                              style: const TextStyle(
                                fontSize: 26,
                                fontWeight: FontWeight.w400,
                                color: Color(0xff4A4949),
                              ),
                            ),
                            TextSpan(
                              text: widget.vitalMass,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                // Divider
                Container(
                  width: 1,
                  // Adjust height as needed
                  color: const Color(0xffD9D9D9),
                ),

                // Right section
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.vitalHeading,

                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            color: Color(0xff5E5D5D),
                          ),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          widget.vitalDescription,
                          style: const TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                            color: Color(0xff5E5D5D),
                            height: 1.25,
                          ),
                        ),
                        const SizedBox(height: 20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                CircleAvatar(
                                  radius: 10.5,
                                  backgroundColor: statusColor,
                                ),
                                const SizedBox(width: 10),
                                Text(
                                  widget.vitalStatus,
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400,
                                    color: statusColor,
                                  ),
                                ),
                              ],
                            ),
                            SvgPicture.asset(imageAsset, width: 20, height: 20),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.only(right: 15, bottom: 15),
              child: Align(
                alignment: Alignment.topRight,
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      isExpanded = !isExpanded;
                    });
                  },
                  child: SvgPicture.asset(imageAsset, width: 20, height: 20),
                ),
              ),
            ),
            if (isExpanded)
              Container(
                height: 1, // Adjust height as needed
                color: const Color(0xffD9D9D9),
              ),

            if (isExpanded)
              ListView.separated(
                shrinkWrap: true,
                itemCount: 2,
                itemBuilder: (contect, index) {
                  return Padding(
                    padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              widget.vitalCondition,
                              style: const TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.w400,
                                color: Color(0xff575656),
                              ),
                            ),
                            Text(
                              widget.vitalCondition,
                              style: const TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.w400,
                                color: Color(0xff575656),
                              ),
                            ),
                            SvgPicture.asset(imageAsset, width: 20, height: 20),
                          ],
                        ),
                        SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            RichText(
                              text: TextSpan(
                                children: [
                                  TextSpan(
                                    text: widget.vitalValue,
                                    style: const TextStyle(
                                      fontSize: 26,
                                      fontWeight: FontWeight.w400,
                                      color: Color(0xff4A4949),
                                    ),
                                  ),
                                  TextSpan(
                                    text: widget.vitalMass,
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black,
                                    ),
                                  ),
                                ],
                              ),
                            ),

                            SvgPicture.asset(imageAsset, width: 20, height: 20),
                          ],
                        ),
                      ],
                    ),
                  );
                },
                separatorBuilder: (context, index) {
                  return const Divider(
                    color: Colors.grey,
                    thickness: 1,
                    indent: 16,
                    endIndent: 16,
                  );
                },
              ),
          ],
        ),
      ),
    );
  }
}
