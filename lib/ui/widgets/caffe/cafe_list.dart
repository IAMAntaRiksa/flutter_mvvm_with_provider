import 'package:flutter/material.dart';
import 'package:flutter_caffe_ku/core/models/caffe/caffe_model.dart';
import 'package:flutter_caffe_ku/ui/widgets/caffe/caffe_item.dart';

class CaffeListWidget extends StatelessWidget {
  final List<CaffeModel> caffes;
  final bool useHero;
  final bool useReplacement;

  const CaffeListWidget({
    super.key,
    required this.caffes,
    this.useHero = true,
    this.useReplacement = false,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: EdgeInsets.zero,
      shrinkWrap: true,
      itemCount: caffes.length,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        CaffeModel caffe = caffes[index];
        return CaffeItem(
          caffe: caffe,
          useHero: useHero,
          onClick: () => {},
        );
      },
    );
  }
}
