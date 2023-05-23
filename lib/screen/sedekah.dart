import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sampah_market/constant.dart';
import 'package:http/http.dart' as http;
import 'package:sampah_market/screen/beranda.dart';
import 'package:sampah_market/widget/beranda/card_point.dart';
import 'package:shared_preferences/shared_preferences.dart';

String id = '';
String namaUser = '';
String hp = '';

class Sedekah extends StatefulWidget {
  const Sedekah({Key? key}) : super(key: key);

  @override
  State<Sedekah> createState() => _SedekahState();
}

class _SedekahState extends State<Sedekah> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _loadId();
  }

  _loadId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      id = (prefs.getString('id') ?? '');
      namaUser = (prefs.getString('nama') ?? '');
      hp = (prefs.getString('hp') ?? '');
      print(namaUser);
      print(id);
    });
  }

  bool _isLoading = false;
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light
        .copyWith(statusBarColor: Colors.transparent));
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(
          color: Colors.black, //change your color here
        ),
        centerTitle: true,
        title: const Text(
          "Form Pencuci",
          style: TextStyle(color: Colors.black),
        ),
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: Container(
          child: _isLoading
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : ListView(
                  children: <Widget>[
                    //logo(),
                    CardPoint(),
                    input(),
                    tombol(),
                    catatan(),
                  ],
                )),
    );
  }

  sedekah(
    String nama,
    String nomor_hp,
    String jumlah,
    String user_id,
  ) async {
    var jsonResponse = null;
    //try{
    final response = await http.post(Uri.parse("$url/sedekah"), headers: {
      'Accept': 'application/json',
    }, body: {
      "nama": namaUser,
      "nomor_hp": hp,
      "jumlah": jumlah,
      "user_id": id
    });
    if (response.statusCode == 200) {
      jsonResponse = json.decode(response.body);
      print('Response Status: ${response.statusCode}');
      print('Response body: ${response.statusCode}');
      _showBerhasilDialog(context, String);
      if (jsonResponse != null) {
        setState(() {
          _isLoading = false;
        });
      }
    } else {
      setState(() {
        _isLoading = false;
      });
      _showAlertDialog(context, response.body);
      print(response.body);
    }
  }

  Container logo() {
    return Container(
      //color: Colors.white,
      margin: const EdgeInsets.only(top: 20.0),
      //padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 30.0),
      child: Center(
          child: Text(
        "Form Sedekah",
        textAlign: TextAlign.center,
        style: TextStyle(fontSize: ScreenUtil().setSp(25)),
      )),
    );
  }

  final _namaController = namaUser;
  final _nomorController = hp;
  final _jumlahController = TextEditingController();
  final _userController = id;

  Container input() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 20.0),
      child: Padding(
        padding: const EdgeInsets.only(top: 8.0),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.white,
          ),
          child: TextFormField(
            controller: _jumlahController,
            cursorColor: Colors.black,
            //obscureText: true,
            // style: const TextStyle(color: Colors.black87),
            // decoration: const InputDecoration(
            //   //icon: Icon(Icons.lock, color: Colors.black87),
            //   hintText: "jumlah Kendaraan Anda",
            //   border: UnderlineInputBorder(
            //       borderSide: BorderSide(color: Colors.black87)),
            //   hintStyle: TextStyle(color: Colors.black87),
            // ),
            style: const TextStyle(color: Colors.black87),
            decoration: const InputDecoration(
              filled: true,
              fillColor: Colors.white,
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.black12),
                borderRadius: BorderRadius.all(Radius.circular(5)),
              ),
              hintText: "Jumlah Sedekah",
              hintStyle: TextStyle(color: Colors.black87),
            ),
          ),
        ),
      ),
    );
  }

  Container tombol() {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 40.0,
      padding: const EdgeInsets.symmetric(horizontal: 15.0),
      //margin: const EdgeInsets.only(top: 15.0),
      child: ElevatedButton(
        onPressed: _jumlahController.text == ""
            //_userController == ""
            ? null
            : () {
                setState(() {
                  _isLoading = true;
                });
                sedekah(_namaController, _nomorController,
                    _jumlahController.text, _userController);
              },

        //color: Colors.purple,
        child:
            const Text("Buat Pesanan", style: TextStyle(color: Colors.black)),
        //shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
      ),
    );
  }

  Container catatan() {
    return Container(
        margin: const EdgeInsets.only(top: 20.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Colors.white,
        ),
        //height: ScreenUtil().setHeight(250),
        width: ScreenUtil().setWidth(300),
        child: Column(
          children: [
            Text("Catatan", style: TextStyle(fontSize: ScreenUtil().setSp(20))),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "Sampah Market telah bekerja sama dengan Dompet Ummat untuk menyalurkan sedekah anda kepada orang yang membutuhkan",
                textAlign: TextAlign.justify,
                style: TextStyle(fontSize: ScreenUtil().setSp(12)),
              ),
            )
          ],
        ));
  }
}

_showBerhasilDialog(BuildContext context, String) {
  Widget okButton = FloatingActionButton(
    onPressed: () => Navigator.pop(context),
    child: const Text("Ok"),
  );
  AlertDialog alert = AlertDialog(
    title: const Text("Transaksi Berhasil"),
    content: Text('Pihak Sampah Market akan menkonfirmasi pesanan anda'),
    actions: [okButton],
  );
  showDialog(
      context: context,
      builder: ((context) {
        return alert;
      }));
}

_showAlertDialog(BuildContext context, String err) {
  Widget okButton = FloatingActionButton(
    onPressed: () =>
        Navigator.push(context, MaterialPageRoute(builder: (context) {
      return const Beranda();
    })),
    child: const Text("Ok"),
  );
  AlertDialog alert = AlertDialog(
    title: const Text("error"),
    content: Text(err),
    actions: [okButton],
  );
  showDialog(
      context: context,
      builder: ((context) {
        return alert;
      }));
}
