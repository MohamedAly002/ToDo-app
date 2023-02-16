import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/ui/Settings/Settings_Tab.dart';
import 'package:todo_app/ui/tasks_list/Add_Task.dart';
import 'package:todo_app/ui/tasks_list/Tasks_Tab.dart';
import 'package:todo_app/ui/theme/my_theme.dart';

import '../../Provider/Setting_Provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class HomeScreen extends StatefulWidget {
  static const String routeName = 'HomeScreen';

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int SelectedIndexTap=0;

  @override
  Widget build(BuildContext context) {

    List<String>scafoldtitles=['ToDo App',AppLocalizations.of(context)!.settings];

    SettingProvider settingProvider =Provider.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(scafoldtitles[SelectedIndexTap],style: TextStyle(fontSize: 22),),
        toolbarHeight: 55,
        centerTitle: true,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        backgroundColor: Theme.of(context).primaryColor,
        shape: StadiumBorder(side: BorderSide(width: 4, color: Colors.white)),
        onPressed: () {
          return ShowAddTaskBottomSheet();
        },
        child: Icon(Icons.add),
      ),
      bottomNavigationBar: BottomAppBar(
        color:settingProvider.isDarkmode()? MyTheme.dark2color:Colors.white,

        shape: CircularNotchedRectangle(),
        notchMargin: 8,
        child: BottomNavigationBar(
          currentIndex: SelectedIndexTap,
          onTap: (index){
            SelectedIndexTap=index;
            setState(() {});

          },
          items: [
            BottomNavigationBarItem(icon: Icon(Icons.list), label: ''),
            BottomNavigationBarItem(icon: Icon(Icons.settings), label: ''),
          ],
        ),
      ),
      body:Tabs[SelectedIndexTap] ,
    );
  }


  var Tabs=[TasksTab(),SettingsTab()];
  void ShowAddTaskBottomSheet(){
showModalBottomSheet(context: context, builder: (buildContext){
  return AddTask();
});

  }
}
