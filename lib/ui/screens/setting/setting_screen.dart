import 'package:flutter/material.dart';
import 'package:flutter_caffe_ku/ui/constant/constant.dart';

class SettingScreen extends StatelessWidget {
  const SettingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text(
        "Setting",
        style: styleTitle.copyWith(
          fontSize: setFontSize(55),
        ),
      )),
    );
  }
}
