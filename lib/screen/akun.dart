import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:sampah_market/model/repository_get_akun.dart';
import 'package:sampah_market/model/user_model.dart';
import 'package:sampah_market/screen/login.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:url_launcher/url_launcher.dart';

class Akun extends StatefulWidget {
  const Akun({Key? key}) : super(key: key);

  @override
  State<Akun> createState() => _AkunState();
}

class _AkunState extends State<Akun> {
  late SharedPreferences sharedPreferences;
  Service serviceApi = Service();
  late Future<User?> listUser;

  @override
  void initState() {
    // ignore: todo
    // TODO: implement initState
    super.initState();
    //listUser = serviceApi.getAllUser();
    listUser = serviceApi.getAllUser();
    checkLoginStatus();
    controllernama = TextEditingController();
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

  late TextEditingController controllernama;

  @override
  void dispose() {
    controllernama.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {


    return Scaffold(
        appBar: AppBar(
          title: const Text("Akun"),
          actions: [
            GestureDetector(
              onTap: () {
                sharedPreferences.clear();
                //sharedPreferences.commit();
                Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(
                        builder: (BuildContext context) => const LoginPage()),
                    (Route<dynamic> route) => false);
              },
              child: const Padding(
                padding: EdgeInsets.fromLTRB(15, 15, 15, 0),
                child: Text(
                  "Keluar",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                  ),
                ),
              ),
            )
          ],
        ),
        body: FutureBuilder<User?>(
          future: listUser,
          builder: ((context, snapshot) {
            if (snapshot.hasData) {
              User isiUser = snapshot.data!;
              return SingleChildScrollView(
                  child: Column(children: [
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(children: [
                    SizedBox(
                        width: MediaQuery.of(context).size.width,
                        //color: Colors.white,
                        child: const Text(
                          "Nama",
                          style: TextStyle(fontSize: 15, color: Colors.grey),
                        )),
                    Padding(
                      padding: const EdgeInsets.only(left: 15.0),
                      child: SizedBox(
                        //color: Colors.white,
                        width: MediaQuery.of(context).size.width,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Flexible(
                              child: Text(
                                isiUser.name,
                                maxLines: 1,
                                style:
                                    TextStyle(fontSize: ScreenUtil().setSp(18)),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ]),
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width,
                        child: const Text(
                          "Nomor Telepon",
                          style: TextStyle(fontSize: 15, color: Colors.grey),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 15.0),
                        child: SizedBox(
                          width: MediaQuery.of(context).size.width,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Flexible(
                                child: Text(
                                  isiUser.nomor_hp,
                                  style: TextStyle(
                                      fontSize: ScreenUtil().setSp(18)),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  width: ScreenUtil().setWidth(360),
                  height: ScreenUtil().setHeight(1),
                  color: Colors.black54,
                ),
                SizedBox(
                  width: ScreenUtil().setWidth(360),
                  height: ScreenUtil().setHeight(150),
                 
                  child: Column(
                    children: [
                      const Text("Ikuti Media Sosial Kami"),
                      Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: Row(mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            GestureDetector(onTap: _openIgChat,
                              child: SizedBox(
                                width: ScreenUtil().setWidth(100),
                                height: ScreenUtil().setHeight(100),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    SizedBox(
                                      width: ScreenUtil().setWidth(70),
                                      height: ScreenUtil().setHeight(70),
                                      child: Image.asset(
                                        "assets/gambar/ig.png",
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                    const Text("Instagram")
                                  ],
                                ),
                              ),
                            ),
                            GestureDetector(onTap: _openTTChat,
                              child: SizedBox(
                                width: ScreenUtil().setWidth(100),
                                height: ScreenUtil().setHeight(100),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    SizedBox(
                                      width: ScreenUtil().setWidth(70),
                                      height: ScreenUtil().setHeight(70),
                                      child: Image.asset(
                                        "assets/gambar/tiktok.png",
                                        fit: BoxFit.fill,
                                      ),
                                    ),
                                    const Text("Tiktok")
                                  ],
                                ),
                              ),
                            ),
                            GestureDetector(onTap: _openWhatsAppChat,
                              child: SizedBox(
                                width: ScreenUtil().setWidth(100),
                                height: ScreenUtil().setHeight(100),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    SizedBox(
                                      width: ScreenUtil().setWidth(70),
                                      height: ScreenUtil().setHeight(70),
                                      child: Image.asset(
                                        "assets/gambar/whatsapp.png",
                                        fit: BoxFit.fill,
                                      ),
                                    ),
                                    const Text("Whatsapp")
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                )
              ]));
            } else if (snapshot.hasError) {
              return Text("${snapshot.error}");
            }

            return const Center(child: CircularProgressIndicator());
          }),
        ));
  }
}

void _openWhatsAppChat() async {
  String phoneNumber = '+6281347771171';
  
  String url = 'https://wa.me/$phoneNumber?text=';

  // ignore: deprecated_member_use
  await launch(url);
}
void _openTTChat() async {
 
  String url = 'http://www.tiktok.com/@sampahmarket';

  // ignore: deprecated_member_use
  await launch(url);
}
void _openIgChat() async {

  String url = 'https://www.instagram.com/sampah_market/';

  // ignore: deprecated_member_use
  await launch(url);
}