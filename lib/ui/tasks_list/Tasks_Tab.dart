import 'package:calendar_timeline/calendar_timeline.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/database/My_Database.dart';
import 'package:todo_app/ui/tasks_list/Task_Item.dart';
import 'package:todo_app/ui/theme/my_theme.dart';

import '../../Provider/Setting_Provider.dart';
import '../../database/Task.dart';

class TasksTab extends StatefulWidget {
  @override
  State<TasksTab> createState() => _TasksTabState();
}


class _TasksTabState extends State<TasksTab> {
  var selectedDate=DateTime.now();

  @override
  Widget build(BuildContext context) {
    SettingProvider settingProvider =Provider.of(context);

    return Container(
      child: Column(
        children: [
          CalendarTimeline(

            initialDate: selectedDate,
            firstDate: DateTime.now().subtract(Duration(days: 365)),
            lastDate: DateTime.now().add(Duration(days: 365)),
            onDateSelected: (date) {
              if (date==null){
                return;
              }
              selectedDate=date;
              setState(() {});
            },
            leftMargin: 10,
            monthColor: settingProvider.isDarkmode()? MyTheme.PrimaryLightcolor:Colors.black,
            dayColor: settingProvider.isDarkmode()?Colors.white:Colors.black,
            activeDayColor: Theme.of(context).primaryColor,
            activeBackgroundDayColor: Colors.white,
            dotsColor:Theme.of(context).primaryColor,
            selectableDayPredicate: (date) => true,
            locale: 'en_ISO',


          ),
          Expanded(
            child:
                // allTasks.isEmpty?Center(child: CircularProgressIndicator()):
                    StreamBuilder<QuerySnapshot<Task>>(
                      stream: MyDatabase.getRealTimeUpdates(selectedDate),
                      builder:(buildContext,snapshot){
                        if(snapshot.connectionState==ConnectionState.waiting){
                          return Center(child: CircularProgressIndicator());
                        }
                        if(snapshot.hasError){
                          return Center(child: Text('Error in Loading Tasks'));
                        }
                        var tasks=snapshot.data?.docs.map((doc) => doc.data()).toList();
                        return  ListView.builder(itemBuilder: (_,index){
                         return TaskItem(tasks![index]);
                         },itemCount: tasks?.length??0,);

                      },

                    )

          )
        ],
      ),
    );
  }

}
