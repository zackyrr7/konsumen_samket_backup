import 'package:flutter/material.dart';
import 'package:sampah_market/constant.dart';
import 'package:sampah_market/screen/login.dart';

import 'package:sampah_market/screen/bantuan.dart';
import 'package:sampah_market/screen/akun.dart';
import 'package:sampah_market/screen/beranda.dart';



import 'package:shared_preferences/shared_preferences.dart';

class MyBotNavbar extends StatefulWidget {
  const MyBotNavbar({Key? key}) : super(key: key);

  @override
  State<MyBotNavbar> createState() => _MyBotNavbarState();
}

class _MyBotNavbarState extends State<MyBotNavbar> {
 late final SharedPreferences sharedPreferences;

  @override
  void initState() {
    super.initState();
    checkLoginStatus();
  }

  checkLoginStatus() async {
    sharedPreferences = await SharedPreferences.getInstance();
    if(sharedPreferences.getString("token") == null) {
      Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (BuildContext context) => const LoginPage()), (Route<dynamic> route) => false);
    }
  }



  int _currentIndex = 0;
  final List<Widget> _children = [
    const Beranda(),
    // const Riwayat(),
    const Bantuan(),
    const Akun(),
  ];

  void onTappedBar(int index) {
    setState(() {
      _currentIndex = index;
    });
  }


    

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _children[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: biruMain,
        unselectedItemColor: Colors.grey,
        onTap: onTappedBar,
        currentIndex: _currentIndex,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Beranda',
          ),
          // BottomNavigationBarItem(
          //   icon: Icon(Icons.history),
          //   label: 'Riwayat',
          // ),
          BottomNavigationBarItem(
            icon: Icon(Icons.help),
            label: 'Bantuan',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.portrait),
            label: 'Akun',
          ),
        ],
      ),
    );
  }
}
