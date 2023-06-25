import 'package:flutter/material.dart';
import 'package:flutter_caffe_ku/core/utils/navigation/navigation_util.dart';
import 'package:flutter_caffe_ku/core/viewmodels/caffe/caffe_provider.dart';
import 'package:flutter_caffe_ku/core/viewmodels/connection/connection_provider.dart';
import 'package:flutter_caffe_ku/gen/assets.gen.dart';
import 'package:flutter_caffe_ku/ui/constant/constant.dart';
import 'package:flutter_caffe_ku/ui/route/route_list.dart';
import 'package:flutter_caffe_ku/ui/widgets/caffe/cafe_list.dart';
import 'package:flutter_caffe_ku/ui/widgets/chip/chip_item.dart';
import 'package:flutter_caffe_ku/ui/widgets/idle/idle_item.dart';
import 'package:flutter_caffe_ku/ui/widgets/search/search_item.dart';
import 'package:provider/provider.dart';

class CaffeScreen extends StatelessWidget {
  const CaffeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        toolbarHeight: 70,
        flexibleSpace: Padding(
          padding: EdgeInsets.symmetric(
            vertical: setWidth(55),
          ),
          child: CustomeAppBar(context: context),
        ),
      ),
      body: ChangeNotifierProvider(
        create: (value) => CaffeProvider(),
        child: const CaffeBody(),
      ),
    );
  }
}

class CaffeBody extends StatelessWidget {
  const CaffeBody({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = TextEditingController();

    Future<void> refreshHome(BuildContext context) async {
      final caffeProv = CaffeProvider.instance(context);
      caffeProv.clearCities();
      caffeProv.clearCaffes();
      ConnectionProvider.instance(context).setConnection(true);
    }

    return Consumer<ConnectionProvider>(
      builder: (context, connectionProv, _) {
        if (connectionProv.internetConnected == false) {
          return IdleNoItemCenter(
            title:
                "No internet connection,\nplease check your wifi or mobile data",
            iconPathSVG: Assets.images.illustrationNoConnection.path,
            buttonText: "Retry Again",
            onClickButton: () => refreshHome(context),
          );
        }
        return RefreshIndicator(
          onRefresh: () => refreshHome(context),
          color: isColor(context),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(
                    vertical: setHeight(20),
                    horizontal: setWidth(30),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      InkWell(
                        onTap: () => navigate.pushTo(routeCaffeSearch),
                        child: SearchItem(
                          hintText: "Find Caffe ku",
                          controller: controller,
                          autoFocus: false,
                          enableKeyword: false,
                          color: grayColor.withOpacity(0.15),
                        ),
                      ),
                    ],
                  ),
                ),
                const _CitiesListWidget(),
                const _HeaderWidget(),
                const _CaffeListWidget(),
              ],
            ),
          ),
        );
      },
    );
  }
}

class _HeaderWidget extends StatelessWidget {
  const _HeaderWidget();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: setWidth(40),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Caffe",
            style: styleTitle.copyWith(
              fontSize: setFontSize(55),
              color: isColor(context),
            ),
          ),
          Text(
            "Recommendation Caffe for you",
            style: styleSubtitle.copyWith(
              fontSize: setFontSize(40),
              color: isColor(context),
            ),
          )
        ],
      ),
    );
  }
}

class _CaffeListWidget extends StatelessWidget {
  const _CaffeListWidget();

  @override
  Widget build(BuildContext context) {
    return Consumer<CaffeProvider>(
      builder: (context, caffeProv, _) {
        if (caffeProv.caffes == null && !caffeProv.onSearch) {
          caffeProv.getCaffes();
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        if (caffeProv.caffes == null && caffeProv.onSearch) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        if (caffeProv.caffes!.isEmpty) {
          return IdleNoItemCenter(
            title: "Restaurant not found",
            iconPathSVG: Assets.images.illustrationNotfound.path,
          );
        }

        return CaffeListWidget(
          caffes: caffeProv.caffes!,
        );
      },
    );
  }
}

class _CitiesListWidget extends StatelessWidget {
  const _CitiesListWidget();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: setWidth(35)),
          child: Text(
            "Interesting city to visit",
            style: styleSubtitle.copyWith(
              fontSize: setFontSize(40),
              color: isColor(context),
            ),
          ),
        ),
        Consumer<CaffeProvider>(
          builder: (context, caffeProv, _) {
            if (caffeProv.cities == null && !caffeProv.onSearch) {
              caffeProv.getCities();
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            if (caffeProv.cities == null && caffeProv.onSearch) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }

            if (caffeProv.cities!.isEmpty) {
              return const Column(
                children: [Text("Tidak ad data")],
              );
            }
            return SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: caffeProv.cities!
                    .asMap()
                    .map(
                      (index, value) => MapEntry(
                        index,
                        ChipItem(
                          name: value,
                          onClick: () => {
                            navigate.pushTo(
                              routeCaffeByCities,
                              data: value,
                            )
                          },
                          isFirst: index == 0,
                        ),
                      ),
                    )
                    .values
                    .toList(),
              ),
            );
          },
        )
      ],
    );
  }
}

class CustomeAppBar extends AppBar {
  CustomeAppBar({super.key, required BuildContext context})
      : super(
          elevation: 0,
          backgroundColor: Colors.transparent,
          flexibleSpace: _buildCommerce(context),
        );
  static Widget _buildCommerce(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: setWidth(30)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'CaffeKu...',
                style: styleTitle.copyWith(
                  fontSize: setFontSize(50),
                  color: isColor(context),
                ),
              ),
              Text(
                "_IAMAntaRiksa",
                style: styleSubtitle.copyWith(
                  fontSize: setFontSize(50),
                  color: isColor(context),
                ),
              )
            ],
          ),
          Container(
            height: setHeight(110),
            width: setWidth(120),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: primaryCustomSwatch,
            ),
            child: const Icon(
              Icons.notifications,
              color: Colors.white,
            ),
          )
        ],
      ),
    );
  }
}
