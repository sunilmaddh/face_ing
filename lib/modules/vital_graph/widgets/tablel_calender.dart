import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:ntt_data/core/utils/dialog/common_date_picker.dart';
import 'package:table_calendar/table_calendar.dart';

/// Full working TableCalendar with Tap-Year → Month/Year Picker
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

  /// ✅ FIXED CLAMP (correct)
  DateTime clampDate(DateTime d) {
    if (d.isBefore(widget.firstDate)) return widget.firstDate;
    if (d.isAfter(widget.lastDate)) return widget.lastDate;
    return d;
  }

  void _openMonthYearPicker(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) {
        return MonthYearPickerDialog(
          initialDate: _focusedDay,
          firstDate: widget.firstDate,
          lastDate: widget.lastDate,
          onMonthYearSelected: (pickedDate) {
            final clamped = clampDate(pickedDate);

            setState(() => _focusedDay = clamped);

            widget.onMonthChanged(clamped);
          },
        );
      },
    );
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
          _focusedDay = clampDate(focusedDay);
        });
        widget.onDateSelected(selectedDay);
      },

      onPageChanged: (focusedDay) {
        setState(() => _focusedDay = clampDate(focusedDay));
        widget.onMonthChanged(_focusedDay);
      },

      headerStyle: const HeaderStyle(
        formatButtonVisible: false,
        titleCentered: true,
      ),

      calendarBuilders: CalendarBuilders(
        headerTitleBuilder: (context, day) {
          return GestureDetector(
            onTap: () => _openMonthYearPicker(context),
            child: Text(
              DateFormat.yMMM().format(day),
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          );
        },

        markerBuilder: (context, date, events) {
          if (events.isEmpty) return const SizedBox();
          return Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children:
                events
                    .map(
                      (dot) => Container(
                        margin: const EdgeInsets.symmetric(horizontal: 1.5),
                        width: 8,
                        height: 8,
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

      calendarStyle: const CalendarStyle(
        selectedDecoration: BoxDecoration(
          color: Colors.blue,
          shape: BoxShape.circle,
        ),
        todayDecoration: BoxDecoration(
          color: Colors.orange,
          shape: BoxShape.circle,
        ),
        outsideDaysVisible: false,
      ),

      availableCalendarFormats: const {CalendarFormat.month: 'Month'},
    );
  }
}

/// Picker Dialog: Tap year → toggle Month <-> Year picker
class MonthYearPickerDialog extends StatefulWidget {
  final DateTime initialDate;
  final DateTime firstDate;
  final DateTime lastDate;
  final ValueChanged<DateTime> onMonthYearSelected;

  const MonthYearPickerDialog({
    super.key,
    required this.initialDate,
    required this.firstDate,
    required this.lastDate,
    required this.onMonthYearSelected,
  });

  @override
  State<MonthYearPickerDialog> createState() => _MonthYearPickerDialogState();
}

class _MonthYearPickerDialogState extends State<MonthYearPickerDialog> {
  late DateTime selectedDate;
  bool showYearPicker = false;

  List<int> get _years => [
    for (int y = widget.firstDate.year; y <= widget.lastDate.year; y++) y,
  ];

  static const List<String> monthNames = [
    "Jan",
    "Feb",
    "Mar",
    "Apr",
    "May",
    "Jun",
    "Jul",
    "Aug",
    "Sep",
    "Oct",
    "Nov",
    "Dec",
  ];

  @override
  void initState() {
    super.initState();
    selectedDate = widget.initialDate;
  }

  void _selectMonth(int month) {
    widget.onMonthYearSelected(DateTime(selectedDate.year, month, 1));
    Navigator.pop(context);
  }

  void _selectYear(int year) {
    setState(() {
      selectedDate = DateTime(year, selectedDate.month, 1);
      showYearPicker = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.white,
      insetPadding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
      child: SizedBox(
        width: 360,
        height: 480,
        child: Column(
          children: [
            _header(),
            Expanded(
              child: AnimatedSwitcher(
                duration: const Duration(milliseconds: 250),
                child: showYearPicker ? _yearGrid() : _monthGrid(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _header() {
    return Padding(
      padding: const EdgeInsets.all(12),
      child: Row(
        children: [
          IconButton(
            icon: const Icon(Icons.close),
            onPressed: () => Navigator.pop(context),
          ),
          Expanded(
            child: Center(
              child: GestureDetector(
                onTap: () => setState(() => showYearPicker = !showYearPicker),
                child: Text(
                  "${selectedDate.year}",
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(width: 48),
        ],
      ),
    );
  }

  Widget _monthGrid() {
    return GridView.builder(
      key: const ValueKey("monthGrid"),
      padding: const EdgeInsets.all(12),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        childAspectRatio: 1.6,
      ),
      itemCount: 12,
      itemBuilder: (_, index) {
        final month = index + 1;
        final isSelected = selectedDate.month == month;

        return InkWell(
          onTap: () => _selectMonth(month),
          child: Container(
            margin: const EdgeInsets.all(6),
            decoration: BoxDecoration(
              color: isSelected ? Colors.blue : Colors.transparent,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Center(
              child: Text(
                monthNames[index],
                style: TextStyle(
                  color: isSelected ? Colors.white : Colors.black,
                  fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _yearGrid() {
    return GridView.builder(
      key: const ValueKey("yearGrid"),
      padding: const EdgeInsets.all(12),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        childAspectRatio: 2.1,
      ),
      itemCount: _years.length,
      itemBuilder: (_, index) {
        final year = _years[index];
        final isSelected = selectedDate.year == year;

        return InkWell(
          onTap: () => _selectYear(year),
          child: Container(
            decoration: BoxDecoration(
              color: isSelected ? Colors.blue : Colors.transparent,
              borderRadius: BorderRadius.circular(10),
            ),
            alignment: Alignment.center,
            child: Text(
              year.toString(),
              style: TextStyle(
                color: isSelected ? Colors.white : Colors.black,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
              ),
            ),
          ),
        );
      },
    );
  }
}

/// EventDot model
