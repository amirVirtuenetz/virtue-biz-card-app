import 'dart:developer';

import 'package:biz_card/core/helpers/helpers.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../components/circle_button.dart';
import '../model/user_model.dart';
import '../providers/user_provider.dart';

class BusinessCardTemplate extends ConsumerStatefulWidget {
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
  ConsumerState<BusinessCardTemplate> createState() =>
      _BusinessCardTemplateState();
}

class _BusinessCardTemplateState extends ConsumerState<BusinessCardTemplate>
    with SingleTickerProviderStateMixin {
  String facebookImage = "assets/icons/facebook.svg";
  String googleIcon = "assets/icons/google.svg";
  String instagramImage = "assets/icons/instagram.svg";
  String twitterImage = "assets/images/twitter.png";
  String whatsappImage = "assets/images/whatsapp.png";
  // String gmailIcon = "assets/icons/gmail-svg.svg";

  late var userpro;

  late Animation<double> animation;
  late AnimationController controller;
  bool isLoading = false;
  Color? textColor;
  @override
  void initState() {
    super.initState();
    userpro = ref.read(userProvider);
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
    log("User Id coming from query params : ${widget.userId}");
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
      log('Retrieved user: ${userDataModel.photoUrl}');
      isLoading = false;
      setState(() {});
    } else {
      log('User data not found');
      isLoading = false;
      setState(() {});
    }
  }

  List btnList(BuildContext context) => [
        Padding(
          padding: const EdgeInsets.all(kIsWeb ? 30.0 : 0.0),
          child: CircleButton(
            fillColor: widget.isSocialColorEnabled == true
                ? widget.color
                : Colors.white,
            onPressed: () {},
            child: const Icon(
              Icons.email_outlined,
              size: 35.0,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(kIsWeb ? 30.0 : 0.0),
          child: CircleButton(
            fillColor: widget.isSocialColorEnabled == true
                ? widget.color
                : Colors.white,
            onPressed: () {},
            child: SvgPicture.asset(
              googleIcon,
              width: 30,
              height: 30,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(kIsWeb ? 30.0 : 0.0),
          child: CircleButton(
            fillColor: widget.isSocialColorEnabled == true
                ? widget.color
                : Colors.white,
            onPressed: () {},
            child: const Icon(
              Icons.apple_outlined,
              size: 40.0,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(kIsWeb ? 30.0 : 0.0),
          child: CircleButton(
            fillColor: widget.isSocialColorEnabled == true
                ? widget.color
                : Colors.white,
            onPressed: () {},
            child: SvgPicture.asset(
              instagramImage,
              width: 30,
              height: 30,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(kIsWeb ? 30.0 : 0.0),
          child: CircleButton(
            fillColor: widget.isSocialColorEnabled == true
                ? widget.color
                : Colors.white,
            onPressed: () {},
            child: SvgPicture.asset(
              facebookImage,
              width: 30,
              height: 30,
              color: const Color(0XFF3B5998),
            ),
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
    );
    var size = MediaQuery.of(context).size;
    final orientation = MediaQuery.of(context).orientation;
    return Theme(
      data: customTheme,
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          scrolledUnderElevation: 0,
          backgroundColor: widget.color,
          automaticallyImplyLeading: false,
          // leading: IconButton(
          //   onPressed: () {
          //     Navigator.of(context).pop();
          //   },
          //   icon: Icon(
          //     Icons.arrow_back_outlined,
          //     color: textColor,
          //   ),
          // ),
        ),
        body: isLoading == true
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : SingleChildScrollView(
                child: Stack(
                  children: [
                    Container(
                      height: screenHeight(context),
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

                    /// cover photo
                    Positioned(
                      top: kToolbarHeight - 20,
                      child: SizedBox(
                        width: size.width,
                        height: 150,
                        // color: Colors.white,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(0),
                          child: CachedNetworkImage(
                            fit: BoxFit.cover,
                            httpHeaders: const {
                              "Access-Control-Allow-Origin": '*',
                              "Access-Control-Allow-Headers": '*'
                            },
                            imageUrl: '${userDataModel.coverUrl}',
                            errorWidget: (context, obj, stackTrace) {
                              return const Center(
                                child: Icon(Icons.error_outline_outlined),
                              );
                            },
                          ),
                        ),
                      ),
                    ),

                    /// profile pictures
                    Positioned(
                      top: 140,
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
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(100),
                                    child: CachedNetworkImage(
                                      fit: BoxFit.fill,
                                      // width: 40,
                                      // height: 40,
                                      httpHeaders: const {
                                        "Access-Control-Allow-Origin": '*',
                                        "Access-Control-Allow-Headers": '*'
                                      },
                                      imageUrl: '${userDataModel.photoUrl}',
                                      errorWidget: (context, obj, stackTrace) {
                                        return const Center(
                                          child: Icon(
                                              Icons.error_outline_outlined),
                                        );
                                      },
                                    ),
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
                                    httpHeaders: const {
                                      "Access-Control-Allow-Origin": '*',
                                      "Access-Control-Allow-Headers": '*'
                                    },
                                    imageUrl: '${userDataModel.logoUrl}',
                                    errorWidget: (context, obj, stackTrace) {
                                      return const Center(
                                        child:
                                            Icon(Icons.error_outline_outlined),
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
                      top: 250,
                      width: size.width,
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
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
                                //     builder: (context) => SliverScreen(
                                //       color: Colors.yellow,
                                //       userId: user?.uid,
                                //     ),
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
                            child: StreamBuilder<QuerySnapshot>(
                              stream: userpro.getSubCollectionData(),
                              builder: (BuildContext context,
                                  AsyncSnapshot<QuerySnapshot> snapshot) {
                                if (snapshot.hasError) {
                                  return Center(
                                      child: Text('Error: ${snapshot.error}'));
                                }
                                switch (snapshot.connectionState) {
                                  case ConnectionState.waiting:
                                    return const Center(
                                        child: CircularProgressIndicator());
                                  default:
                                    return snapshot.data!.docs.isEmpty
                                        ? const SizedBox.shrink()
                                        : GridView.builder(
                                            physics:
                                                const NeverScrollableScrollPhysics(),
                                            gridDelegate:
                                                SliverGridDelegateWithFixedCrossAxisCount(
                                              crossAxisCount: (orientation ==
                                                      Orientation.portrait)
                                                  ? 3
                                                  : 4,
                                              childAspectRatio:
                                                  kIsWeb ? 4 / 2 : 3 / 2.2,
                                              crossAxisSpacing: 20,
                                              mainAxisSpacing: 20,
                                            ),
                                            itemCount:
                                                snapshot.data?.docs.length,
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 10, vertical: 10),
                                            itemBuilder:
                                                (BuildContext ctx, index) {
                                              DocumentSnapshot document =
                                                  snapshot.data!.docs[index];
                                              String data = document
                                                  .get("data")
                                                  .toString();
                                              return CircleButton(
                                                fillColor:
                                                    widget.isSocialColorEnabled ==
                                                            true
                                                        ? widget.color
                                                        : Colors.white,
                                                onPressed: () =>
                                                    userpro.openLink(data),
                                                child: document
                                                            .get('type')
                                                            .toString()
                                                            .toLowerCase() ==
                                                        "email"
                                                    ? SvgPicture.asset(
                                                        "assets/icons/gmail-svg.svg",
                                                        width: 40,
                                                        height: 40,
                                                      )
                                                    : document
                                                                .get('type')
                                                                .toString()
                                                                .toLowerCase() ==
                                                            "linkedin"
                                                        ? const Icon(
                                                            FontAwesomeIcons
                                                                .linkedin,
                                                            size: 30,
                                                          )
                                                        : document
                                                                    .get("type")
                                                                    .toString()
                                                                    .toLowerCase() ==
                                                                "instagram"
                                                            ? SvgPicture.asset(
                                                                instagramImage,
                                                                width: 30,
                                                                height: 30,
                                                              )
                                                            : document
                                                                        .get(
                                                                            'type')
                                                                        .toString()
                                                                        .toLowerCase() ==
                                                                    "number"
                                                                ? const Icon(
                                                                    FontAwesomeIcons
                                                                        .phone,
                                                                    size: 30,
                                                                  )
                                                                : const Icon(Icons
                                                                    .add_outlined),
                                              );
                                              // btnList(context)[index];
                                            });
                                }
                              },
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
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
