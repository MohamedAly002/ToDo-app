import 'package:flutter/material.dart';

class DialogUtils{
  static void ShowProgressDialog(BuildContext context,String message,
  {bool isDismissible=true}
      ){

    showDialog(context: context, builder: (buildcontext){
      return AlertDialog(
        content: Row(
          children: [
            CircularProgressIndicator(),
            SizedBox(width: 12,),
            Text(message)
          ],
        ),
      );
    },
    barrierDismissible: false
    );
  }
  static void hideDialog(BuildContext context){
    Navigator.pop(context);

  }
  static void ShowMessage(BuildContext context,String message,
       {VoidCallback?posAction,
        String? posActionTitle,
      String? negActionTitle,
      VoidCallback?negAction
        }
      ){
    List<Widget>actions=[];
    if(posActionTitle!=null){
      actions.add(TextButton(onPressed: (){
        Navigator.pop(context);
        if(posAction!=null){
          posAction();
        }

      }, child: Text(posActionTitle)));

    }
    if(negActionTitle!=null){
      actions.add(TextButton(onPressed: (){
        Navigator.pop(context);
        if(negAction!=null){
          negAction();
        }

      }, child: Text(negActionTitle)));


    }
    showDialog(context: context, builder: (buildcontext){
      return AlertDialog(
        content: Text(message),
        actions: actions,
      );
    });
  }

}