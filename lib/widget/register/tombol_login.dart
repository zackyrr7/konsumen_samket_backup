import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sampah_market/screen/login.dart';

class TombolBerhasil extends StatelessWidget {
  const TombolBerhasil({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      // height: ScreenUtil().setHeight(20),
      padding: const EdgeInsets.symmetric(horizontal: 40.0),
      margin: const EdgeInsets.only(top: 5.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "Sudah mempunyai akun?",
            style: TextStyle(
                color: Colors.black54, fontSize: ScreenUtil().setSp(10)),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 5.0),
            child: GestureDetector(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return const LoginPage();
                }));
              },
              child: Text(
                "masuk Sekarang",
                style: TextStyle(
                    decoration: TextDecoration.underline,
                    fontSize: ScreenUtil().setSp(12)),
              ),
            ),
          )
        ],
      ),
    );
  }
}
