import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sampah_market/constant.dart';
import 'package:sampah_market/model/repository_tabungan.dart';
import 'package:sampah_market/model/Tabungan_model.dart';

class RincianBanyakPoint extends StatefulWidget {
  const RincianBanyakPoint({
    Key? key,
  }) : super(key: key);

  @override
  State<RincianBanyakPoint> createState() => _RincianBanyakPointState();
}

class _RincianBanyakPointState extends State<RincianBanyakPoint> {
 
 
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
        padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
        child: Expanded(
            child: FutureBuilder<List<Tabungan>>(
                future: listTabungan,
                builder: ((context, snapshot) {
                  if (snapshot.hasData) {
                    List<Tabungan> isiTabungan = snapshot.data!;

                    return Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: bgcolor,
                      ),
                      width: ScreenUtil().setWidth(360),
                      height: ScreenUtil().setHeight(140),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 20.0),
                            child: Column(
                              children: [
                                const Text(
                                  "Poin sampah kamu sebesar:",
                                  style: TextStyle(color: Colors.black54),
                                ),
                                Row(
                                  children: [
                                    SizedBox(
                                        height: ScreenUtil().setHeight(80),
                                        // width: ScreenUtil().setWidth(50),
                                        child: const Image(
                                          image: AssetImage(
                                            'assets/icons/coin.png',
                                          ),
                                        )),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                     Text(
                                      isiTabungan[index].total.toString(),
                                      style: const TextStyle(
                                          fontSize: 20, color: Colors.black),
                                    ),
                                  ],
                                ),
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
