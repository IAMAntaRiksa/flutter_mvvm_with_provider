import 'package:flutter/material.dart';
import 'package:flutter_caffe_ku/core/models/caffe/caffe_model.dart';
import 'package:flutter_caffe_ku/core/utils/navigation/navigation_util.dart';
import 'package:flutter_caffe_ku/core/viewmodels/favorite/favorite_provider.dart';
import 'package:flutter_caffe_ku/ui/route/route_list.dart';
import 'package:flutter_caffe_ku/ui/widgets/caffe/caffe_item.dart';
import 'package:provider/provider.dart';

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
    return Consumer<FavoriteProvider>(
      builder: (context, favoriteProv, _) {
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
              onClick: () => {
                useReplacement
                    ? navigate.pushToReplacement(
                        routeCaffeDetail,
                        data: caffe,
                      )
                    : navigate.pushTo(
                        routeCaffeDetail,
                        data: caffe,
                      ),
              },
              onClickFavorite: () => favoriteProv.toogleFavorite(caffe.id),
              isFavorite: favoriteProv.isFavorite(caffe.id),
            );
          },
        );
      },
    );
  }
}
