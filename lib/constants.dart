import 'package:flutter/material.dart';

Color tRed = const Color(0xFFDA4040);
Color tBlue = const Color(0xFF5F52EE);
Color tBlack = const Color(0xFF3A3A3A);
Color tred = const Color(0xFFDA4040);
Color tGray = const Color(0xFF3F4040);
Color tWhite = const Color(0xFFEEEFF5);
Color pureWhite = const Color(0xFFFFFFFF);
Color tBlackBg = const Color(0xFF000000);
Color temp = const Color(0xFF000000);
Color textWhite = const Color(0xFFFFFFFF);
Color textBlack = const Color(0xFF000000);
Color yellow = const Color(0xFFF1C843);

class ColorConstants {
  static List<Color> colorList = [
    tBlack,
    tGray,
    tWhite,
    tBlackBg,
    pureWhite,
    textBlack,
    textWhite,
    yellow,
    tBlue
  ];
  void changeTheme() {
    temp = colorList[3];
    colorList[3] = colorList[2];
    colorList[2] = temp;

    temp = colorList[4];
    colorList[4] = colorList[1];
    colorList[1] = temp;

    temp = colorList[5];
    colorList[5] = colorList[6];
    colorList[6] = temp;

    temp = colorList[7];
    colorList[7] = colorList[8];
    colorList[8] = temp;
  }
}

getSnackbar(String text, BuildContext context) {
  var snackbar = SnackBar(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      behavior: SnackBarBehavior.floating,
      duration: const Duration(seconds: 5),
      backgroundColor: Colors.grey,
      content: SizedBox(
        height: 20,
        child: Center(
          child: Text(
            text,
            style: TextStyle(color: Colors.black, fontSize: 20),
          ),
        ),
      ));
  ScaffoldMessenger.of(context).showSnackBar(snackbar);
}
