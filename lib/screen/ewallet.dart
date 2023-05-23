import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sampah_market/constant.dart';
import 'package:http/http.dart' as http;
import 'package:sampah_market/widget/beranda/card_point.dart';
import 'package:shared_preferences/shared_preferences.dart';

String id = '';
String namaUser = '';
String hp = '';

class EWallet extends StatefulWidget {
  const EWallet({Key? key}) : super(key: key);

  @override
  State<EWallet> createState() => _EWalletState();
}

class _EWalletState extends State<EWallet> {
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
          "Form E-Wallet",
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

  transaksi(
    String nama,
    String nomor_hp,
    String jenis,
    String no_wallet,
    String total,
    String user_id,
  ) async {
    var jsonResponse = null;
    //try{
    final response = await http.post(Uri.parse("$url/wallet"), headers: {
      'Accept': 'application/json',
    }, body: {
      "nama": namaUser,
      "nomor_hp": hp,
      "jenis": jenis,
      "no_wallet": no_wallet,
      "total": total,
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
        "Form E-Wallet",
        textAlign: TextAlign.center,
        style: TextStyle(fontSize: ScreenUtil().setSp(25)),
      )),
    );
  }

  final _namaController = namaUser;
  final _nomorController = hp;
  final _jenisController = TextEditingController();
  final _walletController = TextEditingController();
  final _totalController = TextEditingController();
  final _userController = id;

  Container input() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 20.0),
      child: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: TextFormField(
              controller: _jenisController,
              cursorColor: Colors.black,
              //obscureText: true,
              style: const TextStyle(color: Colors.black87),
              decoration: const InputDecoration(
                filled: true,
                fillColor: Colors.white,
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black12),
                  borderRadius: BorderRadius.all(Radius.circular(5)),
                ),
                hintText: "Jenis E-Wallet",
                hintStyle: TextStyle(color: Colors.black87),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: TextFormField(
              controller: _walletController,
              cursorColor: Colors.black,
              //obscureText: true,
              style: const TextStyle(color: Colors.black87),
              decoration: const InputDecoration(
                filled: true,
                fillColor: Colors.white,
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black12),
                  borderRadius: BorderRadius.all(Radius.circular(5)),
                ),
                hintText: "Nomor E-Wallet",
                hintStyle: TextStyle(color: Colors.black87),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: TextFormField(
              controller: _totalController,
              cursorColor: Colors.black,
              //obscureText: true,
              style: const TextStyle(color: Colors.black87),
              decoration: const InputDecoration(
                filled: true,
                fillColor: Colors.white,
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black12),
                  borderRadius: BorderRadius.all(Radius.circular(5)),
                ),
                hintText: "Total yang ingin di cairkan",
                hintStyle: TextStyle(color: Colors.black87),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Container tombol() {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 40.0,
      padding: const EdgeInsets.symmetric(horizontal: 15.0),
      margin: const EdgeInsets.only(top: 15.0),
      child: ElevatedButton(
        onPressed: _jenisController.text == "" ||
                _walletController.text == "" ||
                _totalController.text == ""
            ? null
            : () {
                setState(() {
                  _isLoading = true;
                });
                transaksi(
                    _namaController,
                    _nomorController,
                    _jenisController.text,
                    _walletController.text,
                    _totalController.text,
                    _userController);
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
        height: ScreenUtil().setHeight(250),
        width: ScreenUtil().setWidth(300),
        child: Column(
          children: [
            Text("Catatan", style: TextStyle(fontSize: ScreenUtil().setSp(20))),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "Setelah membuat transaksi penukaran saldo berupa penukaran E-Wallet, Pihak dari Sampah Market akan melakukan pengecekan terkait saldo anda. E-wallet yang tersedia berupa \nShopeePay\nDana\nGopay\nPihak admin akan melakukan konfirmasi kepada anda. Terima Kasih",
                textAlign: TextAlign.justify,
                style: TextStyle(fontSize: ScreenUtil().setSp(12)),
              ),
            )
          ],
        ));
  }
}

_showAlertDialog(BuildContext context, String err) {
  Widget okButton = FloatingActionButton(
    onPressed: () => Navigator.pop(context),
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
