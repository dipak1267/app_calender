import 'package:app_calander/event.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';

class AppCalender extends StatefulWidget {
  const AppCalender({Key? key}) : super(key: key);

  @override
  State<AppCalender> createState() => _AppCalenderState();
}

class _AppCalenderState extends State<AppCalender> {
  late Map<DateTime, List<Event>> selectedEvents;

  DateTime selectedDay = DateTime.now();
  DateTime focusedDay = DateTime.now();

  final TextEditingController _eventController = TextEditingController();
  final TextEditingController _eventDecController = TextEditingController();

  late List<dynamic> selectedListEvents;

  @override
  void initState() {
    super.initState();
    selectedEvents = {};
    selectedListEvents = [];
  }

  //pref
  List<Event> _getEventsFromDay(DateTime date) {
    return selectedEvents[date] ?? [];
  }

  @override
  void dispose() {
    _eventController.dispose();
    _eventDecController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: Colors.lime,
        onPressed: () {
          showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  title: const Text("Add Event"),
                  content: SizedBox(
                    height: 200,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          DateFormat("dd-MM-yyyy").format(selectedDay),
                          style: const TextStyle(
                              fontSize: 25, fontWeight: FontWeight.w500),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        TextFormField(
                          controller: _eventController,
                          decoration: InputDecoration(
                              focusedBorder: const OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.lime)),
                              hintText: "Enter Event",
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(5))),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        TextFormField(
                          controller: _eventDecController,
                          decoration: InputDecoration(
                              focusedBorder: const OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.lime)),
                              hintText: "Enter Description",
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(5))),
                        ),
                      ],
                    ),
                  ),
                  actions: [
                    TextButton(
                      child: const Text(
                        "Cancel",
                        style: TextStyle(color: Colors.black),
                      ),
                      onPressed: () => Navigator.pop(context),
                    ),
                    InkWell(
                        onTap: () {
                          if (_eventController.text.isEmpty) {
                          } else {
                            if (selectedEvents[selectedDay] != null) {
                              selectedEvents[selectedDay]!.add(
                                Event(
                                    tittle: _eventController.text,
                                    description: _eventDecController.text),
                              );
                            } else {
                              selectedEvents[selectedDay] = [
                                Event(
                                    tittle: _eventController.text,
                                    description: _eventDecController.text)
                              ];
                            }
                          }
                          Navigator.pop(context);
                          _eventController.clear();
                          _eventDecController.clear();

                          setState(() {});
                          return;
                        },
                        child: Container(
                            alignment: Alignment.center,
                            height: 40,
                            width: 70,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                color: Colors.lime),
                            child: const Text("Save"))),
                  ],
                );
              });
        },
        label: const Text("Add event"),
        icon: const Icon(
          Icons.add,
          color: Colors.black,
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TableCalendar(
              selectedDayPredicate: (DateTime date) {
                return isSameDay(selectedDay, date);
              },
              eventLoader: _getEventsFromDay,
              onDaySelected: (DateTime selectDay, DateTime focusDay) {
                setState(() {
                  selectedDay = selectDay;
                  focusedDay = focusDay;
                });
              },
              focusedDay: selectedDay, 
              daysOfWeekStyle: DaysOfWeekStyle(
                  dowTextFormatter: (date, locale) =>
                      DateFormat("mmm").format(date)),
              calendarStyle: CalendarStyle(
                  selectedTextStyle: const TextStyle(color: Colors.black),
                  selectedDecoration: BoxDecoration(
                    color: Colors.limeAccent,
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  defaultDecoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                  weekendTextStyle: const TextStyle(
                      color: Colors.lime, fontWeight: FontWeight.bold),
                  weekendDecoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                  outsideDecoration:
                      BoxDecoration(borderRadius: BorderRadius.circular(5.0)),
                  outsideTextStyle: TextStyle(
                      color: Colors.lime.withOpacity(0.8),
                      fontWeight: FontWeight.w400),
                  defaultTextStyle: const TextStyle(
                      fontSize: 15, fontWeight: FontWeight.w500)),
              pageJumpingEnabled: true,
              onHeaderTapped: (focusedDay) {
                DateTime.now();
              },
              firstDay: DateTime(1990),
              lastDay: DateTime(2050),
              daysOfWeekHeight: 30,
              headerStyle: const HeaderStyle(
                  titleTextStyle:
                      TextStyle(fontWeight: FontWeight.w600, fontSize: 20),
                  formatButtonVisible: false,
                  titleCentered: true,
                  headerPadding: EdgeInsets.symmetric(horizontal: 20),
                  headerMargin: EdgeInsets.symmetric(vertical: 10)),
              calendarBuilders: CalendarBuilders(
                todayBuilder: (context, date, events) => Container(
                    margin: const EdgeInsets.all(4.0),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        color: Colors.lime.withOpacity(0.8),
                        borderRadius: BorderRadius.circular(20.0)),
                    child: Text(
                      date.day.toString(),
                      style: const TextStyle(
                          color: Colors.black, fontWeight: FontWeight.w600),
                    )),
                dowBuilder: (context, day) {
                  if (day.weekday == DateTime.sunday ||
                      day.weekday == DateTime.monday ||
                      day.weekday == DateTime.tuesday ||
                      day.weekday == DateTime.wednesday ||
                      day.weekday == DateTime.thursday ||
                      day.weekday == DateTime.friday ||
                      day.weekday == DateTime.saturday) {
                    final text = DateFormat.E().format(day);
                    return Center(
                      child: Text(
                        text,
                        style: const TextStyle(color: Colors.lime),
                      ),
                    );
                  } else {
                    return Container();
                  }
                },
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            ..._getEventsFromDay(selectedDay).map(
              (Event event) => Padding(
                padding: const EdgeInsets.all(5.0),
                child: Card(
                  elevation: 5,
                  shadowColor: Colors.lime,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: const EdgeInsets.only(left: 20),
                        alignment: Alignment.centerLeft,
                        height: 40,
                        width: double.infinity,
                        child: Text(
                          "Event : ${event.tittle}",
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.only(left: 20),
                        alignment: Alignment.centerLeft,
                        height: 40,
                        width: double.infinity,
                        child: Text(
                          "Description : ${event.description}",
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    ));
  }
}
