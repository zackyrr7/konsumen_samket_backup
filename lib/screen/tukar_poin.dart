import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sampah_market/model/repository_get_akun.dart';
import 'package:sampah_market/model/user_model.dart';
import 'package:sampah_market/screen/cuci.dart';
import 'package:sampah_market/screen/emas_mini.dart';
import 'package:sampah_market/screen/ewallet.dart';
import 'package:sampah_market/screen/listrik.dart';
import 'package:sampah_market/screen/pembayaran_pdam.dart';
import 'package:sampah_market/screen/sedekah.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TukarPoint extends StatefulWidget {
  const TukarPoint({Key? key}) : super(key: key);

  @override
  State<TukarPoint> createState() => _TukarPointState();
}

class _TukarPointState extends State<TukarPoint> {
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
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text("Cairkan saldo")),
        body: FutureBuilder<User?>(
            future: listUser,
            builder: ((context, snapshot) {
              if (snapshot.hasData) {
                User isiUser = snapshot.data!;
                return GridView.count(crossAxisCount: 2, children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: GridTile(
                        child: Flexible(
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) {
                            return const Sedekah();
                          }));
                        },
                        child: Container(
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.black),
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(20)),
                          child: Column(
                            children: [
                              Container(
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(20)),
                                  width: ScreenUtil().setWidth(180),
                                  height: ScreenUtil().setHeight(120),
                                  child: const Image(
                                    image: AssetImage("assets/gambar/sedekah.png"),
                                    fit: BoxFit.contain,
                                  )),
                              const Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Center(
                                  child: Text(
                                    ('Sedekah'),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    )),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: GridTile(
                        child: Flexible(
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) {
                            return const EmasMini();
                          }));
                        },
                        child: Container(
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.black),
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(20)),
                          child: Column(
                            children: [
                              Container(
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(20)),
                                  width: ScreenUtil().setWidth(180),
                                  height: ScreenUtil().setHeight(120),
                                  child: const Image(
                                    image: AssetImage("assets/gambar/emas.png"),
                                    fit: BoxFit.contain,
                                  )),
                              const Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Center(
                                  child: Text(
                                    ('Emas Mini'),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    )),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: GridTile(
                        child: Flexible(
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) {
                            return const Listrik();
                          }));
                        },
                        child: Container(
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.black),
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(20)),
                          child: Column(
                            children: [
                              Container(
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(20)),
                                  width: ScreenUtil().setWidth(180),
                                  height: ScreenUtil().setHeight(120),
                                  child: const Image(
                                    image:
                                        AssetImage("assets/gambar/listrik.png"),
                                    fit: BoxFit.contain,
                                  )),
                              const Center(
                                child: Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Text(
                                    ('Voucher Listrik'),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    )),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: GridTile(
                        child: Flexible(
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) {
                            return const PembayaranPdam();
                          }));
                        },
                        child: Container(
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.black),
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(20)),
                          child: Column(
                            children: [
                              Container(
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(20)),
                                  width: ScreenUtil().setWidth(180),
                                  height: ScreenUtil().setHeight(120),
                                  child: const Image(
                                    image: AssetImage("assets/gambar/air.png"),
                                    fit: BoxFit.contain,
                                  )),
                              const Center(
                                child: Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Text(
                                    ('Pembayaran PDAM'),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    )),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: GridTile(
                        child: Flexible(
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) {
                            return const EWallet();
                          }));
                        },
                        child: Container(
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.black),
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(20)),
                          child: Column(
                            children: [
                              Container(
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(20)),
                                  width: ScreenUtil().setWidth(180),
                                  height: ScreenUtil().setHeight(120),
                                  child: const Image(
                                    image:
                                        AssetImage("assets/gambar/ewallet.png"),
                                    fit: BoxFit.contain,
                                  )),
                              const Center(
                                child: Text(
                                  ('E-Wallet'),
                                  textAlign: TextAlign.center,
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    )),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: GridTile(
                        child: Flexible(
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) {
                            return const Cucii();
                          }));
                        },
                        child: Container(
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.black),
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(20)),
                          child: Column(
                            children: [
                              Container(
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(20)),
                                  width: ScreenUtil().setWidth(180),
                                  height: ScreenUtil().setHeight(120),
                                  child: const Image(
                                    image: AssetImage("assets/gambar/cuci.png"),
                                    fit: BoxFit.contain,
                                  )),
                               Center(
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    ('Pencucian motor/mobil'),style: TextStyle(fontSize: ScreenUtil().setSp(12)),
                                    textAlign: TextAlign.center
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    )),
                  ),
                ]);
              } else if (snapshot.hasError) {
                return Text("${snapshot.error}");
              }

              return const Center(child: CircularProgressIndicator());
            })));
  }
}
