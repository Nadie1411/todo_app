import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/Provider/list_provider.dart';
import 'package:todo_app/firebase_utils.dart';
import 'package:todo_app/model/task.dart';

import '../app_colors.dart';

class TaskListItem extends StatelessWidget
{
  Task task;

  TaskListItem({required this.task});

  @override
  Widget build(BuildContext context)
  {
    var listProvider = Provider.of<ListProvider>(context);
    return  Container(
      margin: EdgeInsets.all(12),
      child: Slidable(


        // The start action pane is the one at the left or the top side.
        startActionPane: ActionPane(
          extentRatio: 0.25,
          // A motion is a widget used to control how the pane animates.
          motion: const ScrollMotion(),


          // All actions are defined in the children parameter.
          children:  [
            // A SlidableAction can have an icon and/or a label.
            SlidableAction(
              borderRadius:BorderRadius.circular(15) ,
              onPressed: (context)
              {
                FirebaseUtils.deleteTaskFromFirestore(task)
                    .timeout(Duration(seconds: 1), onTimeout: () {
                  print('Task Deleted Sucessfully');
                  listProvider.getAllTasksFromFireStore();
                });
              },
              backgroundColor: Color(0xFFFE4A49),
              foregroundColor: Colors.white,
              icon: Icons.delete,
              label: 'Delete',
            ),

          ],
        ),

        // The end action pane is the one at the right or the bottom side.

        child: Container(
          padding: EdgeInsets.all(12),

          decoration: BoxDecoration(
            color: AppColors.whiteColor,
            borderRadius: BorderRadius.circular(25)
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,

            children: [
              Container(
                margin: EdgeInsets.all(10),
                height: MediaQuery.of(context).size.height*0.1,
                width: 4,
                color: AppColors.primaryColor,
              ),
              Expanded(child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    task.title,
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium
                        ?.copyWith(color: AppColors.primaryColor),
                  ),
                  Text(
                    task.description,
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium
                        ?.copyWith(color: AppColors.primaryColor),
                  ),
                ],
              )),
              Container(
                padding:EdgeInsets.symmetric(horizontal: 12) ,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: AppColors.primaryColor,
                ),
                child: IconButton(onPressed: (){

                },icon: Icon(Icons.check,size: 35,color:AppColors.whiteColor ,),)
                ,
              )
            ],
          ),
        ),
      ),
    );
  }
}
