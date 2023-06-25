import 'package:flutter/material.dart';
import 'package:flutter_caffe_ku/core/models/caffe/caffe_model.dart';
import 'package:flutter_caffe_ku/core/models/review/create_review_model.dart';
import 'package:flutter_caffe_ku/core/utils/navigation/navigation_util.dart';
import 'package:flutter_caffe_ku/core/viewmodels/caffe/caffe_provider.dart';
import 'package:flutter_caffe_ku/core/viewmodels/connection/connection_provider.dart';
import 'package:flutter_caffe_ku/core/viewmodels/favorite/favorite_provider.dart';
import 'package:flutter_caffe_ku/gen/assets.gen.dart';
import 'package:flutter_caffe_ku/gen/fonts.gen.dart';
import 'package:flutter_caffe_ku/ui/constant/constant.dart';
import 'package:flutter_caffe_ku/ui/constant/themes.dart';
import 'package:flutter_caffe_ku/ui/widgets/caffe/cafe_list.dart';
import 'package:flutter_caffe_ku/ui/widgets/chip/chip_item.dart';
import 'package:flutter_caffe_ku/ui/widgets/idle/idle_item.dart';
import 'package:flutter_caffe_ku/ui/widgets/review/review_item.dart';
import 'package:flutter_caffe_ku/ui/widgets/textfield/custom_textfield.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class CaffeDetailScreen extends StatelessWidget {
  final CaffeModel id;
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
  final CaffeModel id;

  const CaffeInitDetailScreen({super.key, required this.id});

  void refreshHome(BuildContext context) {
    final caffeProv = CaffeProvider.instance(context);
    caffeProv.getCaffe(id.id);
    ConnectionProvider.instance(context).setConnection(true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer2<CaffeProvider, ConnectionProvider>(
        builder: (context, caffeProv, connectionProv, _) {
          if (connectionProv.internetConnected == false) {
            return IdleNoItemCenter(
              title:
                  "No internet connection,\nplease check your wifi or mobile data",
              iconPathSVG: Assets.images.illustrationNoConnection.path,
              buttonText: "Retry Again",
              onClickButton: () => refreshHome(context),
            );
          }
          if (caffeProv.caffe == null && !caffeProv.onSearch) {
            caffeProv.getCaffe(id.id);
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (caffeProv.caffe == null && caffeProv.onSearch) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (caffeProv.caffe!.id.isEmpty) {
            return IdleNoItemCenter(
              title: "Restaurant not found",
              iconPathSVG: Assets.images.illustrationNotfound.path,
            );
          }

          return CaffeDetailSliverBody(
            caffe: caffeProv.caffe!,
          );
        },
      ),
    );
  }
}

class CaffeDetailSliverBody extends StatelessWidget {
  final CaffeModel caffe;
  const CaffeDetailSliverBody({super.key, required this.caffe});

