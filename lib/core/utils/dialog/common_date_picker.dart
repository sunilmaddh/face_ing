import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_getx_widget.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:ntt_data/data/models/vital_graph_response_model.dart';
import 'package:ntt_data/modules/views/vital_graph/widgets/tablel_calender.dart';
import 'package:table_calendar/table_calendar.dart';

class EventDot {
  final Color color;
  EventDot(this.color);
}

class CommonDatePicker extends StatelessWidget {
  final DateTime? initialDate;
  final DateTime firstDate;
  final DateTime lastDate;
  final ValueChanged<DateTime> onDateSelected;
  final String? label;

  const CommonDatePicker({
    super.key,
    this.initialDate,
    required this.firstDate,
    required this.lastDate,
    required this.onDateSelected,
    this.label,
  });

  Future<void> _pickDate(BuildContext context) async {
    final picked = await showDatePicker(
      context: context,
      initialDate: initialDate ?? DateTime.now(),
      firstDate: firstDate,
      lastDate: lastDate,
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(
              primary: Colors.blue, // header background
              onPrimary: Colors.white, // header text color
              onSurface: Colors.black, // body text color
            ),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                foregroundColor: Colors.blue, // button text color
              ),
            ),
          ),
          child: child!,
        );
      },
    );

    if (picked != null) {
      onDateSelected(picked);
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _pickDate(context),
      child: AbsorbPointer(
        child: TextFormField(
          decoration: InputDecoration(
            labelText: label ?? "Select Date",
            suffixIcon: Icon(Icons.calendar_today),
            border: OutlineInputBorder(),
          ),
          controller: TextEditingController(
            text:
                initialDate != null
                    ? "${initialDate!.day}/${initialDate!.month}/${initialDate!.year}"
                    : "",
          ),
        ),
      ),
    );
  }
}

Future<DateTime?> showMonthChangeDatePicker({
  required BuildContext context,
  required DateTime initialDate,
  required DateTime firstDate,
  required DateTime lastDate,
  required Function(DateTime displayedMonth) onMonthChanged,
}) {
  return showDialog<DateTime>(
    context: context,
    builder: (context) {
      return AlertDialog(
        contentPadding: EdgeInsets.zero,
        content: SizedBox(
          width: 350,
          height: 400,
          child: CalendarDatePicker(
            initialDate: initialDate,
            firstDate: firstDate,
            lastDate: lastDate,

            // 👇 CALLBACK TRIGGERED WHEN MONTH CHANGES
            onDisplayedMonthChanged: (DateTime newMonth) {
              onMonthChanged(newMonth);
            },

            onDateChanged: (date) {
              Navigator.pop(context, date);
            },
          ),
        ),
      );
    },
  );
}

Future<void> showCommonDatePicker({
  required BuildContext context,
  required DateTime firstDate,
  required DateTime lastDate,
  DateTime? initialDate,
  required ValueChanged<DateTime> onDateSelected,
  required Map<DateTime, List<EventDot>> eventMap,
  required Function(DateTime, StateSetter) onMonthChanged,
}) async {
  await showDialog(
    context: context,
    builder: (context) {
      return StatefulBuilder(
        builder: (context, updateState) {
          return Dialog(
            insetPadding: const EdgeInsets.all(20),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            child: SizedBox(
              height: 420,
              child: TableCalendarExample(
                firstDate: firstDate,
                lastDate: lastDate,
                initialDate: initialDate ?? DateTime.now(),
                eventMap: eventMap,
                onMonthChanged: (date) {
                  onMonthChanged(date, updateState);
                  updateState(() {});
                },
                onDateSelected: (selectedDate) {
                  onDateSelected(selectedDate);
                  Navigator.pop(context);
                },
              ),
            ),
          );
        },
      );
    },
  );
}

// final pickedDate = await showMonthChangeDatePicker(
//   context: context,
//   initialDate: initialDate ?? DateTime.now(),
//   firstDate: firstDate,
//   lastDate: lastDate,

//   onMonthChanged: (newMonth) {
//     print("New Month: ${newMonth.month}-${newMonth.year}");
//     // 🔥 Call your API here
//     // VitalGraphHelper().callForUserWithFilterByMonth(newMonth);
//   },
// );

// if (pickedDate != null) {
//   onDateSelected(pickedDate);
// }

