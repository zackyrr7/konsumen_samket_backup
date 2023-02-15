import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sampah_market/screen/get_barang.dart';
import 'package:sampah_market/screen/login.dart';
import 'package:sampah_market/screen/pesan.dart';
import 'package:sampah_market/screen/tukar_poin.dart';
import 'package:sampah_market/widget/Beranda/card_jual.dart';
import 'package:sampah_market/widget/Beranda/card_list.dart';
import 'package:sampah_market/widget/Beranda/card_point.dart';
import 'package:sampah_market/widget/Beranda/card_tukar.dart';
import 'package:sampah_market/widget/Beranda/logo_nama.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Beranda extends StatefulWidget {
  const Beranda({Key? key}) : super(key: key);

  @override
  State<Beranda> createState() => _BerandaState();
}

class _BerandaState extends State<Beranda> {
  late final SharedPreferences sharedPreferences;

  @override
  void initState() {
    super.initState();
    checkLoginStatus();
  }

  checkLoginStatus() async {
    sharedPreferences = await SharedPreferences.getInstance();
    if (sharedPreferences.getString("token") == null) {
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(
              builder: (BuildContext context) => const LoginPage()),
          (Route<dynamic> route) => false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 35.0),
              child: SizedBox(
                width: ScreenUtil().setWidth(360),
                child: const Namalogo(),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 30.0),
              child: SizedBox(
                  width: ScreenUtil().setWidth(360), child: const CardPoint()),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10.0),
              child: GestureDetector(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return const Get();
                  }));
                },
                child: SizedBox(
                    width: ScreenUtil().setWidth(360), child: const CardList()),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10.0),
              child: GestureDetector(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return const TukarPoint();
                  }));
                },
                child: SizedBox(
                    width: ScreenUtil().setWidth(360), child: const CardTukar()),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10.0),
              child: GestureDetector(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return const Pesan();
                  }));
                },
                child: SizedBox(
                    width: ScreenUtil().setWidth(360), child: const Cardjual()),
              ),
            )
          ],
        ),
      ),
    );
  }
}
