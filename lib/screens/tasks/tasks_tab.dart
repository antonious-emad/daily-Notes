import 'package:calendar_timeline/calendar_timeline.dart';
import 'package:flutter/material.dart';
import 'package:untitled/screens/tasks/task_item.dart';
import 'package:untitled/shared/styles/colors.dart';

class TasksTab extends StatelessWidget {
  const TasksTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Stack(
            children: [
          Container(height: 80,color: Colors.blue,width: double.infinity,),
          CalendarTimeline(
            initialDate: DateTime.now(),
            firstDate:  DateTime.now().subtract(Duration(days: 365)),
            lastDate: DateTime.now().add(Duration(days: 365)),
            onDateSelected: (date) => print(date),
            leftMargin: 20,
            monthColor: Colors.white,
            dayColor: Colors.white.withOpacity(0.70),
            activeDayColor: Colors.black,
            activeBackgroundDayColor: Colors.white,
            dotsColor: Colors.transparent,
            selectableDayPredicate: (date) => date.day != 0,
            locale: 'en_ISO',
          ),
        ]),

        Expanded(child: ListView.builder(itemBuilder: (context,index){return TaskItem();},itemCount: 8,))
      ],
    );
  }
}
