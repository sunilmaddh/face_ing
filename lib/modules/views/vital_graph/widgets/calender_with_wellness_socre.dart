import 'package:flutter/material.dart';
import 'package:ntt_data/core/utils/dialog/common_date_picker.dart';

class FlutterBuiltInCalendar extends StatefulWidget {
  final Map<DateTime, List<EventDot>> eventMap;

  const FlutterBuiltInCalendar({super.key, required this.eventMap});

  @override
  State<FlutterBuiltInCalendar> createState() => _FlutterBuiltInCalendarState();
}

class _FlutterBuiltInCalendarState extends State<FlutterBuiltInCalendar> {
  DateTime selectedDate = DateTime.now();
  DateTime displayedMonth = DateTime(DateTime.now().year, DateTime.now().month);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        /// Flutter's built-in calendar
        CalendarDatePicker(
          initialDate: selectedDate,
          firstDate: DateTime(2020),
          lastDate: DateTime(2030),
          onDateChanged: (date) {
            setState(() => selectedDate = date);
          },
          onDisplayedMonthChanged: (month) {
            setState(() => displayedMonth = DateTime(month.year, month.month));
          },
        ),

        /// Overlay dots on each date cell
        Positioned.fill(
          child: IgnorePointer(child: _buildDotOverlay(displayedMonth)),
        ),
      ],
    );
  }

  /// Create a grid matching the built-in calendar layout and attach dots
  Widget _buildDotOverlay(DateTime month) {
    int days = DateUtils.getDaysInMonth(month.year, month.month);
    DateTime firstDay = DateTime(month.year, month.month, 1);

    int startWeekday = firstDay.weekday % 7; // 0 = Sunday layout

    int totalGridCells = startWeekday + days;

    return GridView.builder(
      padding: const EdgeInsets.only(top: 50),
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 7,
      ),
      itemCount: totalGridCells,
      itemBuilder: (context, index) {
        if (index < startWeekday) {
          return const SizedBox(); // empty cell before 1st day
        }

        int dayNumber = index - startWeekday + 1;
        DateTime date = DateTime(month.year, month.month, dayNumber);

        List<EventDot>? dots = widget.eventMap[date];

        return Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            if (dots != null)
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children:
                    dots.map((dot) {
                      return Container(
                        margin: const EdgeInsets.symmetric(horizontal: 1.5),
                        width: 7,
                        height: 7,
                        decoration: BoxDecoration(
                          color: dot.color,
                          shape: BoxShape.circle,
                        ),
                      );
                    }).toList(),
              ),
          ],
        );
      },
    );
  }
}
