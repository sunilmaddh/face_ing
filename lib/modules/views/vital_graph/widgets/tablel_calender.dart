import 'package:flutter/material.dart';
import 'package:ntt_data/core/constants/app_colors.dart';
import 'package:ntt_data/core/utils/dialog/common_date_picker.dart';
import 'package:table_calendar/table_calendar.dart';

class TableCalendarExample extends StatefulWidget {
  final DateTime firstDate;
  final DateTime lastDate;
  final DateTime initialDate;
  final Function(DateTime selectedDate) onDateSelected;
  final Map<DateTime, List<EventDot>> eventMap;
  final Function(DateTime) onMonthChanged;
  const TableCalendarExample({
    super.key,
    required this.firstDate,
    required this.lastDate,
    required this.initialDate,
    required this.onDateSelected,
    required this.eventMap,
    required this.onMonthChanged,
  });

  @override
  State<TableCalendarExample> createState() => _TableCalendarExampleState();
}

class _TableCalendarExampleState extends State<TableCalendarExample> {
  late DateTime _focusedDay;
  DateTime? _selectedDay;

  @override
  void initState() {
    super.initState();
    _focusedDay = widget.initialDate;
    _selectedDay = widget.initialDate;
  }

  @override
  Widget build(BuildContext context) {
    return TableCalendar(
      firstDay: widget.firstDate,
      lastDay: widget.lastDate,
      focusedDay: _focusedDay,
      eventLoader: (day) {
        DateTime key = DateTime(day.year, day.month, day.day);
        return widget.eventMap[key] ?? [];
      },
      selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
      onDaySelected: (selectedDay, focusedDay) {
        setState(() {
          _selectedDay = selectedDay;
          _focusedDay = focusedDay;
        });
        widget.onDateSelected(selectedDay);
      },

      onPageChanged: (focusedDay) {
        _focusedDay = focusedDay;
        widget.onMonthChanged(focusedDay);
      },

      calendarBuilders: CalendarBuilders(
        markerBuilder: (context, date, events) {
          if (events.isEmpty) return const SizedBox();

          return Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children:
                events
                    .map(
                      (dot) => Container(
                        margin: const EdgeInsets.symmetric(horizontal: 1.5),
                        width: 9,
                        height: 9,
                        decoration: BoxDecoration(
                          color: (dot as EventDot).color,

                          shape: BoxShape.circle,
                        ),
                      ),
                    )
                    .toList(),
          );
        },
      ),

      calendarStyle: CalendarStyle(
        selectedDecoration: BoxDecoration(
          color: AppColors.primary,
          shape: BoxShape.circle,
        ),
        todayDecoration: BoxDecoration(
          color: Colors.orange,
          shape: BoxShape.circle,
        ),
        weekendTextStyle: const TextStyle(color: Colors.black),
        selectedTextStyle: const TextStyle(color: Colors.white),
        outsideDaysVisible: false,
      ),

      headerStyle: const HeaderStyle(
        formatButtonVisible: false,
        titleCentered: true,
        titleTextStyle: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: AppColors.primary,
        ),
        formatButtonTextStyle: TextStyle(color: AppColors.primary),
      ),
    );
  }
}
