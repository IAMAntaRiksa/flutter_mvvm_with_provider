import 'package:flutter/material.dart';
import 'package:flutter_caffe_ku/ui/constant/constant.dart';

class SearchItem extends StatelessWidget {
  final Function(String)? onChange;
  final Function(String)? onSubmit;
  final TextEditingController controller;
  final bool readOnly;
  final bool autoFocus;
  final String hintText;
  final bool enableKeyword;
  final Color? color;
  const SearchItem({
    super.key,
    required this.controller,
    this.onChange,
    this.onSubmit,
    this.readOnly = false,
    this.enableKeyword = true,
    this.color,
    required this.autoFocus,
    required this.hintText,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      decoration: BoxDecoration(
        color: color,
        border: Border.all(
          color: Colors.black12.withOpacity(0.05),
        ),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.search,
              size: 20,
              color: isColor(context),
            ),
            const SizedBox(width: 5),
            Expanded(
              child: TextField(
                enabled: enableKeyword,
                controller: controller,
                textInputAction: TextInputAction.done,
                keyboardType: TextInputType.text,
                readOnly: readOnly,
                autofocus: autoFocus,
                style: TextStyle(
                  fontSize: setFontSize(40),
                  color: Colors.black,
                  fontWeight: FontWeight.w600,
                ),
                onChanged: (value) => onChange!(value) ?? {},
                onSubmitted: (value) => onSubmit!(value) ?? {},
                decoration: InputDecoration(
                  hintText: hintText,
                  border: InputBorder.none,
                  focusedBorder: InputBorder.none,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
