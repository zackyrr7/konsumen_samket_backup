// ignore_for_file: unused_import

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sampah_market/demo.dart';

import 'package:sampah_market/model/pertanyaan_model.dart';
import 'package:sampah_market/screen/login.dart';
import 'package:sampah_market/widget/bantuan/detail.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:sampah_market/widget/bantuan/hubungin.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../model/repository_pertanyaan.dart';

class Bantuan extends StatefulWidget {
  const Bantuan({Key? key}) : super(key: key);

  @override
  State<Bantuan> createState() => _BantuanState();
}

class _BantuanState extends State<Bantuan> {
  late final SharedPreferences sharedPreferences;
  Service serviceApi = Service();
  late Future<List<Pertanyaan>> listPertanyaan;
  @override
  void initState() {
    // ignore: todo
    // TODO: implement initState
    super.initState();
    checkLoginStatus();
    listPertanyaan = serviceApi.getAllBarang();
    
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
        appBar: AppBar(
          title: Text(
            "Pertanyaan yang sering ditanyakan",
            style: TextStyle(fontSize: ScreenUtil().setSp(15)),
          ),
        ),
        body: FutureBuilder<List<Pertanyaan>>(
          future: listPertanyaan,
          builder: ((context, snapshot) {
            if (snapshot.hasData) {
              List<Pertanyaan> isiPertanyaan = snapshot.data!;
              return Stack(
                children: [
                  SizedBox(
                      width: ScreenUtil().setWidth(360),
                      height: ScreenUtil().setHeight(700),
                      child: ListView.builder(
                          itemCount: isiPertanyaan.length,
                          itemBuilder: (context, index) {
                            var pertanyaan = isiPertanyaan[index];
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: GestureDetector(
                                onTap: () {
                                  _detailPage(context, pertanyaan);
                                },
                                // onTap: () {
                                //   Navigator.push(
                                //       context,
                                //       MaterialPageRoute(
                                //           builder: (context) =>
                                //               Detail(tanya)));
                                // },
                                child: Container(
                                  alignment: Alignment.centerLeft,
                                  height: ScreenUtil().setHeight(50),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: Colors.white,
                                      border: Border.all(color: Colors.black)),
                                  child: Padding(
                                    padding: const EdgeInsets.only(left: 8.0),
                                    child: Text(isiPertanyaan[index].judul),
                                  ),
                                ),
                              ),
                            );
                          })),
                  GestureDetector(
                    onTap: () {
                      _openWhatsAppChat();
                    },
                    child: const HubunginKami(),
                  )
                ],
              );
            } else if (snapshot.hasError) {
              return Text("${snapshot.error}");
            }

            return const Align(
                alignment: Alignment.center,
                child: CircularProgressIndicator());
          }),
        ));
  }
}

void _openWhatsAppChat() async {
  String phoneNumber = '+6281347771171';
  String kalimat = 'Halo Admin';
  String url = 'https://wa.me/$phoneNumber?text=$kalimat';

  // ignore: deprecated_member_use
  await launch(url);
}

_detailPage(BuildContext context, Pertanyaan pertanyaan) {
  Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => Detail(
                pertanyaaan: pertanyaan,
              )));
}
