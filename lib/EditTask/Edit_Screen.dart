import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/database/My_Database.dart';
import 'package:todo_app/database/Task.dart';
import 'package:todo_app/dialoge_utils.dart';
import 'package:todo_app/ui/theme/my_theme.dart';

import '../Date_Utils.dart';
import '../Provider/Setting_Provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class EditTaskScreen extends StatefulWidget {
  Task task;
  EditTaskScreen(this.task);

  @override
  State<EditTaskScreen> createState() => _EditTaskScreenState();
}

class _EditTaskScreenState extends State<EditTaskScreen> {
  // static const String routeName='EditScreen';
  var formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    SettingProvider settingProvider = Provider.of(context);

    var mediaQuery = MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.edit_task),
        elevation: 0,
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        child: Stack(
          children: [
            Positioned(
                child: Container(
              width: double.infinity,
              height: mediaQuery.height * .1,
              color: MyTheme.PrimaryLightcolor,
            )),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                    width: mediaQuery.width * 0.89,
                    height: mediaQuery.height * 0.75,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(25),
                        color: settingProvider.isDarkmode()
                            ? MyTheme.dark2color
                            : Colors.white),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        SizedBox(
                          height: 12,
                        ),
                        Center(
                            child: Text(
                          AppLocalizations.of(context)!.edit_task,
                          style: Theme.of(context).textTheme.headline5,
                        )),
                        SizedBox(
                          height: 70,
                        ),
                        Form(
                          key: formkey,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                AppLocalizations.of(context)!.task_title,
                                style: Theme.of(context)
                                    .textTheme
                                    .headline6
                                    ?.copyWith(
                                        color: MyTheme.PrimaryLightcolor),
                              ),
                              TextFormField(
                                onChanged: (String value) {
                                  widget.task.title=value;
                                },
                                style: Theme.of(context).textTheme.headline6,
                                initialValue: widget.task.title,
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Text(
                                AppLocalizations.of(context)!.task_details,
                                style: Theme.of(context)
                                    .textTheme
                                    .headline6
                                    ?.copyWith(
                                        color: MyTheme.PrimaryLightcolor),
                              ),
                              TextFormField(
                                onChanged: (String value) {
                                  widget.task.description=value;
                                },
                                style: Theme.of(context).textTheme.headline6,
                                initialValue: widget.task.description,
                              ),
                              SizedBox(
                                height: 30,
                              ),
                              Text(
                                AppLocalizations.of(context)!.select_date,
                                style: Theme.of(context).textTheme.headline6,
                              ),
                              InkWell(
                                onTap: () {
                                  ShowTaskDatePicker();
                                },
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    MyDateUtils.formateTaskDate(widget.task.date),
                                    style: Theme.of(context)
                                        .textTheme
                                        .headline6
                                        ?.copyWith(
                                            color:
                                                Theme.of(context).primaryColor),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 60,
                        ),
                        MaterialButton(
                            onPressed: () {
                              EditTask();
                            },
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30)),
                            height: 55,
                            color: MyTheme.PrimaryLightcolor,
                            child: Text(
                              'Save Changes',
                              style:TextStyle(color: Colors.white,fontSize: 22),
                            ))
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 30,
                )
              ],
            )
          ],
        ),
      ),
    );
  }

  var selectedDate = DateTime.now();

  void ShowTaskDatePicker() async {
    var userSelectedDate = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime.now(),
        lastDate: DateTime.now().add(Duration(days: 365)));
    if (userSelectedDate == null) {
      return;
    }
    widget.task.date=userSelectedDate;
    selectedDate = userSelectedDate;
    setState(() {});
  }

  void EditTask()async{
    await MyDatabase.EditTaskDetails(widget.task).
    then((value) {
      DialogUtils.ShowMessage(context, 'Task updated successfuly'
          ,posActionTitle: 'Ok',
        posAction: (){
        Navigator.pop(context);
        }
      );
    })
        .onError((error, stackTrace) {
      DialogUtils.ShowMessage(context, 'Error updated Task !!'
          ,posActionTitle: 'Ok',
          posAction: (){
            Navigator.pop(context);
          }
      );
    })
    .timeout(Duration(seconds: 10),onTimeout: (){
      DialogUtils.ShowMessage(context, ' The Task has been updated locally'
          ,posActionTitle: 'Ok',
          posAction: (){
            Navigator.pop(context);
          }
      );
    });

  }
}
