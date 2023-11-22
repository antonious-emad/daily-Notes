import 'package:calendar_timeline/calendar_timeline.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:untitled/models/task_model.dart';
import 'package:untitled/providers/my_provider.dart';
import 'package:untitled/screens/tasks/task_item.dart';
import 'package:untitled/shared/firebase/firebase_functions.dart';
import 'package:untitled/shared/styles/colors.dart';

class TasksTab extends StatefulWidget {
  const TasksTab({super.key});

  @override
  State<TasksTab> createState() => _TasksTabState();
}

class _TasksTabState extends State<TasksTab> {
  DateTime selectedDate=DateTime.now();
  @override
  Widget build(BuildContext context) {
    var provider=Provider.of<MyProvider>(context);
    return Column(
      children: [
        Stack(children: [
          Container(
            height: 80,
            color: Colors.blue,
            width: double.infinity,
          ),
          CalendarTimeline(
            initialDate: selectedDate,
            firstDate: DateTime.now().subtract(Duration(days: 365)),
            lastDate: DateTime.now().add(Duration(days: 365)),
            onDateSelected: (date) {
              setState(() {
                selectedDate=date;
              });
            },
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
        StreamBuilder(
          stream: FireBaseFunctions.getTasksRealTimeChanges(selectedDate),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                  child: CircularProgressIndicator(
                    color: primaryColor,
                  ));
            }
            if (snapshot.hasError) {
              return Text("something went wrong");
            }
            List<TaskModel> tasks =
                snapshot.data?.docs.map((e) => e.data()).toList() ?? [];

            if(tasks.isEmpty){return Center(child: Text("No Tasks"));}
            return Expanded(
                child: ListView.builder(
                  itemBuilder: (context, index) {
                    return TaskItem(task: tasks[index]);
                  },
                  itemCount: tasks.length,
                ));
          },
        ),
        //for read data real time changes

        // FutureBuilder(
        //     future: FireBaseFunctions.getTasks(selectedDate),
        //     builder: (context, snapshot) {
        //       if (snapshot.connectionState == ConnectionState.waiting) {
        //         return Center(
        //             child: CircularProgressIndicator(
        //           color: primaryColor,
        //         ));
        //       }
        //       if (snapshot.hasError) {
        //         return Text("something went wrong");
        //       }
        //       List<TaskModel> tasks =
        //           snapshot.data?.docs.map((e) => e.data()).toList() ?? [];
        //       return Expanded(
        //           child: ListView.builder(
        //         itemBuilder: (context, index) {
        //           return TaskItem(task: tasks[index]);
        //         },
        //         itemCount: tasks.length,
        //       ));
        //     },
        //   ),//for read tasks one time read only
      ],
    );
  }
}
