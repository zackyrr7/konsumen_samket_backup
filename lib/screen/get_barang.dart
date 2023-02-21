import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sampah_market/constant.dart';
import 'package:sampah_market/model/barang_model.dart';
import 'package:sampah_market/model/repository_barang.dart';

class Get extends StatefulWidget {
  const Get({Key? key}) : super(key: key);

  @override
  State<Get> createState() => _GetState();
}

class _GetState extends State<Get> {
  Service serviceApi = Service();
  late Future<List<Barang>> listBarang;
  @override
  void initState() {
    // ignore: todo
    // TODO: implement initState
    super.initState();
    listBarang = serviceApi.getAllBarang();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text(
        "Barang yang dapat dijual",
        style: TextStyle(
          fontSize: ScreenUtil().setSp(15),
        ),
      )),
      body: Center(
        child: FutureBuilder<List<Barang>>(
          future: listBarang,
          builder: ((context, snapshot) {
            if (snapshot.hasData) {
              List<Barang> isiBarang = snapshot.data!;
              return Center(
                child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2),
                  itemCount: isiBarang.length,
                  itemBuilder: ((context, index) {
                    return GridTile(
                      child: Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Container(
                          decoration: BoxDecoration(
                              border: Border.all(), color: Colors.white),
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(top: 8.0),
                                child: Container(
                                    //color: Colors.black,
                                    width: ScreenUtil().setWidth(140),
                                    height: ScreenUtil().setHeight(140),
                                    child: 
                                    Image.network(
                                      '$url2/storage/${isiBarang[index].foto}'
                                          .toString(),
                                      fit: BoxFit.contain,
                                    )
                                    ),
                              ),
                              Text(
                                isiBarang[index].nama,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Text("Rp."),
                                  Text(
                                    isiBarang[index].harga,
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  }),
                ),
              );
            } else if (snapshot.hasError) {
              return Text("${snapshot.error}");
            }

            return const CircularProgressIndicator();
          }),
        ),
      ),
    );
  }
}
