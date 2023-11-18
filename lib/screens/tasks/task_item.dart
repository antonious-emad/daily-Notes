import 'package:flutter/material.dart';
import 'package:untitled/shared/styles/colors.dart';

class TaskItem extends StatelessWidget {
  const TaskItem({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal:  18.0,vertical: 8),
      child: Card(
        shape:RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(14)
        ) ,
        child: Padding(
          padding: const EdgeInsets.all(14.0),
          child: Row(
            children: [
              Container(
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
                  Text("Task Title"),
                  Text("Task Describtion"),
                ],
              ),
              Spacer(),
              IconButton(onPressed: (){}, icon: Icon(Icons.done_outlined))
            ],
          ),
        ),
      ),
    );
  }
}
