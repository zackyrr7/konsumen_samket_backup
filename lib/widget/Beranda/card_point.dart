import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sampah_market/constant.dart';
import 'package:sampah_market/model/Tabungan_model.dart';
import 'package:sampah_market/model/repository_tabungan.dart';

class CardPoint extends StatefulWidget {
  const CardPoint({
    Key? key,
  }) : super(key: key);

  @override
  State<CardPoint> createState() => _CardPointState();
}

class _CardPointState extends State<CardPoint> {
  String total2 = "";
  String tanggal = "";
  Service serviceApi = Service();
  late Future<List<Tabungan>> listTabungan;

  get index => 0;
  @override
  void initState() {
    // ignore: todo
    // TODO: implement initState
    super.initState();
    listTabungan = serviceApi.getAllTabungan();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
        child: Expanded(
            child: FutureBuilder<List<Tabungan>>(
                future: listTabungan,
                builder: ((context, snapshot) {
                  if (snapshot.hasData) {
                    List<Tabungan> isiTabungan = snapshot.data!;
                    if (isiTabungan.isEmpty) {
                      total2 = "Anda belum melakukan transaksi :(";

                      tanggal = "Anda belum melakukan transaksi :(";
                    } else {
                      total2 = isiTabungan[index].total.toString();

                      tanggal = isiTabungan[isiTabungan.length - 1].tanggal;
                    }
                    return Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: biruMain,
                        boxShadow: const [
                          BoxShadow(
                            color: Colors.black,
                            offset: Offset(0.0, 1.0), //(x,y)
                            blurRadius: 5.0,
                          ),
                        ],
                      ),
                      // width: ScreenUtil().setWidth(100),
                      height: ScreenUtil().setHeight(180),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 20.0),
                            child: Column(
                              children: [
                                const Text(
                                  "Saldo di Dompet kamu sebesar:",
                                  style: TextStyle(color: Colors.white),
                                ),
                                Flexible(
                                  child: Container(
                                    //color: Colors.amber,
                                    height: ScreenUtil().setHeight(80),
                                    width: ScreenUtil().setWidth(320),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        SizedBox(
                                            height: ScreenUtil().setHeight(65),
                                            // width: ScreenUtil().setWidth(50),
                                            child: const Image(
                                              image: AssetImage(
                                                'assets/icons/coin.png',
                                              ),
                                            )),
                                        Flexible(
                                          child: Text(
                                            total2,
                                            maxLines: 2,
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              fontSize: ScreenUtil().setSp(22),
                                              color: Colors.white,
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                                Column(
                                  children: [
                                    const Text(
                                      "Tanggal terakhir transaksi",
                                      style: TextStyle(color: Colors.white60),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(top: 8.0),
                                      child: Text(
                                        tanggal,
                                        style: TextStyle(
                                            fontSize: ScreenUtil().setSp(20),
                                            color: Colors.white),
                                      ),
                                    )
                                  ],
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  } else if (snapshot.hasError) {
                    return Text("${snapshot.error}");
                  }

                  return const CircularProgressIndicator();
                }))));
  }
}
