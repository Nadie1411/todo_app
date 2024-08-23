import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/Provider/list_provider.dart';
import 'package:todo_app/app_colors.dart';
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
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
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
               maxLines: 4,),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(AppLocalizations.of(context)!.select_date,
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w500,
                              color: AppColors.blackColor)),
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
                              backgroundColor: Colors.cyan);
                        },
                        child: Text(
                          AppLocalizations.of(context)!.add,
                          style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: AppColors.primaryColor),
                        ))
                  ],
                ))
          ],
        ),
      ),


    );
  }

  void addTask()
  {
    if (formKey.currentState?.validate() == true) {
      Task tasks =
          Task(title: title, description: description, datetime: selectDate);

      FirebaseUtils.addTaskToFireStore(tasks).timeout(Duration(seconds: 1),
            onTimeout: () {
              print('task added successfully');
              listProvider.getAllTasksFromFireStore();

              Navigator.pop(context);
            });
      }
  }

  void showCalendar() async {
    var chosenDate = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime.now(),
        lastDate: DateTime.now().add(Duration(days: 365)));

    selectDate = chosenDate ?? DateTime.now();
  }
}
