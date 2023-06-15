import 'package:flutter/material.dart';
import 'package:flutter_caffe_ku/core/utils/navigation/navigation_util.dart';
import 'package:flutter_caffe_ku/core/viewmodels/caffe/caffe_provider.dart';
import 'package:flutter_caffe_ku/ui/constant/constant.dart';
import 'package:flutter_caffe_ku/ui/widgets/caffe/cafe_list.dart';
import 'package:provider/provider.dart';

class CaffeCitiesScreen extends StatelessWidget {
  final String city;
  const CaffeCitiesScreen({
    Key? key,
    required this.city,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text(
          "Restaurants in $city",
          style: styleTitle.copyWith(
            fontSize: setFontSize(55),
            color: Colors.white,
          ),
        ),
        leading: IconButton(
          onPressed: () => navigate.pop(),
          icon: const Icon(Icons.arrow_back),
          color: Colors.white,
        ),
      ),
      body: ChangeNotifierProvider(
        create: (context) => CaffeProvider(),
        child: CaffeCitiesBody(
          city: city,
        ),
      ),
    );
  }
}

class CaffeCitiesBody extends StatelessWidget {
  final String city;
  const CaffeCitiesBody({super.key, required this.city});

  @override
  Widget build(BuildContext context) {
    return Consumer<CaffeProvider>(
      builder: (context, caffeProv, _) {
        if (caffeProv.caffesByCity == null && !caffeProv.onSearch) {
          caffeProv.getRestaurantsByCity(city);
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        if (caffeProv.caffesByCity == null && caffeProv.onSearch) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        if (caffeProv.caffesByCity!.isEmpty) {
          return const Column(
            children: [Text("Tidak ad data")],
          );
        }
        return CaffeListWidget(
          caffes: caffeProv.caffesByCity!,
        );
      },
    );
  }
}
