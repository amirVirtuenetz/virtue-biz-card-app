import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';

import '../components/circle_button.dart';
import '../model/user_model.dart';

class BusinessCardTemplate extends StatefulWidget {
  final Color? color;
  final bool? isSocialColorEnabled;
  // final UserDataModel userData;
  final String? userId;
  const BusinessCardTemplate(
      {Key? key,
      this.color,
      this.isSocialColorEnabled,
      // required this.userData,
      this.userId})
      : super(key: key);

  @override
  State<BusinessCardTemplate> createState() => _BusinessCardTemplateState();
}

class _BusinessCardTemplateState extends State<BusinessCardTemplate>
    with SingleTickerProviderStateMixin {
  String facebookImage = "assets/images/facebook.png";
  String googleIcon = "assets/icons/google.svg";
  String instagramImage = "assets/icons/instagram.svg";
  String twitterImage = "assets/images/twitter.png";
  String whatsappImage = "assets/images/twitter.png";

  late Animation<double> animation;
  late AnimationController controller;
  bool isLoading = false;
  Color? textColor;
  @override
  void initState() {
    super.initState();
    getCurrentUserData();
    controller = AnimationController(
      duration: const Duration(milliseconds: 700),
      vsync: this,
    );
    controller.addListener(() {
      setState(() {});
    });
    controller.forward();
    animation = Tween<double>(begin: 1, end: 0).animate(controller);
    Color? backgroundColor = widget.color;
    double? luminance = backgroundColor?.computeLuminance();
    textColor = luminance! > 0.5 ? Colors.black : Colors.white;
  }

  final user = FirebaseAuth.instance.currentUser;
  var userDataModel = UserDataModel();
  Future<void> getCurrentUserData() async {
    isLoading = true;
    setState(() {});
    final userRef =
        FirebaseFirestore.instance.collection('users').doc(widget.userId);
    final userData = await userRef.get();
    if (userData.exists) {
      final data = userData.data()!;
      userDataModel = UserDataModel.fromJson(data);
      log('Retrieved user: ${userDataModel.email}');
      isLoading = false;
      setState(() {});
    } else {
      log('User data not found');
      isLoading = false;
      setState(() {});
    }
  }

  List btnList(BuildContext context) => [
        CircleButton(
          fillColor:
              widget.isSocialColorEnabled == true ? widget.color : Colors.white,
          onPressed: () {},
          child: const Icon(
            Icons.email_outlined,
            size: 35.0,
          ),
        ),
        CircleButton(
          fillColor:
              widget.isSocialColorEnabled == true ? widget.color : Colors.white,
          onPressed: () {},
          child: SvgPicture.asset(googleIcon),
        ),
        CircleButton(
          fillColor:
              widget.isSocialColorEnabled == true ? widget.color : Colors.white,
          onPressed: () {},
          child: const Icon(
            Icons.apple_outlined,
            size: 35.0,
          ),
        ),
        CircleButton(
          fillColor:
              widget.isSocialColorEnabled == true ? widget.color : Colors.white,
          onPressed: () {},
          child: SvgPicture.asset(
            instagramImage,
            width: 35,
            height: 35,
            fit: BoxFit.contain,
          ),
        ),
        CircleButton(
          fillColor:
              widget.isSocialColorEnabled == true ? widget.color : Colors.white,
          onPressed: () {},
          child: Image.asset(
            facebookImage,
            fit: BoxFit.contain,
          ),
        ),
      ];

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(widget.color == Colors.white
        ? SystemUiOverlayStyle.dark
        : SystemUiOverlayStyle.light);
    final customTheme = ThemeData(
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: widget.color,
        ),
      ),
      textTheme: TextTheme(
        bodyText1: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w700,
                color: Colors.white,
                fontFamily: "InterRegular")
            .copyWith(color: Colors.blueAccent),
      ),
    );
    var size = MediaQuery.of(context).size;
    final orientation = MediaQuery.of(context).orientation;
    return Theme(
      data: customTheme,
      child: Scaffold(
        body: isLoading == true
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : Stack(
                children: [
                  Positioned.fill(
                    child: Container(
                      decoration: BoxDecoration(
                        color: widget.color ?? Colors.white12,
                        gradient: LinearGradient(
                          begin: Alignment.bottomCenter,
                          end: Alignment.center,
                          colors: [
                            const Color(0xFFF6F6F6),
                            const Color(0xFFF6F6F6),
                            widget.color
                                as Color // replace yourColorCode with your color code
                          ],
                        ),
                      ),
                    ),
                  ),

                  /// cover photo
                  Positioned(
                    top: kToolbarHeight,
                    child: SizedBox(
                      width: size.width,
                      height: 150,
                      // color: Colors.white,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(0),
                        child: CachedNetworkImage(
                          fit: BoxFit.cover,
                          imageUrl: '${userDataModel.coverUrl}',
                          errorWidget: (context, obj, stackTrace) {
                            return Center(
                              child: Text("Error: ${stackTrace}"),
                            );
                          },
                        ),
                      ),
                    ),
                  ),

                  /// profile pictures
                  Positioned(
                    top: 155,
                    left: size.width / 2.8,
                    child: AnimatedOpacity(
                      duration: const Duration(milliseconds: 700),
                      opacity: controller.value,
                      child: Stack(
                        fit: StackFit.passthrough,
                        children: [
                          Positioned(
                            child: Card(
                              elevation: 5,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(100),
                              ),
                              child: CircleAvatar(
                                radius: 45,
                                backgroundColor: Colors.white,
                                child: CircleAvatar(
                                    radius: 40,
                                    backgroundImage: NetworkImage(
                                        "${userDataModel.photoUrl}")
                                    // AssetImage("assets/avaters/Avatar 6.jpg"),
                                    ),
                              ),
                            ),
                          ),

                          /// company logo
                          Positioned(
                            bottom: 0,
                            right: 0,
                            width: 40,
                            height: 40,
                            child: Container(
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(
                                    color: Colors.blueAccent, width: 1),
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(100),
                                child: CachedNetworkImage(
                                  fit: BoxFit.cover,
                                  width: 40,
                                  height: 40,
                                  imageUrl: '${userDataModel.logoUrl}',
                                  errorWidget: (context, obj, stackTrace) {
                                    return Center(
                                      child: Text("Error: ${stackTrace}"),
                                    );
                                  },
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                    top: 270,
                    width: size.width,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            "${userDataModel.displayName?.toTitleCase()}",
                            style: TextStyle(
                              fontWeight: FontWeight.w700,
                              fontSize: 18,
                              color: textColor,
                              fontFamily: "PoppinsBold",
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 10),
                          child: Text(
                            "${userDataModel.jobTitle?.toTitleCase()} at ${userDataModel.companyName?.toCapitalized()}",
                            style: TextStyle(
                                fontWeight: FontWeight.w400,
                                fontSize: 14,
                                color: textColor,
                                fontFamily: "InterRegular"),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 10),
                          child: Text(
                            "${userDataModel.address?.toTitleCase()}",
                            style: TextStyle(
                                fontWeight: FontWeight.w400,
                                fontSize: 14,
                                color: textColor,
                                fontFamily: "InterRegular"),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 10),
                          child: Text(
                            "${userDataModel.bio?.toCapitalized()}",
                            style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 14,
                                color: textColor,
                                fontFamily: "InterRegular"),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 50, vertical: 10),
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                // backgroundColor: Colors.green,
                                maximumSize: const Size(double.infinity, 40),
                                minimumSize: const Size(double.infinity, 40),
                                elevation: 3,
                                // side: BorderSide(width: 3, color: Colors.brown),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(25),
                                )),
                            onPressed: () {
                              // Navigator.push(
                              //   context,
                              //   MaterialPageRoute(
                              //     builder: (context) => const BusinessCardTemplate(),
                              //   ),
                              // );
                            },
                            child: Text(
                              "Save Contact",
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyLarge
                                  ?.copyWith(
                                    color: textColor,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                    // fontFamily: 'InterRegular',
                                  ),
                              // style: TextStyle(
                              //     fontSize: 14,
                              //     fontWeight: FontWeight.w700,
                              //     color: Colors.white,
                              //     fontFamily: "InterRegular"),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 300,
                          child: GridView.builder(
                              physics: const NeverScrollableScrollPhysics(),
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount:
                                    (orientation == Orientation.portrait)
                                        ? 3
                                        : 4,
                                // maxCrossAxisExtent: 100,
                                childAspectRatio: 3 / 2,
                                crossAxisSpacing: 20,
                                mainAxisSpacing: 20,
                              ),
                              itemCount: btnList(context).length,
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 10),
                              itemBuilder: (BuildContext ctx, index) {
                                return btnList(context)[index];
                                //   GestureDetector(
                                //   onTap: () {},
                                //   child: SizedBox(
                                //     width: MediaQuery.of(context).size.width * 0.09,
                                //     height: MediaQuery.of(context).size.width * 0.09,
                                //     child:
                                //         SvgPicture.asset("assets/icons/email_box.svg"),
                                //   ),
                                // );
                              }),
                        ),
                      ],
                    ),
                  )
                ],
              ),
      ),
    );
  }
}

extension StringExtension on String {
  String capitalize() {
    return "${this[0].toUpperCase()}${substring(1).toLowerCase()}";
  }
}

extension StringCasingExtension on String {
  String toCapitalized() =>
      length > 0 ? '${this[0].toUpperCase()}${substring(1).toLowerCase()}' : '';
  String toTitleCase() => replaceAll(RegExp(' +'), ' ')
      .split(' ')
      .map((str) => str.toCapitalized())
      .join(' ');
}
