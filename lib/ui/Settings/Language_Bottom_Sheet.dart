import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/ui/theme/my_theme.dart';

import '../../Provider/Setting_Provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class LanguageBottomSheet extends StatefulWidget {
  const LanguageBottomSheet({Key? key}) : super(key: key);

  @override
  State<LanguageBottomSheet> createState() => _LanguageBottomSheetState();
}

class _LanguageBottomSheetState extends State<LanguageBottomSheet> {

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
              settingProvider.ChangeLanguage('en');
            },
            child: settingProvider.currentlanguage=='en'?
            selectedTheme('English')
                :unselectedTheme('English'),
          )


          ,SizedBox(height: 20,),

          InkWell(
            onTap: (){
              settingProvider.ChangeLanguage('ar');
              },
            child: settingProvider.currentlanguage=='ar'?
            selectedTheme('العربية')
                :unselectedTheme('العربية'),
          )
        ],
      ),
    );
  }
  Widget selectedTheme(String language){
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(language,style: Theme.of(context).textTheme.headline5,),
        Icon(Icons.check,color: MyTheme.PrimaryLightcolor,)
      ] ,
    ) ;
  }

  Widget unselectedTheme(String language){
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(language,style: Theme.of(context).textTheme.headline5,),
      ] ,
    );
  }
}
