import 'package:flutter_caffe_ku/core/models/caffe/caffe_model.dart';

class CaffeDummyService {
  List<CaffeModel> getFruits() {
    return <CaffeModel>[
      CaffeModel(
        id: "1",
        name: "Apple",
        rating: 3.4,
        city: "Medan",
        image: CaffeImageModel(
            smallResolution:
                "https://thumbs.dreamstime.com/z/red-apple-28018787.jpg"),
        description: 'Appel Dari Medan',
      ),
      CaffeModel(
        id: "2",
        name: "Orange",
        rating: 4.5,
        city: "Bandung",
        image: CaffeImageModel(
            smallResolution:
                "https://thumbs.dreamstime.com/z/half-orange-orange-38274077.jpg"),
        description: 'Orange Dari Bandung',
      ),
      CaffeModel(
        id: "3",
        name: "Watermelon",
        rating: 3.6,
        city: "Jawa tengah",
        image: CaffeImageModel(
            smallResolution:
                "https://thumbs.dreamstime.com/z/watermelon-cut-slice-isolated-white-background-as-package-design-element-77206200.jpg"),
        description: 'Watermelon Dari Jawa tengah',
      ),
      CaffeModel(
        id: "4",
        name: "Lemon",
        rating: 4.6,
        city: "jakarta",
        image: CaffeImageModel(
            smallResolution:
                "https://thumbs.dreamstime.com/z/fresh-lemon-isolated-white-background-38607016.jpg"),
        description: 'Lemon Dari Jawa jakarta',
      ),
      CaffeModel(
        id: "5",
        name: "Soursop",
        rating: 4.5,
        city: "Medan",
        image: CaffeImageModel(
            smallResolution:
                "https://thumbs.dreamstime.com/z/soursop-prickly-custard-apple-isolated-white-background-soursop-prickly-custard-apple-isolated-white-133093302.jpg"),
        description: 'Lemon Dari Jawa jakarta',
      ),
      CaffeModel(
        id: "6",
        name: "Pawpaw",
        rating: 5.0,
        city: "Suatra Selatan",
        image: CaffeImageModel(
            smallResolution:
                "https://thumbs.dreamstime.com/z/papaya-fruits-isolated-white-background-63334963.jpg"),
        description: 'Lemon Dari Jawa jakarta',
      ),
    ];
  }
}
