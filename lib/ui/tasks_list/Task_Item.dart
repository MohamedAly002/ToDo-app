import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/EditTask/Edit_Screen.dart';
import 'package:todo_app/database/My_Database.dart';
import 'package:todo_app/dialoge_utils.dart';

import '../../Provider/Setting_Provider.dart';
import '../../database/Task.dart';
import '../theme/my_theme.dart';

class TaskItem extends StatefulWidget {
  Task task;
  TaskItem(this.task);

  @override
  State<TaskItem> createState() => _TaskItemState();
}

class _TaskItemState extends State<TaskItem> {
  @override
  Widget build(BuildContext context) {
    SettingProvider settingProvider = Provider.of(context);

    return InkWell(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (BuildContext context0) =>
                    EditTaskScreen(widget.task)));
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(18),
          color: Colors.red,
        ),
        margin: EdgeInsets.symmetric(vertical: 8, horizontal: 12),
        child: Slidable(
          startActionPane:
              ActionPane(extentRatio: 0.2, motion: DrawerMotion(), children: [
            SlidableAction(
              onPressed: (buildContext) {
                deleteTask();
              },
              backgroundColor: Color(0xFFFE4A49),
              foregroundColor: Colors.white,
              icon: Icons.delete,
              label: 'Delete',
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(18),
                bottomLeft: Radius.circular(18),
              ),
            )
          ]),
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(18),
              color: settingProvider.isDarkmode()
                  ? MyTheme.dark2color
                  : Colors.white,
            ),
            child: Row(
              children: [
                Container(
                    height: 70,
                    width: 6,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(18),
                      color: widget.task.isDone
                          ? MyTheme.greenycolor
                          : Theme.of(context).primaryColor,
                    )),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(15),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Text(
                          widget.task.title,
                          style: Theme.of(context)
                              .textTheme
                              .headline5
                              ?.copyWith(
                                  color: widget.task.isDone
                                      ? MyTheme.greenycolor
                                      : Theme.of(context).primaryColor),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Text(
                          widget.task.description,
                          style: Theme.of(context).textTheme.headline6,
                        )
                      ],
                    ),
                  ),
                ),
                InkWell(
                  onTap: (){
                    MyDatabase.IsDone(widget.task);
                  },
                  child: widget.task.isDone
                      ? Text(
                          'Done!',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 30,
                              color: MyTheme.greenycolor),
                        )
                      : Container(
                          padding:
                              EdgeInsets.symmetric(vertical: 8, horizontal: 18),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(18),
                            color: Theme.of(context).primaryColor,
                          ),
                          child: Icon(
                            Icons.check,
                            color: Colors.white,
                            size: 30,
                          ),
                        ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  void deleteTask() {
    DialogUtils.ShowMessage(
      context,
      'Are you sure u want to delete this task',
      posActionTitle: 'Yes',
      posAction: () async {
        await MyDatabase.DeleteTask(widget.task);
        DialogUtils.hideDialog(context);
        DialogUtils.ShowMessage(
          context,
          'The task Deleted Successfuly',
          posActionTitle: 'Ok',
          posAction: () {
            Navigator.pop(context);}
        );
      },
      negActionTitle: 'Cancel',
    );
  }
}
