import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'styles.dart';

mixin Themes {
  static final lightTheme = ThemeData(
    primaryColor: blackColor,
    scaffoldBackgroundColor: blackColor,
    unselectedWidgetColor: primaryDarkColor,

    // * APPBAR THEME
    appBarTheme: const AppBarTheme(
      // systemOverlayStyle: SystemUiOverlayStyle(
      //   statusBarBrightness: Brightness.dark,
      //   statusBarIconBrightness: Brightness.dark,
      //   statusBarColor: blackColor,
      // ),
      backgroundColor: appbarColor,
      elevation: 0,
      // shadowColor: Colors.white70,
      // iconTheme: const IconThemeData(color: Color(0xFF9B9B9B)),
    ),

    // * DIVIDER THEME
    dividerTheme: DividerThemeData(
      color: primaryDarkColor.withOpacity(0.5),
      thickness: .5,
    ),

    // * TEXT BUTTON THEME
    textButtonTheme: TextButtonThemeData(
      style: ButtonStyle(
        overlayColor:
            MaterialStateColor.resolveWith((states) => splashDarkColor),
      ),
    ),

    // * INPUT FIELD DECORATION
    inputDecorationTheme: InputDecorationTheme(
      enabledBorder: UnderlineInputBorder(
        borderSide: BorderSide(
          color: primaryDarkColor.withOpacity(0.5),
        ),
      ),
      border: UnderlineInputBorder(
        borderSide: BorderSide(
          color: primaryDarkColor.withOpacity(0.5),
        ),
      ),
      focusedBorder: const UnderlineInputBorder(
        borderSide: BorderSide(
          color: primaryDarkColor,
        ),
      ),
      fillColor: primaryDarkColor,
      focusColor: primaryDarkColor,
      contentPadding: EdgeInsets.zero,
      labelStyle: const TextStyle(
        fontSize: 16,
        color: textGrayDarkColor,
        // fontWeight: FontWeight.w500,
      ),
      floatingLabelStyle: const TextStyle(
        fontSize: 20,
        color: hintTextDarkColor,
        fontWeight: FontWeight.w500,
      ),
      errorMaxLines: 4,
      errorStyle: const TextStyle(
        fontSize: 12,
        overflow: TextOverflow.visible,
        fontWeight: FontWeight.w500,
      ),
    ),

    // COMMON
    bottomSheetTheme: const BottomSheetThemeData(
      backgroundColor: Colors.transparent,
      elevation: 0,
    ),

    // fontFamily: GoogleFonts.roboto().fontFamily,

    textSelectionTheme: TextSelectionThemeData(
        selectionColor: primaryDarkColor.withOpacity(0.5)),

    // * ELEVATED BUTTON THEME
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ButtonStyle(
        // shadowColor: MaterialStateProperty.all(blueColor),
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
        elevation: MaterialStateProperty.all(0),
        backgroundColor: MaterialStateProperty.all(blueColor),

        alignment: Alignment.center,
        // padding: MaterialStateProperty.all(EdgeInsets.zero),
        visualDensity: VisualDensity.compact,
        fixedSize: MaterialStateProperty.all(const Size(10000, 30)),
        padding: MaterialStateProperty.all<EdgeInsets>(EdgeInsets.zero),

        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        )),
      ),
    ),

    // * CupertinoDatePicker Theme
    cupertinoOverrideTheme: const CupertinoThemeData(
      textTheme: CupertinoTextThemeData(
        textStyle: TextStyle(fontSize: 16, color: Colors.white),
      ),
    ),
  );
}
