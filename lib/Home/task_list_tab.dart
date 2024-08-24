import 'package:easy_date_timeline/easy_date_timeline.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/Home/task_list_item.dart';
import 'package:todo_app/Provider/list_provider.dart';
import 'package:todo_app/Provider/user_provider.dart';

class TaskListTab extends StatefulWidget {
  @override
  State<TaskListTab> createState() => _TaskListTabState();
}

class _TaskListTabState extends State<TaskListTab> {
  @override
  Widget build(BuildContext context) {
    var listProvider = Provider.of<ListProvider>(context);
    var userProvider = Provider.of<UserProvider>(context);

    if (listProvider.tasksList.isEmpty) {
      listProvider.getAllTasksFromFireStore(userProvider.currentUser!.id);
    }

    return Column (
      children: [
        EasyDateTimeLine(

        initialDate: DateTime.now(),
          onDateChange: (selectedDate) {
            //`selectedDate` the new date selected.
            listProvider.changeSelectDate(
                selectedDate, userProvider.currentUser!.id);
          },
          activeColor: Color(0xff5D9CEC) ,


    ),
        Expanded(
          child: listProvider.tasksList.isEmpty
              ? Center(child: Text("No Tasks Added"))
              : ListView.builder(
                  itemBuilder: (context, index) {
                    return TaskListItem(task: listProvider.tasksList[index]);
                  },
                  itemCount: listProvider.tasksList.length,
                ),
        )
      ],
    );
  }
}
