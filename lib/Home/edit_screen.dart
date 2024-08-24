import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/Home/home_Screen.dart';
import 'package:todo_app/Provider/list_provider.dart';
import 'package:todo_app/Provider/user_provider.dart';
import 'package:todo_app/app_colors.dart';
import 'package:todo_app/firebase_utils.dart';
import 'package:todo_app/model/task.dart';

class EditScreen extends StatefulWidget {
  static const String routeName = "edit_screen";

  @override
  State<EditScreen> createState() => _EditScreenState();
}

class _EditScreenState extends State<EditScreen> {
  late TextEditingController titleController;
  late TextEditingController descriptionController;
  late DateTime selectNewDate;
  late ListProvider listProvider;
  late Task task;

  @override
  Widget build(BuildContext context) {
    editScreenArgs args =
        ModalRoute.of(context)!.settings.arguments as editScreenArgs;
    listProvider = Provider.of<ListProvider>(context);

    return Scaffold(
        body: Stack(
      children: [
        Container(
          color: AppColors.whiteColor,
        ),
        Positioned(
            child: AppBar(
              toolbarHeight: MediaQuery.of(context).size.height * 0.20,
              title: Text(
                AppLocalizations.of(context)!.app_title,
                style: Theme.of(context).textTheme.bodyLarge,
              ),
            ),
            top: 0,
            left: 0,
            right: 0),
        Positioned(
          child: Container(
            decoration: BoxDecoration(
                color: AppColors.whiteColor,
                borderRadius: BorderRadius.all(Radius.circular(20))),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Container(
                  margin: EdgeInsets.all(15),
                  child: Text(
                    "Edit Task",
                    textAlign: TextAlign.center,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    controller: titleController =
                        TextEditingController(text: args.task.title),
                    decoration: InputDecoration(
                        label: Text(
                      "Task title",
                      style: Theme.of(context).textTheme.titleLarge,
                    )),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    controller: descriptionController =
                        TextEditingController(text: args.task.description),
                    decoration: InputDecoration(
                        label: Text("Task details",
                            style: Theme.of(context).textTheme.titleLarge)),
                  ),
                ),
                Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      AppLocalizations.of(context)!.select_date,
                      style: Theme.of(context).textTheme.titleLarge,
                      textAlign: TextAlign.start,
                    )),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: InkWell(
                    onTap: () {
                      showCalendar();
                    },
                    child: Text(
                        "${listProvider.selectDate.day}/"
                        "${listProvider.selectDate.month}/"
                        "${listProvider.selectDate.year}",
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            fontSize: 15, fontWeight: FontWeight.bold)),
                  ),
                ),
                ElevatedButton(
                    onPressed: () {
                      updateTask();
                    },
                    child: Text(
                      "Save Changes",
                      style: Theme.of(context).textTheme.bodyMedium,
                    ))
              ],
            ),
          ),
          top: 210,
          right: 40,
          left: 40,
          bottom: 100,
        )
      ],
    ));
  }

  @override
  void dispose() {
    super.dispose();
    titleController.dispose();
    descriptionController.dispose();
  }

  void updateTask() {
    var userProvider = Provider.of<UserProvider>(context, listen: false);
    if (titleController.text.isNotEmpty &&
        descriptionController.text.isNotEmpty) {
      Task updateTask = Task(
          title: titleController.text,
          description: descriptionController.text,
          datetime: selectNewDate);
      FirebaseUtils.updateTaskInFirestore(
              updateTask, userProvider.currentUser!.id)
          .timeout(Duration(seconds: 1), onTimeout: () {
        print("Task updated successfully");
        listProvider.getAllTasksFromFireStore(userProvider.currentUser!.id);
        Navigator.pushNamed(context, HomeScreen.routeName);
      });
    }
  }

  void showCalendar() async {
    var chosenDate = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime.now(),
        lastDate: DateTime.now().add(Duration(days: 365)));
    if (chosenDate != null) {
      setState(() {});
    }

    selectNewDate = chosenDate ?? selectNewDate;
  }
}

class editScreenArgs {
  Task task;

  editScreenArgs({required this.task});
}
