import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/ui/theme/my_theme.dart';

import '../../Provider/Setting_Provider.dart';
import 'Language_Bottom_Sheet.dart';
import 'Theme_Bottom_Sheet.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SettingsTab extends StatefulWidget {

  @override
  State<SettingsTab> createState() => _SettingsTabState();
}

class _SettingsTabState extends State<SettingsTab> {
  @override
  Widget build(BuildContext context) {
    SettingProvider settingProvider =Provider.of(context);

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 40,vertical: 25),

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(AppLocalizations.of(context)!.language,style: Theme.of(context).textTheme.headline5,),
          InkWell(
            onTap: (){
              ShowLanguageBottomSheet();
            },
            child: Container(
              margin: EdgeInsets.symmetric(vertical: 20),
              padding: EdgeInsets.symmetric(horizontal: 10),
              decoration: BoxDecoration(
                color: settingProvider.isDarkmode()? MyTheme.dark2color:Colors.white,
                border: Border.all(width: 1,color: MyTheme.PrimaryLightcolor)
              ),
              child:Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(settingProvider.currentlanguage=='en'?
                      'English':'العربية'
                    ,style: Theme.of(context).textTheme.headline6?.copyWith(color: MyTheme.PrimaryLightcolor),),
                  IconButton(onPressed: (){
                    ShowLanguageBottomSheet();
                  }, icon: Icon(Icons.keyboard_arrow_down_outlined),color:MyTheme.PrimaryLightcolor ,)
                ],
              ) ,
            ),
          ),
          Text(AppLocalizations.of(context)!.theme,style: Theme.of(context).textTheme.headline5,),
          InkWell(
            onTap:(){
              ShowThemeBottomSheet();
            } ,
            child: Container(
              margin: EdgeInsets.symmetric(vertical: 20),
              padding: EdgeInsets.symmetric(horizontal: 10),
              decoration: BoxDecoration(
                  color: settingProvider.isDarkmode()? MyTheme.dark2color:Colors.white,
                  border: Border.all(width: 1,color: MyTheme.PrimaryLightcolor)
              ),
              child:Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(settingProvider.isDarkmode()?AppLocalizations.of(context)!.dark
                      :AppLocalizations.of(context)!.light
                    ,style: Theme.of(context).textTheme.headline6?.copyWith(color: MyTheme.PrimaryLightcolor),),
                  IconButton(onPressed: (){
                    ShowThemeBottomSheet();
                  }, icon: Icon(Icons.keyboard_arrow_down_outlined),color:MyTheme.PrimaryLightcolor ,)
                ],
              ) ,
            ),
          ),
        ],
      ),
    );
  }

  void ShowLanguageBottomSheet(){
    showModalBottomSheet(context: context, builder: (buildContext){
      return LanguageBottomSheet();
    });
  }

  void ShowThemeBottomSheet(){
    showModalBottomSheet(context: context, builder: (buildContext){
      return ThemeBottomSheet();
    });
  }
}
