import 'package:flutter/material.dart';
import 'package:flutter_caffe_ku/core/utils/navigation/navigation_util.dart';
import 'package:flutter_caffe_ku/core/viewmodels/caffe/caffe_provider.dart';
import 'package:flutter_caffe_ku/gen/assets.gen.dart';
import 'package:flutter_caffe_ku/ui/constant/constant.dart';
import 'package:flutter_caffe_ku/ui/route/route_list.dart';
import 'package:flutter_caffe_ku/ui/widgets/caffe/caffe_item.dart';
import 'package:flutter_caffe_ku/ui/widgets/idle/idle_item.dart';
import 'package:provider/provider.dart';

import '../../../core/viewmodels/favorite/favorite_provider.dart';

class FavoriteScreen extends StatelessWidget {
  const FavoriteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Favorite",
          style: styleTitle.copyWith(
            fontSize: setFontSize(55),
            color: isColor(context),
          ),
        ),
      ),
      body: ChangeNotifierProvider(
        create: (context) => CaffeProvider(),
        child: const FavoriteBody(),
      ),
    );
  }
}

class FavoriteBody extends StatelessWidget {
  const FavoriteBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer2<CaffeProvider, FavoriteProvider>(
      builder: (context, caffeProv, favoriteProv, _) {
        if (caffeProv.caffeFavorites == null && !caffeProv.onSearch) {
          caffeProv.getCaffeFavorites(favoriteProv.favorites!);
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        if (caffeProv.caffeFavorites == null && caffeProv.onSearch) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        if (caffeProv.caffeFavorites!.isEmpty) {
          return IdleNoItemCenter(
            title: "Restaurant not found",
            iconPathSVG: Assets.images.illustrationNotfound.path,
          );
        }

        return ListView.builder(
          shrinkWrap: true,
          itemCount: caffeProv.caffeFavorites!.length,
          itemBuilder: (context, index) {
            final caffe = caffeProv.caffeFavorites![index];
            bool isFavorite = favoriteProv.isFavorite(caffe.id);
            return CaffeItem(
              caffe: caffe,
              onClick: () => navigate.pushTo(
                routeCaffeDetail,
                data: caffe,
              ),
              onClickFavorite: () {
                favoriteProv.toogleFavorite(caffe.id);
                if (isFavorite) {
                  caffeProv.removeFavorite(caffe.id);
                }
              },
              isFavorite: isFavorite,
            );
          },
        );
      },
    );
  }
}
