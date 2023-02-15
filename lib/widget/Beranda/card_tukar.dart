import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:sampah_market/constant.dart';

class CardTukar extends StatelessWidget {
  const CardTukar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
      child: Container(
        decoration: BoxDecoration(
            border: Border.all(color: Colors.black26),
            borderRadius: BorderRadius.circular(20),
            color: Colors.white),
        width: ScreenUtil().setWidth(340),
        height: ScreenUtil().setHeight(70),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: Row(
                children: const [
                  Icon(
                    Icons.copyright_rounded,
                    size: 40,
                    color: emas,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    "Pencairan Tabungan",
                    style: TextStyle(fontSize: 15),
                  ),
                ],
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(right: 10.0),
              child: Text(">", style: TextStyle(fontSize: 30)),
            ),
          ],
        ),
      ),
    );
  }
}
