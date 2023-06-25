import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_caffe_ku/core/viewmodels/theme/theme_provider.dart';
import 'package:flutter_caffe_ku/gen/assets.gen.dart';
import 'package:flutter_caffe_ku/ui/constant/constant.dart';
import 'package:flutter_caffe_ku/ui/constant/themes.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class SettingScreen extends StatelessWidget {
  const SettingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Setting",
          style: styleTitle.copyWith(
            fontSize: setFontSize(55),
            color: isColor(context),
          ),
        ),
      ),
      body: const SettingBody(),
    );
  }
}

class SettingBody extends StatelessWidget {
  const SettingBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(
      builder: (context, themeProv, _) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _settingMenu(
              context: context,
              title: "Mode Gelap",
              description: "Mengaktifkan tema gelap menyeluruh",
              selected: themeProv.theme!,
              iconPath: Assets.icons.iconDrink.path,
              onChange: (value) => themeProv.setThemeDark(value),
            ),
          ],
        );
      },
    );
  }

  Widget _settingMenu({
    required BuildContext context,
    required String title,
    required String description,
    required bool selected,
    required String iconPath,
    required Function(bool) onChange,
  }) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: setWidth(35),
        vertical: setHeight(20),
      ),
      child: Expanded(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SvgPicture.asset(iconPath,
                width: setWidth(55),
                height: setHeight(55),
                color: isColor(context)),
            SizedBox(
              width: setWidth(30),
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: styleTitle.copyWith(
                      fontSize: setFontSize(45),
                      color: isDarkTheme(context) ? Colors.white : blackColor,
                    ),
                  ),
                  Text(
                    description,
                    style: styleSubtitle.copyWith(
                      fontSize: setFontSize(35),
                      color:
                          isDarkTheme(context) ? Colors.white : grayDarkColor,
                    ),
                  )
                ],
              ),
            ),
            CupertinoSwitch(
              value: selected,
              onChanged: (value) => onChange(value),
            )
          ],
        ),
      ),
    );
  }
}
