import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/EditTask/Edit_Screen.dart';
import 'package:todo_app/Provider/Setting_Provider.dart';
import 'package:todo_app/ui/Home/Home_Screen.dart';
import 'package:todo_app/ui/theme/my_theme.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';


import 'firebase_options.dart';
void main() async{
  await WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  runApp(ChangeNotifierProvider(
    create: (BuildContext context){
      return SettingProvider();
    },
      child: MyApplication()));
}

class MyApplication extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    SettingProvider settingProvider=Provider.of(context);
    return MaterialApp(
      localizationsDelegates: [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: [
        Locale('en'), // English
        Locale('ar'), // Arabic
      ],



      debugShowCheckedModeBanner: false,
      theme:MyTheme.LightTheme ,
      darkTheme: MyTheme.DarkTheme,
      themeMode: settingProvider.currenttheme,
      locale: Locale(settingProvider.currentlanguage),
      initialRoute:HomeScreen.routeName,
      routes: {
        HomeScreen.routeName:(_)=>HomeScreen(),
        // EditTaskScreen.routeName:(_)=>EditTaskScreen(),

    },


    );
  }
}