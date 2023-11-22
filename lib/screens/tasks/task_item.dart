import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:untitled/models/task_model.dart';
import 'package:untitled/shared/firebase/firebase_functions.dart';
import 'package:untitled/shared/styles/colors.dart';

class TaskItem extends StatelessWidget {
  TaskModel task;
   TaskItem({required this.task, super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal:  18.0,vertical: 8),
      child: Card(
        shape:RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(14)
        ) ,
        child: Slidable(
            startActionPane: ActionPane(
              extentRatio: 0.23,
              // A motion is a widget used to control how the pane animates.
              motion: const DrawerMotion(),
              // All actions are defined in the children parameter.
              children:  [
                // A SlidableAction can have an icon and/or a label.
                SlidableAction(
                  borderRadius:BorderRadius.only(topLeft:Radius.circular(14),bottomLeft: Radius.circular(14) ) ,
                  onPressed: (context) {FireBaseFunctions.deleteTask(task.id);},
                  backgroundColor: Color(0xFFFE4A49),
                  foregroundColor: Colors.white,
                  icon: Icons.delete,
                  label: 'Delete',
                ),
              ],
            ),
            endActionPane: ActionPane(
                extentRatio: 0.23,
                motion: DrawerMotion(),
                children: [
              SlidableAction(
              borderRadius:BorderRadius.only(topRight:Radius.circular(14),bottomRight: Radius.circular(14) ) ,
              onPressed: (context) {},
              backgroundColor: primaryColor,
              foregroundColor: Colors.white,
              icon: Icons.edit,
              label: 'Edit',
            ),]),
            child: Padding(
              padding: const EdgeInsets.all(14.0),
              child: Row(
              children: [
                task.isDone?Container(
                  height: 80,
                  width: 3,
                  decoration: BoxDecoration(
                    color: Colors.green,
                    borderRadius: BorderRadius.circular(18),

                  ),
                ) :Container(
                  height: 80,
                  width: 3,
                  decoration: BoxDecoration(
                    color: primaryColor,
                    borderRadius: BorderRadius.circular(18),

                  ),
                ),
                SizedBox(width: 20,),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("${task.title}",style: task.isDone? TextStyle(color: Colors.green):TextStyle(color: primaryColor) ,),
                    Text("${task .description}",style: task.isDone? TextStyle(color: Colors.green):TextStyle(color: primaryColor) ,),
                  ],
                ),
                Spacer(),
                task.isDone? Container(
                    padding: EdgeInsets.symmetric(horizontal: 12,vertical: 2),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color:Colors.green,
                    ),
                    child:  Text("Done!",style: TextStyle(color: Colors.white),)
                ) :InkWell(
                  onTap: () {
                    task.isDone=true;
                    FireBaseFunctions.updateTask(task);
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 12,vertical: 2),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color:primaryColor,
                      ),
                      child:  Icon(Icons.done_outlined,color: Colors.white,)
                  ),
                )
              ],
          ),
            ),
        ),
      ),
    );
  }
}
