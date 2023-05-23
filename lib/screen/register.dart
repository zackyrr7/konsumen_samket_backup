import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sampah_market/constant.dart';
import 'package:http/http.dart' as http;
import 'package:sampah_market/screen/login.dart';
import 'package:sampah_market/widget/register/tombol_login.dart';

class Register extends StatefulWidget {
  const Register({Key? key}) : super(key: key);

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  bool _isLoading = false;
  bool _password = true;
  void _show() {
    setState(() {
      _password = !_password;
    });
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light
        .copyWith(statusBarColor: Colors.transparent));
    return Scaffold(
      body: Container(
          child: _isLoading
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : ListView(
                  children: <Widget>[
                    logo(),
                    input(),
                    tombol(),
                    const TombolBerhasil()
                  ],
                )),
    );
  }

  register(
    String name,
    String email,
    String password,
  ) async {
    var jsonResponse = null;
    //try{
    final response = await http.post(Uri.parse("$url/register"), body: {
      "name": name,
      "email": email,
      "password": password,
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
      margin: const EdgeInsets.only(top: 50.0),
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 30.0),
      child: Column(
        children: [
          SizedBox(
            height: ScreenUtil().setHeight(100),
            width: ScreenUtil().setWidth(150),
            child: Image.asset("assets/icons/sampah.png"),
          ),
        ],
      ),
    );
  }

  final _nameController = TextEditingController();
  final _nomorController = TextEditingController();
  final _passController = TextEditingController();

  Container input() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 20.0),
      child: Column(
        children: <Widget>[
          TextFormField(
            controller: _nameController,
            cursorColor: Colors.black,
            style: const TextStyle(color: Colors.black),
            decoration: const InputDecoration(
              icon: Icon(Icons.person, color: Colors.black),
              hintText: "Nama Anda",
              border: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.black87)),
              hintStyle: TextStyle(color: Colors.black87),
            ),
          ),
          TextFormField(
            controller: _nomorController,
            keyboardType: TextInputType.phone,
            cursorColor: Colors.black,
            style: const TextStyle(color: Colors.black),
            decoration: const InputDecoration(
              icon: Icon(Icons.add_call, color: Colors.black),
              hintText: "Nomor handphone",
              border: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.black87)),
              hintStyle: TextStyle(color: Colors.black87),
            ),
          ),
          TextFormField(
            controller: _passController,
            cursorColor: Colors.black,
            obscureText: true,
            style: const TextStyle(color: Colors.black87),
            decoration: InputDecoration(
              suffixIcon: GestureDetector(
                onTap: () {
                  _show();
                },
                child:
                    Icon(_password ? Icons.visibility_off : Icons.visibility),
              ),
              icon: Icon(Icons.lock, color: Colors.black87),
              hintText: "Password",
              border: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.black87)),
              hintStyle: TextStyle(color: Colors.black87),
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
        style: ButtonStyle(
            backgroundColor:
                MaterialStateProperty.all(hijauMain.withOpacity(0.5))),
        onPressed: _nameController.text == "" ||
                _nomorController.text == "" ||
                _passController.text == ""
            ? null
            : () {
                setState(() {
                  _isLoading = true;
                });
                register(_nameController.text, _nomorController.text,
                    _passController.text);
              },

        //color: Colors.purple,
        child: const Text("Daftar", style: TextStyle(color: Colors.black)),
        //shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
      ),
    );
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
    onPressed: () =>
        Navigator.push(context, MaterialPageRoute(builder: (context) {
      return const LoginPage();
    })),
    child: const Text("Ok"),
  );
  AlertDialog alert = AlertDialog(
    title: const Text("Pendaftaran Berhasil"),
    content: Text('Kembali kehalaman Login'),
    actions: [okButton],
  );
  showDialog(
      context: context,
      builder: ((context) {
        return alert;
      }));
}