  @override
  Widget build(BuildContext context) {
    return NestedScrollView(
      body: CaffeDetailContentBody(
        caffe: caffe,
      ),
      headerSliverBuilder: (context, innerBoxIsScrolled) {
        return <Widget>[
          SliverAppBar(
            centerTitle: true,
            elevation: 0,
            expandedHeight: deviceHeight * 0.4,
            floating: false,
            pinned: true,
            title: Text(
              caffe.name,
              style: styleTitle.copyWith(
                fontSize: setFontSize(45),
                color: blackColor,
              ),
            ),
            leading: Padding(
              padding: const EdgeInsets.all(10),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                    color: grayColor.withOpacity(0.5),
                    width: 1,
                  ),
                ),
                child: Material(
                  type: MaterialType.transparency,
                  color: Colors.transparent,
                  child: InkWell(
                    borderRadius: BorderRadius.circular(8),
                    onTap: () => navigate.pop(),
                    child: Icon(
                      Icons.keyboard_arrow_left,
                      color: blackColor,
                    ),
                  ),
                ),
              ),
            ),
            flexibleSpace: _flexibleSpace(context),
            backgroundColor: Colors.white,
          )
        ];
      },
    );
  }

  Widget _flexibleSpace(BuildContext context) {
    return FlexibleSpaceBar(
      centerTitle: true,
      collapseMode: CollapseMode.pin,
      background: Stack(
        children: [
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            bottom: 0,
            child: Hero(
              tag: caffe.id,
              child: Image.network(
                caffe.image?.mediumResolution ?? "",
                fit: BoxFit.cover,
              ),
            ),
          ),
          Positioned(
            bottom: -3,
            left: 0,
            right: 0,
            child: Container(
              height: setHeight(80),
              decoration: BoxDecoration(
                color: isDarkTheme(context) ? blackBGColor : Colors.white,
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(50),
                ),
              ),
              child: Center(
                child: Container(
                  width: deviceWidth * 0.12,
                  height: setHeight(15),
                  decoration: BoxDecoration(
                    color: grayColor.withOpacity(0.4),
                    borderRadius: BorderRadius.circular(42),
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 10,
            right: 30,
            child: Consumer<FavoriteProvider>(
              builder: (context, favoriteProv, _) {
                final isFavorite = favoriteProv.isFavorite(caffe.id);
                return Container(
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black12,
                        blurRadius: 5,
                        spreadRadius: 2,
                        offset: Offset(0, 1),
                      ),
                    ],
                  ),
                  child: InkWell(
                    onTap: () => favoriteProv.toogleFavorite(caffe.id),
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: setWidth(30),
                        vertical: setHeight(30),
                      ),
                      child: AnimatedCrossFade(
                        firstChild: Icon(
                          Icons.favorite,
                          color: primaryColor,
                          size: 20,
                        ),
                        secondChild: Icon(
                          Icons.favorite_border,
                          color: primaryColor,
                          size: 20,
                        ),
                        crossFadeState: isFavorite
                            ? CrossFadeState.showFirst
                            : CrossFadeState.showSecond,
                        duration: const Duration(milliseconds: 200),
                      ),
                    ),
                  ),
                );
              },
            ),
          )
        ],
      ),
    );
  }
}

class CaffeDetailContentBody extends StatelessWidget {
  final CaffeModel caffe;
  const CaffeDetailContentBody({
    super.key,
    required this.caffe,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _CaffeDetailInfoWidget(caffe: caffe),
          _CaffeDetailMenuWidget(
            caffe: caffe,
          ),
          _CaffeDetailReviewWidget(
            caffe: caffe,
          ),
          _RestaurantDetailRecommendationsCityWidget(
            city: caffe.city,
            id: caffe.id,
          )
        ],
      ),
    );
  }
}

class _CaffeDetailReviewWidget extends StatefulWidget {
  final CaffeModel caffe;
  const _CaffeDetailReviewWidget({super.key, required this.caffe});

  @override
  State<_CaffeDetailReviewWidget> createState() =>
      _CaffeDetailReviewWidgetState();
}

class _CaffeDetailReviewWidgetState extends State<_CaffeDetailReviewWidget> {
  var reviewController = TextEditingController();

  void sendReview() {
    var caffeProv = CaffeProvider.instance(context);
    caffeProv.createReview(
      CreateReviewModel(
        id: caffeProv.caffe!.id,
        name: "AYAM JAGO",
        review: reviewController.text,
      ),
    );
    reviewController.clear();
    FocusManager.instance.primaryFocus?.unfocus();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: setWidth(50),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Review",
            style: styleTitle.copyWith(
              fontSize: setFontSize(38),
              color: isColor(context),
            ),
          ),
          SizedBox(
            height: setHeight(20),
          ),
          Row(
            children: [
              Expanded(
                child: CustomTextField(
                  controller: reviewController,
                  autoFocus: false,
                  hintText: "Write your review",
                  onSubmit: (value) {},
                  color: Colors.blueGrey.withOpacity(0.3),
                ),
              ),
              SizedBox(
                width: setWidth(30),
              ),
              Container(
                decoration: BoxDecoration(
                  color: primaryColor,
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Material(
                  type: MaterialType.transparency,
                  color: Colors.transparent,
                  child: InkWell(
                    onTap: () => sendReview(),
                    borderRadius: BorderRadius.circular(5),
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: setWidth(35),
                        vertical: setHeight(18),
                      ),
                      child: const Icon(
                        Icons.send,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
          SizedBox(
            height: setHeight(40),
          ),
          widget.caffe.reviews!.isEmpty
              ? Center(
                  child: Text(
                    "No review",
                    style: styleTitle.copyWith(
                      fontSize: setFontSize(40),
                      color: isColor(context),
                    ),
                  ),
                )
              : ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: widget.caffe.reviews!.length,
                  padding: EdgeInsets.zero,
                  itemBuilder: (context, index) {
                    final review = widget.caffe.reviews?[index];
                    return ReviewItem(
                      review: review!,
                    );
                  },
                )
        ],
      ),
    );
  }
}

class CaffeDetailCategoryWidget extends StatelessWidget {
  final CaffeModel caffe;
  const CaffeDetailCategoryWidget({super.key, required this.caffe});

