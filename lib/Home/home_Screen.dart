import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/Home/Settings_tab.dart';
import 'package:todo_app/Home/add_task_bottom_sheet.dart';
import 'package:todo_app/Home/auth/login_screen.dart';
import 'package:todo_app/Home/task_list_tab.dart';
import 'package:todo_app/Provider/user_provider.dart';
import 'package:todo_app/app_colors.dart';

class HomeScreen extends StatefulWidget
{
  static const String routeName = "HomeScreen";

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int selectedIndex=0;

  @override
  Widget build(BuildContext context)
  {
    var userProvider = Provider.of<UserProvider>(context);
    return Scaffold(
      appBar: AppBar(
          actions: [
            ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pushNamed(LoginScreen.routeName);
                },
                child: Icon(
                  Icons.logout,
                  color: AppColors.whiteColor,
                ))
          ],
          toolbarHeight: MediaQuery.of(context).size.height * 0.20,
          title: Text(
              selectedIndex == 0
                  ? '${AppLocalizations.of(context)!.app_title} (${userProvider.currentUser!.name})'
                  : '${AppLocalizations.of(context)!.settings}(${userProvider.currentUser!.name})',
              style: Theme.of(context).textTheme.bodyLarge)),
      bottomNavigationBar: BottomAppBar(
        shape: CircularNotchedRectangle(),
        notchMargin: 8,
        child: SingleChildScrollView(
          child: BottomNavigationBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            currentIndex: selectedIndex,
            onTap: (index) {
              selectedIndex = index;
              setState(() {});
            },
            items: [
              BottomNavigationBarItem(
                  icon: ImageIcon(AssetImage('assets/tasks_icn.png')),
                  label: ''),
              BottomNavigationBarItem(
                  icon:
                      ImageIcon(AssetImage('assets/Icon feather-settings.png')),
                  label: '')
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          showAddTaskBottomSheet();
        },
        child: Icon(
          Icons.add,
          size: 25,
          color: AppColors.whiteColor,
        ),
        shape: StadiumBorder(side: BorderSide(
          width: 6,
          color: AppColors.whiteColor
        )),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      body: selectedIndex == 0 ? TaskListTab() : SettingsTab(),

    );


  }

  void showAddTaskBottomSheet() {
    showModalBottomSheet(
        context: context,
        builder: (context) => AddTaskBottomSheet());

  }
}


