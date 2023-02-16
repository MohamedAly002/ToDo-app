import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/Provider/Setting_Provider.dart';
import '../theme/my_theme.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ThemeBottomSheet extends StatefulWidget {
  const ThemeBottomSheet({Key? key}) : super(key: key);

  @override
  State<ThemeBottomSheet> createState() => _ThemeBottomSheetState();
}

class _ThemeBottomSheetState extends State<ThemeBottomSheet> {
  @override
  Widget build(BuildContext context) {
    SettingProvider settingProvider =Provider.of(context);
    return Container(
      color: settingProvider.isDarkmode()? MyTheme.dark2color:Colors.white,
      padding: EdgeInsets.all(20),
      child: Column(
        children: [
          InkWell(
            onTap: (){
              settingProvider.ChangeTheme(ThemeMode.light);
            },
            child: settingProvider.isDarkmode()?
            unselectedTheme(AppLocalizations.of(context)!.light)
            :selectedTheme(AppLocalizations.of(context)!.light),
          )


          ,SizedBox(height: 20,),

          InkWell(
            onTap: (){
              settingProvider.ChangeTheme(ThemeMode.dark);
            },
            child: settingProvider.isDarkmode()?
            selectedTheme(AppLocalizations.of(context)!.dark)
                :unselectedTheme(AppLocalizations.of(context)!.dark),
          )


        ],
      ),
    );
  }

  Widget selectedTheme(String theme){
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(theme,style: Theme.of(context).textTheme.headline5,),
        Icon(Icons.check,color: MyTheme.PrimaryLightcolor,)
      ] ,
    ) ;
  }

  Widget unselectedTheme(String theme){
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(theme,style: Theme.of(context).textTheme.headline5,),
      ] ,
    );
  }
}
