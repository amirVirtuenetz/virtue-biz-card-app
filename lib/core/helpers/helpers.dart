import 'package:flutter/material.dart';

double screenWidth(BuildContext context) => MediaQuery.of(context).size.width;
double screenHeight(BuildContext context) => MediaQuery.of(context).size.height;
double screenHeightPercentage(BuildContext context, {double percentage = 1}) =>
    screenHeight(context) * percentage;

double screenWidthPercentage(BuildContext context, {double percentage = 1}) =>
    screenWidth(context) * percentage;
//
// bool mobile(BuildContext context) => Platform.isAndroid || Platform.isIOS;
//
// bool isMobile(BuildContext context) => MediaQuery.of(context).size.width < 650;
// bool isTab(BuildContext context) =>
//     MediaQuery.of(context).size.width < 1300 &&
//     MediaQuery.of(context).size.width >= 650;
// bool isDesktop(BuildContext context) =>
//     MediaQuery.of(context).size.width >= 1600 &&
//     MediaQuery.of(context).size.width > 1000;
//
// bool isTV(BuildContext context) =>
//     MediaQuery.of(context).size.width <= screenWidth(context);
double extraSmallSpace(BuildContext context) =>
    screenWidthPercentage(context) * 0.01;
double smallSpace(BuildContext context, {double space = 0.05}) =>
    screenWidthPercentage(context) * space;

/// for vertical spacing
double extraSmallSpaceVertical(BuildContext context) =>
    screenHeightPercentage(context) * 0.01;
double smallSpaceVertical(BuildContext context, {double space = 0.05}) =>
    screenHeightPercentage(context) * space;

double kToolBarHeight(BuildContext context) =>
    screenHeightPercentage(context) * 0.1125;

/// check landscape mode
bool isLandscape(BuildContext context) =>
    MediaQuery.of(context).orientation == Orientation.landscape;

/// drop down text style
TextStyle dropDownTextStyle = const TextStyle(
    overflow: TextOverflow.ellipsis,
    //te
    // color: AppColors.tertiaryTextColor, //Font color
    fontSize: 15,
    // fontFamily: AppFontFamily.sfProDisplaySemiBold,
    fontWeight: FontWeight.w600);
