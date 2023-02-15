import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:sampah_market/screen/login.dart';
//import 'package:sampah_market/screen/login.dart';

import 'package:sampah_market/theme.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences pref = await SharedPreferences.getInstance();
  var token = pref.getString("token");
  // ignore: avoid_print
  print(token);
  var id = pref.getString("id");
  // ignore: avoid_print
  print(id);
  var nama = pref.getString("nama");
  // ignore: avoid_print
  print(nama);
   var hp = pref.getString("nama");
  // ignore: avoid_print
  print(hp);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 800),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: "Sampah market",
          theme: buildThemeData(),
          //home:  token ==null?const LoginPage():MyBotNavbar(),

          home: const LoginPage(),
          //home: const MyBotNavbar(),
          //home:  if ()
          //       checkLoginStatus() async {
          //sharedPreferences pref = await SharedPreferences.getInstance();
          //   if(sharedPreferences.getString("token") == null) {
          //     Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (BuildContext context) => const LoginPage()), (Route<dynamic> route) => false);
          //   }
          // }
        );
      },
    );
  }
}

// checkLoginStatus(context) async {
//     sharedPreferences = await SharedPreferences.getInstance();
//     if(sharedPreferences.getString("token") == null) {
//       Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (BuildContext context) => const LoginPage()), (Route<dynamic> route) => false);
//     }
//   }