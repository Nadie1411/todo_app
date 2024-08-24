import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/Provider/app_config_provider.dart';
import 'package:todo_app/Provider/list_provider.dart';
import 'package:todo_app/Provider/user_provider.dart';
import 'package:todo_app/app_colors.dart';
import 'package:todo_app/dialouge_utiils.dart';
import 'package:todo_app/firebase_utils.dart';
import 'package:todo_app/model/task.dart';

class AddTaskBottomSheet extends StatefulWidget {
  @override
  State<AddTaskBottomSheet> createState() => _AddTaskBottomSheetState();
}

class _AddTaskBottomSheetState extends State<AddTaskBottomSheet> {
  String title='';
String description='';
var selectDate = DateTime.now();
  var formKey= GlobalKey<FormState>();
  late ListProvider listProvider;

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<AppConfigProvider>(context);
    listProvider = Provider.of<ListProvider>(context);
    return  Container(
      margin: EdgeInsets.all(12),
      child: SingleChildScrollView(
        child: Column(
          children: [
            Text(AppLocalizations.of(context)!.add,
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium
                    ?.copyWith(color: AppColors.blackColor)),
            Form(
                key: formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    TextFormField(
                      onChanged: (text) {
                        title = text;
                      },
                      validator: (text) {
                        if (text == null || text.isEmpty) {
                          return 'Enter Task Title';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                          labelText:
                          AppLocalizations.of(context)!.add_new_task),
                    ),
                    TextFormField(
                      onChanged: (text) {
                        description = text ;
               },
                      // validator: (text)
                      // {
                      //   if(text == null || text.isEmpty)
                      //     {
                      //       return "Please Enter Description";
                      //     }
                      //   return null ;
                      // },
                      decoration: InputDecoration(
                   labelText: 'Enter task description'
               ),
                      maxLines: 2,),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(AppLocalizations.of(context)!.select_date,
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium
                              ?.copyWith(color: AppColors.blackColor)),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: InkWell(
                        onTap: () {
                          showCalendar();
                          setState(() {});
                        },
                        child: Text(
                            "${selectDate.day}/"
                            "${selectDate.month}/"
                            "${selectDate.year}",
                            textAlign: TextAlign.center,
                            style: Theme.of(context)
                                .textTheme
                                .bodySmall
                                ?.copyWith(
                                    fontSize: 15, fontWeight: FontWeight.bold)),
                      ),
                    ),
                    ElevatedButton(
                        onPressed: () {
                          addTask();
                          BottomNavigationBarThemeData(
                              backgroundColor: AppColors.primaryColor);
                        },
                        style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.primaryColor),
                        child: Text(
                          AppLocalizations.of(context)!.add,
                            style: Theme.of(context).textTheme.bodyMedium))
                  ],
                ))
          ],
        ),
      ),


    );
  }

  void addTask()
  {
    var userProvider = Provider.of<UserProvider>(context, listen: false);
    if (formKey.currentState?.validate() == true) {
      Task tasks =
          Task(title: title, description: description, datetime: selectDate);

      FirebaseUtils.addTaskToFireStore(tasks, userProvider.currentUser!.id)
          .then((value) {
        DialogeUtils.showMessage(
            context: context,
            content: "Task Added Successfully",
            posActionName: "Ok");
        listProvider.getAllTasksFromFireStore(userProvider.currentUser!.id);

        Navigator.pop(context);
      }).timeout(Duration(seconds: 1), onTimeout: () {
        DialogeUtils.showMessage(
            context: context,
            content: "Task Added Successfully",
            posActionName: "Ok");
        listProvider.getAllTasksFromFireStore(userProvider.currentUser!.id);

        Navigator.pop(context);
            });
      }
  }

  void showCalendar() async {
    var chosenDate = await showDatePicker(
        builder: (context, child) {
          return Theme(
              data: Theme.of(context).copyWith(
                colorScheme: ColorScheme.light(
                  primary: AppColors.primaryColor,
                  onPrimary: AppColors.blackColor, // header text color
                  onSurface: AppColors.primaryColor, // body text color
                ),
                textButtonTheme: TextButtonThemeData(
                  style: TextButton.styleFrom(
                    foregroundColor:
                        AppColors.primaryColor, // button text color
                  ),
                ),
              ),
              child: child!);
        },
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime.now(),
        lastDate: DateTime.now().add(Duration(days: 365)));

    selectDate = chosenDate ?? DateTime.now();
  }
}