  @override
  Widget build(BuildContext context) {
    return _menuItems(
      title: "Category",
      items: caffe.categories != null
          ? caffe.categories!.map((e) => e.name).toList()
          : [],
      context: context,
    );
  }

  Widget _menuItems({
    required String title,
    required List<String> items,
    required BuildContext context,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: styleTitle.copyWith(
            fontSize: setFontSize(40),
            color: isColor(context),
          ),
        ),
        SizedBox(
          height: setHeight(10),
        ),
        SingleChildScrollView(
          child: Row(
            children: items
                .asMap()
                .map(
                  (index, value) => MapEntry(
                    index,
                    ChipItem(
                      name: value,
                      onClick: () {},
                      isFirst: false,
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

class _CaffeDetailInfoWidget extends StatefulWidget {
  final CaffeModel caffe;
  const _CaffeDetailInfoWidget({super.key, required this.caffe});

  @override
  State<_CaffeDetailInfoWidget> createState() => _CaffeDetailInfoWidgetState();
}

class _CaffeDetailInfoWidgetState extends State<_CaffeDetailInfoWidget> {
  bool viewMore = false;

  void toggleViewMore() {
    setState(() {
      viewMore = !viewMore;
    });
  }

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
            widget.caffe.name,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: styleTitle.copyWith(
              fontSize: setFontSize(55),
              color: isColor(context),
            ),
          ),
          SizedBox(
            height: setHeight(5),
          ),
          Row(
            children: [
              RatingBar(
                initialRating: widget.caffe.rating,
                minRating: 1,
                direction: Axis.horizontal,
                allowHalfRating: true,
                ignoreGestures: true,
                itemCount: 5,
                itemSize: 13,
                ratingWidget: RatingWidget(
                  full: const Icon(
                    Icons.star,
                    color: Colors.amber,
                  ),
                  half: const Icon(
                    Icons.star_half,
                    color: Colors.amber,
                  ),
                  empty: const Icon(
                    Icons.star_border,
                    color: Colors.amber,
                  ),
                ),
                onRatingUpdate: (rating) {
                  debugPrint(rating.toString());
                },
              ),
              Text(
                " (${widget.caffe.rating.toString()})",
                style: styleSubtitle.copyWith(
                  fontSize: setFontSize(30),
                  color: isColor(context),
                ),
              ),
              SizedBox(
                height: setHeight(10),
              ),
            ],
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Icon(
                Icons.location_on,
                color: Colors.red,
                size: 15,
              ),
              SizedBox(
                width: setWidth(5),
              ),
              Expanded(
                child: Text(
                  (widget.caffe.address!.isNotEmpty
                          ? "${widget.caffe.address}, "
                          : "") +
                      widget.caffe.city,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: styleSubtitle.copyWith(
                    fontSize: setFontSize(35),
                    color: isColor(context),
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: EdgeInsets.symmetric(
              vertical: setHeight(10),
            ),
            child: Divider(
              color: blackColor.withOpacity(0.5),
            ),
          ),
          CaffeDetailCategoryWidget(
            caffe: widget.caffe,
          ),
          SizedBox(
            height: setHeight(10),
          ),
          Text(
            "Description",
            style: styleTitle.copyWith(
              fontSize: setFontSize(38),
              color: isColor(context),
            ),
          ),
          SizedBox(
            height: setHeight(10),
          ),
          InkWell(
            onTap: () => toggleViewMore(),
            child: RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: viewMore == true
                        ? widget.caffe.description
                        : "${widget.caffe.description.substring(0, widget.caffe.description.length ~/ 2)}...",
                    style: styleSubtitle.copyWith(
                      fontSize: setFontSize(38),
                      color: isColor(context),
                      fontFamily: FontFamily.poppins,
                    ),
                  ),
                  TextSpan(
                    text: viewMore == false ? "View More" : "",
                    style: styleTitle.copyWith(
                      fontSize: setFontSize(38),
                      color: primaryColor,
                      fontFamily: FontFamily.poppins,
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _CaffeDetailMenuWidget extends StatelessWidget {
  final CaffeModel caffe;
  const _CaffeDetailMenuWidget({super.key, required this.caffe});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: setHeight(40),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: setWidth(40),
            ),
            child: Text(
              "Menus",
              style: styleTitle.copyWith(
                fontSize: setFontSize(38),
                color: isColor(context),
              ),
            ),
          ),
          SizedBox(
            height: setHeight(10),
          ),
          _menuItems(
            title: "Foods",
            iconPath: Assets.icons.iconFood.path,
            items: caffe.menus != null
                ? caffe.menus!.foods.map((e) => e.name).toList()
                : [],
            context: context,
          ),
          SizedBox(
            height: setHeight(20),
          ),
          _menuItems(
            title: "Drinks",
            iconPath: Assets.icons.iconDrink.path,
            items: caffe.menus != null
                ? caffe.menus!.drinks.map((e) => e.name).toList()
                : [],
            context: context,
          )
        ],
      ),
    );
  }

  Widget _menuItems({
    required String title,
    required String iconPath,
    required List<String> items,
    required BuildContext context,
  }) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: setHeight(40)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: styleTitle.copyWith(
              fontSize: setFontSize(40),
              color: isColor(context),
            ),
          ),
          SizedBox(
            height: setHeight(10),
          ),
          Row(
            children: [
              SvgPicture.asset(
                iconPath,
                width: setWidth(40),
                height: setHeight(40),
                color: primaryColor,
              ),
              SizedBox(
                width: setWidth(10),
              ),
              Text(
                title,
                style: styleTitle.copyWith(
                  fontSize: setFontSize(35),
                  color: isColor(context),
                ),
              ),
            ],
          ),
          SizedBox(
            height: setHeight(10),
          ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: items
                  .asMap()
                  .map(
                    (index, value) => MapEntry(
                      index,
                      ChipItem(
                        name: value,
                        onClick: () {},
                        isFirst: false,
                      ),
                    ),
                  )
                  .values
                  .toList(),
            ),
          )
        ],
      ),
    );
  }
}

class _RestaurantDetailRecommendationsCityWidget extends StatelessWidget {
  final String city;
  final String id;
  const _RestaurantDetailRecommendationsCityWidget({
    Key? key,
    required this.city,
    required this.id,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(
            horizontal: setWidth(40),
          ),
          child: Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Another Restaurants in $city",
                    style: styleTitle.copyWith(
                      fontSize: setFontSize(38),
                      color: isColor(context),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        Consumer<CaffeProvider>(
          builder: (context, caffeProv, _) {
            if (caffeProv.caffes == null && !caffeProv.onSearch) {
              caffeProv.getCaffes();
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            if (caffeProv.caffe == null && caffeProv.onSearch) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }

            if (caffeProv.caffe!.id.isEmpty) {
              return const Column(
                children: [Text("Tidak ad data")],
              );
            }
            return CaffeListWidget(
              caffes: caffeProv.caffes!
                  .where((eCaffe) => eCaffe.city == city && eCaffe.id != id)
                  .toList(),
              useHero: false,
              useReplacement: true,
            );
          },
        )
      ],
    );
  }
}
