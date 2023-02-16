import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/Date_Utils.dart';
import 'package:todo_app/database/My_Database.dart';
import 'package:todo_app/database/Task.dart';

import '../../Provider/Setting_Provider.dart';
import '../../dialoge_utils.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class AddTask extends StatefulWidget {
  const AddTask({Key? key}) : super(key: key);

  @override
    State<AddTask> createState() => _AddTaskState();
}

class _AddTaskState extends State<AddTask> {
  var formKey=GlobalKey<FormState>();
  var titleController=TextEditingController();
  var descriptionController=TextEditingController();

  @override
  Widget build(BuildContext context) {
    SettingProvider settingProvider =Provider.of(context);

    return Container(
      padding: EdgeInsets.all(12),
      child: Form(
        key: formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              AppLocalizations.of(context)!.add_new_task,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.headline5,
            ),
            TextFormField(
              style: Theme.of(context).textTheme.headline6,
              controller: titleController,
              validator: (inpute){
                if(inpute==null||inpute.trim().isEmpty){
                  return'Please Enter a valid title';
                }
                return null;
              },
              decoration: InputDecoration(
                  labelText: AppLocalizations.of(context)!.title,
                  labelStyle: Theme.of(context).textTheme.headline5,
                  hintText: 'Enter Your Task',
                hintStyle: TextStyle(color: Colors.grey),

              ),
            ),
            TextFormField(
              style: Theme.of(context).textTheme.headline6,
              controller: descriptionController,
              minLines: 4,
              maxLines: 4,
              decoration: InputDecoration(
                labelText: AppLocalizations.of(context)!.description,
                labelStyle: Theme.of(context).textTheme.headline5,
                hintText: 'Enter Your Description',
                  hintStyle: TextStyle(color: Colors.grey)
              ),
              validator: (inpute){
                if(inpute==null||inpute.trim().isEmpty){
                  return'Please Enter a valid description';
                }
                return null;
              },
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              AppLocalizations.of(context)!.select_date,
              style: Theme.of(context).textTheme.headline6,
            ),
            SizedBox(
              height: 10,
            ),
            InkWell(
              onTap: (){
                 ShowTaskDatePicker();
              },
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  MyDateUtils.formateTaskDate(selectedDate ),
                  style: Theme.of(context)
                      .textTheme
                      .headline6
                      ?.copyWith(color: Theme.of(context).primaryColor),
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            ElevatedButton(onPressed: (){
              insertTask();
            }, child: Text(AppLocalizations.of(context)!.submit))
          ],
        ),
      ),
    );
  }
  var selectedDate=DateTime.now();
  void ShowTaskDatePicker()async{
    var userSelectedDate=await showDatePicker(context: context,
        initialDate: selectedDate,
        firstDate: DateTime.now(),
        lastDate: DateTime.now().add(Duration(days: 365)
        )
    );
    if(userSelectedDate==null){
      return;
    }
    selectedDate=userSelectedDate;
    setState(() {});
  }
  void insertTask()async{
    if(formKey.currentState?.validate()==false){
      return;

    }
    Task task=Task( title: titleController.text, description: descriptionController.text, date: selectedDate);
    DialogUtils.ShowProgressDialog(context, 'Inserting Task...',isDismissible: false);
    try {
      await MyDatabase.insertTask(task);
      DialogUtils.hideDialog(context);
      DialogUtils.ShowMessage(context, 'The Task Inserted Successfuly',
          posActionTitle: 'Ok', posAction: () {
            Navigator.pop(context);
          }
      );
    }
    catch(e){
      DialogUtils.hideDialog(context);
      DialogUtils.ShowMessage(context, 'Error inserting task',
          posActionTitle: 'Try Again',
          posAction: () {
            insertTask();
          },
          negActionTitle: 'Cancel',
        negAction: (){
        Navigator.pop(context);
        }
      );


    }

  }
}
