import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HubunginKami extends StatelessWidget {
  const HubunginKami({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomRight,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
               Text("Hubungi kami", style: TextStyle(fontSize: ScreenUtil().setSp(12)),),
              SizedBox(
                width: ScreenUtil().setWidth(5),
              ),
              const Divider(),
              const Icon(
                Icons.phone,
                color: Colors.green,
              )
            ],
          ),
          height: ScreenUtil().setHeight(50),
          width: ScreenUtil().setWidth(150),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(50),
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 5,
                  blurRadius: 7,
                  offset: const Offset(0, 3), // changes position of shadow
                ),
              ]),
        ),
      ),
    );
  }
}
