import 'package:flutter/material.dart';
import 'package:easy_date_timeline/easy_date_timeline.dart';
import 'package:todo_app/Home/task_list_item.dart';
import 'package:todo_app/app_colors.dart';
class TaskListTab extends StatelessWidget {
  const TaskListTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Column (
      children: [
        EasyDateTimeLine(

        initialDate: DateTime.now(),
    onDateChange: (selectedDate) {
    //`selectedDate` the new date selected.
    },
    activeColor: Color(0xff5D9CEC) ,


    ),
        Expanded(
          child: ListView.builder(itemBuilder: (context,index){
            return
              TaskListItem();

          },
          itemCount: 30,),
        )
      ],
    );
  }
}
