import 'package:flutter/material.dart';
import 'package:flutter_caffe_ku/ui/constant/constant.dart';

class ChipItem extends StatelessWidget {
  final String name;
  final VoidCallback onClick;
  final bool isFirst;
  final double leftMargin;

  const ChipItem({
    super.key,
    required this.name,
    required this.onClick,
    required this.isFirst,
    this.leftMargin = 40,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
        right: setWidth(20),
        top: setHeight(20),
        bottom: setHeight(20),
        left: isFirst ? setWidth(leftMargin) : 0,
      ),
      decoration: BoxDecoration(
        color: grayColor.withOpacity(0.2),
        borderRadius: BorderRadius.circular(5),
      ),
      child: InkWell(
        onTap: () => onClick(),
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: setWidth(30),
            vertical: setHeight(10),
          ),
          child: Text(
            name,
            style: styleTitle.copyWith(
              fontSize: setFontSize(35),
              color: isColor(context),
            ),
          ),
        ),
      ),
    );
  }
}
