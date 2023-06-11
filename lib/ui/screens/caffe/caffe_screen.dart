import 'package:flutter/material.dart';
import 'package:flutter_caffe_ku/core/services/caffe/caffe_dummy.dart';
import 'package:flutter_caffe_ku/core/utils/navigation/navigation_util.dart';
import 'package:flutter_caffe_ku/ui/constant/constant.dart';
import 'package:flutter_caffe_ku/ui/route/route_list.dart';
import 'package:flutter_caffe_ku/ui/widgets/caffe/cafe_list.dart';
import 'package:flutter_caffe_ku/ui/widgets/chip/chip_item.dart';
import 'package:flutter_caffe_ku/ui/widgets/search/search_item.dart';

class CaffeScreen extends StatelessWidget {
  const CaffeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    setStatusBar();
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        toolbarHeight: 70,
        flexibleSpace: Padding(
          padding: EdgeInsets.symmetric(
            vertical: setWidth(55),
          ),
          child: CustomeAppBar(),
        ),
      ),
      body: const CaffeBody(),
    );
  }
}

class CaffeBody extends StatelessWidget {
  const CaffeBody({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = TextEditingController();

    return SingleChildScrollView(
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
            ),
          ),
          Text(
            "Recommendation Caffe for you",
            style: styleSubtitle.copyWith(
              fontSize: setFontSize(40),
              color: grayDarkColor,
            ),
          )
        ],
      ),
    );
  }
}

class _CaffeListWidget extends StatelessWidget {
  const _CaffeListWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return CaffeListWidget(
      caffes: CaffeDummyService().getFruits(),
    );
  }
}

class _CitiesListWidget extends StatelessWidget {
  const _CitiesListWidget({super.key});

  @override
  Widget build(BuildContext context) {
    List<String> cities = [
      'Medan',
      'Palembang',
      'Lampung',
      'Riau',
      'Padang',
      'Bandung',
      'Jakarta',
      'Surabaya',
      'Gombong',
      'Semarang',
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: setWidth(35)),
          child: Text(
            "Interesting city to visit",
            style: styleSubtitle.copyWith(
              fontSize: setFontSize(40),
              color: grayDarkColor,
            ),
          ),
        ),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: cities
                .asMap()
                .map(
                  (index, value) => MapEntry(
                    index,
                    ChipItem(
                      name: value,
                      onClick: () => {},
                      isFirst: index == 0,
                    ),
                  ),
                )
                .values
                .toList(),
          ),
        )
      ],
    );
  }
}

class CustomeAppBar extends AppBar {
  CustomeAppBar({super.key})
      : super(
          elevation: 0,
          backgroundColor: Colors.transparent,
          flexibleSpace: _buildCommerce(),
        );
  static Widget _buildCommerce() {
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
                'Welcome..',
                style: styleTitle.copyWith(
                  fontSize: setFontSize(50),
                  color: blackColor,
                ),
              ),
              Text(
                "IMAM AKBAR MEGA ANTARIKSA",
                style: styleSubtitle.copyWith(
                  fontSize: setFontSize(50),
                  color: blackColor,
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
