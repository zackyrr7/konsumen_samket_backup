import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:sampah_market/model/Tabungan_model.dart';

import 'package:sampah_market/model/repository_tabungan.dart';

class RincianList extends StatefulWidget {
  const RincianList({
    Key? key,
  }) : super(key: key);

  @override
  State<RincianList> createState() => _RincianListState();
}

class _RincianListState extends State<RincianList> {
  Service serviceApi = Service();
  late Future<List<Tabungan>> listTabungan;
  @override
  void initState() {
    // ignore: todo
    // TODO: implement initState
    super.initState();
    listTabungan = serviceApi.getAllTabungan();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      // color: Colors.red,
      width: ScreenUtil().setWidth(360),
      height: ScreenUtil().setHeight(40),
      child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: FutureBuilder<List<Tabungan>>(
            future: listTabungan,
            builder: ((context, snapshot) {
              if (snapshot.hasData) {
                List<Tabungan> isiTabungan = snapshot.data!;
                return Column(
                  children: List.generate(
                    isiTabungan.length,
                    (index) => Padding(
                      padding: const EdgeInsets.only(bottom: 8.0),
                      child: Container(
                        decoration: const BoxDecoration(
                          color: Colors.white,
                        ),
                        height: ScreenUtil().setHeight(120),
                        child: Column(
                          children: [
                            const Text(
                              "Tanggal Transaksi",
                              style: TextStyle(color: Colors.grey),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                isiTabungan[index].tanggal,
                                style:
                                    TextStyle(fontSize: ScreenUtil().setSp(20)),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 5.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Column(
                                    children: [
                                      const Text("Total",
                                          style: TextStyle(color: Colors.grey)),
                                      Text(isiTabungan[index].total.toString(),
                                          style: TextStyle(
                                              fontSize: ScreenUtil().setSp(20)))
                                    ],
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              } else if (snapshot.hasError) {
                return Text("${snapshot.error}");
              }

              return const CircularProgressIndicator();
            }),
          )

          //
          ),
    );
  }
}
