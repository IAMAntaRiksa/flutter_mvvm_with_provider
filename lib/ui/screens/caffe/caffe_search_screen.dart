import 'package:flutter/material.dart';
import 'package:flutter_caffe_ku/core/utils/navigation/navigation_util.dart';
import 'package:flutter_caffe_ku/ui/constant/constant.dart';
import 'package:flutter_caffe_ku/ui/widgets/search/search_item.dart';

class CaffeSearchScreen extends StatelessWidget {
  const CaffeSearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const RestaurantInitSearchScreen();
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
  var controller = TextEditingController();
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
      body: Container(),
    );
  }

  Widget _searchWidget() {
    return SearchItem(
      controller: controller,
      autoFocus: true,
      hintText: "Mau Cari APA?",
      color: Colors.white,
    );
  }
}
