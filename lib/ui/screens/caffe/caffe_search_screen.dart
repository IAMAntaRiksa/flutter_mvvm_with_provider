import 'package:flutter/material.dart';
import 'package:flutter_caffe_ku/core/utils/navigation/navigation_util.dart';
import 'package:flutter_caffe_ku/core/viewmodels/caffe/caffe_provider.dart';
import 'package:flutter_caffe_ku/gen/assets.gen.dart';
import 'package:flutter_caffe_ku/ui/constant/constant.dart';
import 'package:flutter_caffe_ku/ui/widgets/caffe/caffe_item.dart';
import 'package:flutter_caffe_ku/ui/widgets/search/search_item.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class CaffeSearchScreen extends StatelessWidget {
  const CaffeSearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => CaffeProvider(),
      child: const RestaurantInitSearchScreen(),
    );
  }
}

class RestaurantInitSearchScreen extends StatefulWidget {
  const RestaurantInitSearchScreen({super.key});

  @override
  State<RestaurantInitSearchScreen> createState() =>
      _RestaurantInitSearchScreenState();
}

class _RestaurantInitSearchScreenState
    extends State<RestaurantInitSearchScreen> {
  var searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    setStatusBar();
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: _searchWidget(),
        leading: IconButton(
          onPressed: () => navigate.pop(),
          icon: const Icon(Icons.arrow_back),
          color: Colors.white,
        ),
      ),
      body: const RestaurantSearchBody(),
    );
  }

  Widget _searchWidget() {
    return SearchItem(
      controller: searchController,
      autoFocus: true,
      hintText: "Mau Cari APA?",
      color: Colors.white,
      onSubmit: (value) => CaffeProvider.instance(context).search(value),
    );
  }
}

class RestaurantSearchBody extends StatelessWidget {
  const RestaurantSearchBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<CaffeProvider>(
      builder: (context, caffeProv, _) {
        if (caffeProv.searchCaffes == null && !caffeProv.onSearch) {
          return SvgPicture.asset(
            Assets.images.illustrationQuestion.path,
          );
        }

        if (caffeProv.searchCaffes == null && caffeProv.onSearch) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        if (caffeProv.searchCaffes!.isEmpty) {
          return SvgPicture.asset(
            Assets.images.illustrationNotfound.path,
          );
        }

        return ListView.builder(
          shrinkWrap: true,
          itemCount: caffeProv.searchCaffes!.length,
          itemBuilder: (context, index) {
            final caffe = caffeProv.searchCaffes![index];
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                index == 0
                    ? _searchResultWidget(
                        caffeProv.searchCaffes!.length,
                      )
                    : const SizedBox(),
                CaffeItem(
                  caffe: caffe,
                  onClick: () => {},
                ),
              ],
            );
          },
        );
      },
    );
  }

  Widget _searchResultWidget(int total) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: setWidth(40),
        vertical: setHeight(20),
      ),
      child: Row(
        children: [
          Icon(
            Icons.location_on,
            color: primaryColor,
            size: 15,
          ),
          Text(
            "$total Restaurants found",
            style: styleTitle.copyWith(
              fontSize: setFontSize(35),
            ),
          )
        ],
      ),
    );
  }
}
