import 'package:flutter/material.dart';
import 'package:flutter_caffe_ku/core/models/caffe/caffe_model.dart';
import 'package:flutter_caffe_ku/core/viewmodels/caffe/caffe_provider.dart';
import 'package:flutter_caffe_ku/ui/constant/constant.dart';
import 'package:provider/provider.dart';

class CaffeDetailScreen extends StatelessWidget {
  final CaffeModel? id;
  const CaffeDetailScreen({super.key, required this.id});
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => CaffeProvider(),
      child: CaffeInitDetailScreen(id: id),
    );
  }
}

class CaffeInitDetailScreen extends StatelessWidget {
  final CaffeModel? id;
  const CaffeInitDetailScreen({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          id?.id ?? '',
          style: styleSubtitle.copyWith(
            fontSize: setFontSize(70),
            color: Colors.black,
          ),
        ),
      ),
      body: Container(),
    );
  }
}