// Future<void> showCommonDatePicker({
//   required BuildContext context,
//   required DateTime firstDate,
//   required DateTime lastDate,
//   DateTime? initialDate,
//   Function(DateTime)? onMonthChanged,
//   required ValueChanged<DateTime> onDateSelected,
//   required List<HealthList>? eventList,
// }) async {
//   final eventMap = buildEventMap(eventList);
//   final pickedDate = await showMonthChangeDatePicker(
//     context: context,
//     initialDate: initialDate ?? DateTime.now(),
//     firstDate: firstDate,
//     lastDate: lastDate,
//     eventMap: eventMap,

//     onMonthChanged: (newMonth) async {
//       print("📅 Month changed → ${newMonth.month}-${newMonth.year}");
//       onMonthChanged?.call(newMonth);
//       // 🔥 Call your API HERE to fetch new month's events
//       // Example:
//       // final newEvents = await VitalGraphHelper().fetchMonthEvents(newMonth);
//       // setState(() {
//       //   eventMap = buildEventMap(newEvents);
//       // });
//     },
//   );

//   if (pickedDate != null) {
//     onDateSelected(pickedDate);
//   }
// }

Map<DateTime, List<EventDot>> buildEventMap(List<HealthList>? events) {
  if (events == null || events.isEmpty) return {};
  Map<DateTime, List<EventDot>> eventMap = {};

  for (HealthList item in events) {
    DateTime date = DateTime.parse(item.scannedDate!);

    DateTime key = DateTime(date.year, date.month, date.day);

    Color dotColor;
    switch (item.status) {
      case "High":
        dotColor = Colors.red;
        break;
      case "Low":
        dotColor = Colors.green;
        break;
      default:
        dotColor = Colors.blue; // Normal
    }

    if (eventMap[key] == null) {
      eventMap[key] = [EventDot(dotColor)];
    } else {
      eventMap[key]!.add(EventDot(dotColor));
    }
  }
  return eventMap;
}

Future<DateTime?> showMonthChangeDatePicker1({
  required BuildContext context,
  required DateTime initialDate,
  required DateTime firstDate,
  required DateTime lastDate,
  required Function(DateTime displayedMonth) onMonthChanged,
  required Map<DateTime, List<EventDot>> eventMap,
}) {
  DateTime focusedDate = initialDate;
  DateTime selectedDate = initialDate;

  return showDialog<DateTime>(
    context: context,
    builder: (_) {
      return AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        contentPadding: EdgeInsets.zero,
        content: StatefulBuilder(
          builder: (context, setState) {
            return SizedBox(
              width: 350,
              child: TableCalendar(
                firstDay: firstDate,
                lastDay: lastDate,
                focusedDay: focusedDate,
                startingDayOfWeek: StartingDayOfWeek.monday,

                // Highlight selected date
                selectedDayPredicate: (day) => isSameDay(selectedDate, day),

                // When user selects a date
                onDaySelected: (selected, focused) {
                  setState(() {
                    selectedDate = selected;
                    focusedDate = focused;
                  });
                  Navigator.pop(context, selected);
                },

                // Month change API callback
                onPageChanged: (newMonth) {
                  focusedDate = newMonth;
                  onMonthChanged(newMonth);
                },

                // Load event dots
                eventLoader: (day) {
                  DateTime key = DateTime(day.year, day.month, day.day);
                  return eventMap[key] ?? [];
                },

                calendarStyle: CalendarStyle(
                  todayDecoration: BoxDecoration(
                    color: Colors.blue.shade100,
                    shape: BoxShape.circle,
                  ),
                  selectedDecoration: BoxDecoration(
                    color: Colors.blue,
                    shape: BoxShape.circle,
                  ),
                  markersAlignment: Alignment.bottomCenter,
                  markerSize: 7,
                ),

                // Custom event dots
                calendarBuilders: CalendarBuilders(
                  markerBuilder: (context, date, events) {
                    if (events.isEmpty) return SizedBox();

                    return Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children:
                          events
                              .map(
                                (e) => Container(
                                  width: 7,
                                  height: 7,
                                  margin: const EdgeInsets.symmetric(
                                    horizontal: 1.2,
                                  ),
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Colors.red,
                                  ),
                                ),
                              )
                              .toList(),
                    );
                  },
                ),
              ),
            );
          },
        ),
      );
    },
  );
}
