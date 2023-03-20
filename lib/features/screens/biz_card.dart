import 'dart:developer';
import 'dart:io';

import 'package:biz_card/features/model/user_model.dart';
import 'package:biz_card/features/model/user_module.dart';
import 'package:biz_card/features/screens/widgets/add_info_card.dart';
import 'package:biz_card/features/screens/widgets/icon_text_button.dart';
import 'package:biz_card/features/socialLink/social_link_screen.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';

import '../../core/helpers/auth_enum.dart';
import '../../core/helpers/key_constant.dart';
import '../cardTemplate/business_card_screen.dart';
import '../components/app_text_field.dart';
import '../components/color_picker_diget.dart';
import '../components/contact_card.dart';
import '../components/rich_text_field.dart';
import '../components/text_button.dart';
import '../providers/user_provider.dart';
import '../services/shared_preference.dart';

// var switchProvider = StateProvider((ref) => false);

class BizCardMain extends ConsumerStatefulWidget {
  const BizCardMain({
    super.key,
  });

  @override
  ConsumerState<BizCardMain> createState() => _BizCardMainState();
}

class _BizCardMainState extends ConsumerState<BizCardMain>
    with TickerProviderStateMixin {
  late AnimationController animateController;

  ImagePicker picker = ImagePicker();
  File? coverImage;
  File? profileImage;
  File? logoImage;
  late var userpro;

  /// color picker list
  final List<Color> colors = <Color>[
    const Color(0XFFFFFFFF),
    Colors.black,
    Colors.blue,
    // Colors.red,
    Colors.redAccent,
    const Color(0XFF3E54AC),
    // const Color(0XFFECF2FF),
    const Color(0XFF181823),
    const Color(0XFF18122B),
    // const Color(0XFF03001C),
  ];
  Color selectedColor = Colors.black;
  bool loading = false;
  UserDataModel userData = UserDataModel();

  /// sharedPreference
  final SharePreferencesClass pref = SharePreferencesClass();

  @override
  initState() {
    super.initState();
    userpro = ref.read(userProvider);
    log("initState  : ${userpro.isLoading}");
    userpro.getDataFromFireStore().then((value) {
      log("Cover Image: ${userpro.userModel.coverUrl}");
      userpro.cardTitleController.text = userpro.userModel.cardTitle.toString();
      userpro.nameController.text = userpro.userModel.displayName.toString();
      userpro.jobTitleController.text = userpro.userModel.jobTitle.toString();
      userpro.companyController.text = userpro.userModel.companyName.toString();
      userpro.addressController.text = userpro.userModel.address.toString();
      userpro.bioController.text = userpro.userModel.bio.toString();
    });

    animateController = BottomSheet.createAnimationController(this);
    // Animation duration for displaying the BottomSheet
    animateController.duration = const Duration(milliseconds: 500);
    // Animation duration for retracting the BottomSheet
    animateController.reverseDuration = const Duration(milliseconds: 300);
    // Set animation curve duration for the BottomSheet
    animateController.drive(CurveTween(curve: Curves.bounceInOut));
    pref.getStringData(UsersKey.randomUserKey).then((value) {
      userData = userDataModelFromJson(value.toString());
      log("Locally User Data in model: ${userData.email}");
    });
  }

  @override
  void dispose() {
    ref.read(userProvider).dispose();
    animateController.dispose();
    super.dispose();
  }

  void onUploadCoverImage() async {
    log("this function in the consumer widget");
    // await auth.getDataFromFireStore();
    await userpro.uploadAndGetUrl(
        image: coverImage, types: ImageTypes.coverImage);
  }

  void onUploadProfileImage() async {
    log("this function in the consumer widget");
    await userpro.uploadAndGetUrl(
        image: profileImage, types: ImageTypes.profileImage);
  }

  void onUploadLogoImage() async {
    log("this function in the consumer widget");
    await userpro.uploadAndGetUrl(
        image: logoImage, types: ImageTypes.logoImage);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        extendBody: true,
        appBar: AppBar(
          // title: const Text("Add Detail"),
          elevation: 0,
          scrolledUnderElevation: 0,
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.only(bottom: kBottomNavigationBarHeight),
            child:
                // userpro.isLoading == true
                //   ? const Center(
                //       child: CircularProgressIndicator(),
                //     )
                //   :
                Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                  child: AppTextField(
                    controller: userpro.cardTitleController
                      ..selection = TextSelection(
                          baseOffset: userpro.cardTitleController.text.length,
                          extentOffset:
                              userpro.cardTitleController.text.length),
                    borderColor: Colors.grey,
                    isPrefixEnabled: false,
                    placeHolder: "Card Title",
                    prefixIcon: Icons.title_outlined,
                    onChangeText: (String value) {},
                    onSubmit: (String value) {},
                  ),
                ),
                SizedBox(
                  height: 300,
                  width: MediaQuery.of(context).size.width * 0.88,
                  child: Stack(
                    fit: StackFit.passthrough,
                    children: [
                      Positioned(
                        width: MediaQuery.of(context).size.width * 0.88,
                        height: 220,
                        child: userpro.userModel.coverUrl == null ||
                                userpro.userModel.coverUrl!.isEmpty
                            ? Container(
                                // width: MediaQuery.of(context).size.width * 0.88,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  color: Colors.grey,
                                  image: coverImage == null
                                      ? const DecorationImage(
                                          fit: BoxFit.cover,
                                          image: AssetImage(
                                              "assets/images/coverImage.jpg"),
                                        )
                                      : DecorationImage(
                                          fit: BoxFit.cover,
                                          image: FileImage(coverImage!),
                                        ),
                                ),
                              )
                            : ClipRRect(
                                borderRadius: BorderRadius.circular(8),
                                child: CachedNetworkImage(
                                  fit: BoxFit.cover,
                                  // width: 40,
                                  // height: 40,
                                  httpHeaders: const {
                                    "Access-Control-Allow-Origin": '*',
                                    "Access-Control-Allow-Headers": '*'
                                  },
                                  imageUrl: '${userpro.userModel.coverUrl}',
                                  errorWidget: (context, obj, stackTrace) {
                                    return const Center(
                                      child: Icon(Icons.error_outline_outlined),
                                    );
                                  },
                                )
                                // Image.network(
                                //   "${userpro.userModel.coverUrl}",
                                //   fit: BoxFit.cover,
                                //   headers: const {
                                //     "Access-Control-Allow-Origin": '*',
                                //     "Access-Control-Allow-Headers": '*'
                                //   },
                                //   errorBuilder: (context, obj, stackTrace) {
                                //     return Center(
                                //       child: Text("Error: $stackTrace"),
                                //     );
                                //   },
                                // ),
                                ),
                      ),

                      /// Edit Image button
                      Positioned(
                          // width: 130,
                          // height: 40,
                          right: 0,
                          top: 10,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              minimumSize: const Size(125, 40),
                              maximumSize: const Size(125, 40),
                              backgroundColor: Colors.black,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            onPressed: () {
                              showAnimateBottomSheet(context,
                                  onCoverImage: onUploadCoverImage,
                                  onProfileImage: onUploadProfileImage,
                                  onLogoImage: onUploadLogoImage);
                            },
                            child: const Text(
                              "Edit Images",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w400,
                                  fontSize: 14),
                            ),
                          )),

                      /// logo and profile image widget
                      Positioned(
                        bottom: 50,
                        left: MediaQuery.of(context).size.width / 3.5,
                        child: Stack(
                          fit: StackFit.passthrough,
                          children: [
                            Positioned(
                              child: Card(
                                elevation: 5,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(100),
                                ),
                                child: userpro.userModel.photoUrl == null
                                    ? InkWell(
                                        borderRadius:
                                            BorderRadius.circular(100),
                                        onTap: () async {
                                          showAnimateBottomSheet(context,
                                              onCoverImage: onUploadCoverImage,
                                              onProfileImage:
                                                  onUploadProfileImage,
                                              onLogoImage: onUploadLogoImage);
                                        },
                                        child: profileImage == null
                                            ? CircleAvatar(
                                                radius: 55,
                                                backgroundColor: Colors.white,
                                                child: profileImage == null
                                                    ? const CircleAvatar(
                                                        radius: 50,
                                                        backgroundImage: AssetImage(
                                                            "assets/avaters/Avatar 2.jpg"),
                                                      )
                                                    : CircleAvatar(
                                                        radius: 50,
                                                        backgroundImage:
                                                            FileImage(
                                                                profileImage!),
                                                      ),
                                              )
                                            : Container(
                                                width: 100,
                                                height: 100,
                                                decoration: BoxDecoration(
                                                  // color: Colors.blue,
                                                  borderRadius:
                                                      BorderRadius.circular(50),
                                                ),
                                                child: ClipRRect(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            100),
                                                    child: CachedNetworkImage(
                                                      fit: BoxFit.cover,
                                                      width: 40,
                                                      height: 40,
                                                      httpHeaders: const {
                                                        "Access-Control-Allow-Origin":
                                                            '*',
                                                        "Access-Control-Allow-Headers":
                                                            '*'
                                                      },
                                                      imageUrl:
                                                          '${userpro.userModel.photoUrl}',
                                                      errorWidget: (context,
                                                          obj, stackTrace) {
                                                        return const Center(
                                                          child: Icon(Icons
                                                              .error_outline_outlined),
                                                        );
                                                      },
                                                    )

                                                    // Image.network(
                                                    //   "${userpro.userModel.photoUrl}",
                                                    //   fit: BoxFit.cover,
                                                    //   headers: const {
                                                    //     "Access-Control-Allow-Origin":
                                                    //         '*',
                                                    //     "Access-Control-Allow-Headers":
                                                    //         '*'
                                                    //   },
                                                    //   errorBuilder: (context, obj,
                                                    //       stackTrace) {
                                                    //     return Center(
                                                    //       child: Text(
                                                    //           "Error: $stackTrace"),
                                                    //     );
                                                    //   },
                                                    // ),
                                                    ),
                                              ),
                                      )
                                    : InkWell(
                                        borderRadius:
                                            BorderRadius.circular(100),
                                        onTap: () {
                                          showAnimateBottomSheet(context,
                                              onCoverImage: onUploadCoverImage,
                                              onProfileImage:
                                                  onUploadProfileImage,
                                              onLogoImage: onUploadLogoImage);
                                        },
                                        child: profileImage == null
                                            ? Container(
                                                width: 100,
                                                height: 100,
                                                decoration: BoxDecoration(
                                                  // color: Colors.blue,
                                                  borderRadius:
                                                      BorderRadius.circular(50),
                                                ),
                                                child: ClipRRect(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            100),
                                                    child: CachedNetworkImage(
                                                      fit: BoxFit.cover,
                                                      width: 40,
                                                      height: 40,
                                                      httpHeaders: const {
                                                        "Access-Control-Allow-Origin":
                                                            '*',
                                                        "Access-Control-Allow-Headers":
                                                            '*'
                                                      },
                                                      imageUrl:
                                                          '${userpro.userModel.photoUrl}',
                                                      errorWidget: (context,
                                                          obj, stackTrace) {
                                                        return const Center(
                                                          child: Icon(Icons
                                                              .error_outline_outlined),
                                                        );
                                                      },
                                                    )

                                                    // Image.network(
                                                    //   "${userpro.userModel.photoUrl}",
                                                    //   fit: BoxFit.cover,
                                                    //   headers: const {
                                                    //     "Access-Control-Allow-Origin":
                                                    //         '*',
                                                    //     "Access-Control-Allow-Headers":
                                                    //         '*'
                                                    //   },
                                                    //   errorBuilder: (context, obj,
                                                    //       stackTrace) {
                                                    //     return Center(
                                                    //       child: Text(
                                                    //           "Error: ${stackTrace}"),
                                                    //     );
                                                    //   },
                                                    //   // frameBuilder: (BuildContext
                                                    //   //         context,
                                                    //   //     Widget child,
                                                    //   //     int? frame,
                                                    //   //     bool wasSyncLoaded) {
                                                    //   //   if (wasSyncLoaded) {
                                                    //   //     return child;
                                                    //   //   }
                                                    //   //   return frame == null
                                                    //   //       ? const ShimmerEffect()
                                                    //   //       : child;
                                                    //   // },
                                                    // ),
                                                    ),
                                              )
                                            : CircleAvatar(
                                                radius: 55,
                                                backgroundColor: Colors.white,
                                                child: CircleAvatar(
                                                  radius: 50,
                                                  backgroundImage:
                                                      FileImage(profileImage!),
                                                ),
                                              ),
                                      ),
                              ),
                            ),

                            /// company logo
                            Positioned(
                              bottom: 0,
                              right: 0,
                              // width: 40,
                              // height: 40,
                              child: userpro.userModel.logoUrl == null ||
                                      userpro.userModel.logoUrl!.isEmpty
                                  ? CircleAvatar(
                                      radius: 20,
                                      backgroundColor: Colors.white,
                                      child: CircleAvatar(
                                        radius: 18,
                                        backgroundColor: logoImage == null
                                            ? Colors.grey
                                            : Colors.transparent,
                                        child: logoImage == null
                                            ? const Text(
                                                "Logo",
                                                style: TextStyle(
                                                  fontSize: 12,
                                                ),
                                              )
                                            : ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(50),
                                                child: Image.file(
                                                  logoImage!,
                                                  fit: BoxFit.cover,
                                                  width: 40,
                                                  height: 40,
                                                ),
                                              ),
                                      ),
                                    )
                                  : CircleAvatar(
                                      radius: 20,
                                      backgroundColor: Colors.white,
                                      child: CircleAvatar(
                                        radius: 18,
                                        backgroundColor: logoImage == null
                                            ? Colors.grey
                                            : Colors.transparent,
                                        child: logoImage == null
                                            ? ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(50),
                                                child: CachedNetworkImage(
                                                  fit: BoxFit.cover,
                                                  width: 40,
                                                  height: 40,
                                                  httpHeaders: const {
                                                    "Access-Control-Allow-Origin":
                                                        '*',
                                                    "Access-Control-Allow-Headers":
                                                        '*'
                                                  },
                                                  imageUrl:
                                                      '${userpro.userModel.logoUrl}',
                                                  errorWidget: (context, obj,
                                                      stackTrace) {
                                                    return const Center(
                                                      child: Icon(Icons
                                                          .error_outline_outlined),
                                                    );
                                                  },
                                                )
                                                // Image.network(
                                                //   "${userpro.userModel.logoUrl}",
                                                //   fit: BoxFit.cover,
                                                //   width: 40,
                                                //   height: 40,
                                                //   headers: const {
                                                //     "Access-Control-Allow-Origin":
                                                //         '*',
                                                //     "Access-Control-Allow-Headers":
                                                //         '*'
                                                //   },
                                                //   errorBuilder: (context, obj,
                                                //       stackTrace) {
                                                //     return Center(
                                                //       child: Text(
                                                //           "Error: ${stackTrace}"),
                                                //     );
                                                //   },
                                                // ),
                                                )
                                            : ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(50),
                                                child: Image.file(
                                                  logoImage!,
                                                  fit: BoxFit.cover,
                                                  width: 40,
                                                  height: 40,
                                                ),
                                              ),
                                      ),
                                    ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 250,
                  child: StreamBuilder<QuerySnapshot>(
                    stream: userpro.getSubCollectionData(),
                    builder: (BuildContext context,
                        AsyncSnapshot<QuerySnapshot> snapshot) {
                      if (snapshot.hasError) {
                        return Center(child: Text('Error: ${snapshot.error}'));
                      }
                      switch (snapshot.connectionState) {
                        case ConnectionState.waiting:
                          return const Center(
                              child: CircularProgressIndicator());
                        default:
                          log("Snapshot: ${snapshot.data!.docs.length}");
                          return snapshot.data!.docs.isEmpty
                              ? const SizedBox.shrink()
                              : ListView.builder(
                                  itemCount: snapshot.data?.docs.length,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    DocumentSnapshot document =
                                        snapshot.data!.docs[index];
                                    String data =
                                        document.get("data").toString();
                                    return Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 10, vertical: 5),
                                      child: SocialContactCard(
                                        // backgroundColor: Colors.blueAccent,
                                        title: document.get("type"),
                                        // trailingTitle: "Update",
                                        leadingIcon: document
                                                    .get('type')
                                                    .toString()
                                                    .toLowerCase() ==
                                                "email"
                                            ? FontAwesomeIcons.envelope
                                            : document
                                                        .get('type')
                                                        .toString()
                                                        .toLowerCase() ==
                                                    "linkedin"
                                                ? FontAwesomeIcons.linkedin
                                                : document
                                                            .get('type')
                                                            .toString()
                                                            .toLowerCase() ==
                                                        "number"
                                                    ? FontAwesomeIcons.phone
                                                    : document
                                                                .get('type')
                                                                .toString()
                                                                .toLowerCase() ==
                                                            "instagram"
                                                        ? FontAwesomeIcons
                                                            .instagram
                                                        : null,
                                        onPressed: () => userpro.openLink(data),
                                        onTrailingPressed: () {
                                          log("trailg");
                                        },
                                      ),
                                    );
                                    //   Container(
                                    //   color: Colors.blueAccent,
                                    //   child: ListTile(
                                    //     title: Text(document.get("type")),
                                    //     subtitle: Text(document.get("created")),
                                    //   ),
                                    // );
                                  },
                                );
                      }
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: AppTextField(
                    controller: userpro.nameController
                      ..selection = TextSelection(
                          baseOffset: userpro.nameController.text.length,
                          extentOffset: userpro.nameController.text.length),
                    borderColor: Colors.grey,
                    isPrefixEnabled: false,
                    placeHolder: "Name",
                    prefixIcon: Icons.email_outlined,
                    onChangeText: (String value) {},
                    onSubmit: (String value) {},
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: AppTextField(
                    controller: userpro.jobTitleController
                      ..selection = TextSelection(
                          baseOffset: userpro.jobTitleController.text.length,
                          extentOffset: userpro.jobTitleController.text.length),
                    borderColor: Colors.grey,
                    isPrefixEnabled: false,
                    placeHolder: "Job Title",
                    prefixIcon: Icons.title_outlined,
                    onChangeText: (String value) {},
                    onSubmit: (String value) {},
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: AppTextField(
                    controller: userpro.companyController
                      ..selection = TextSelection(
                          baseOffset: userpro.companyController.text.length,
                          extentOffset: userpro.companyController.text.length),
                    borderColor: Colors.grey,
                    isPrefixEnabled: false,
                    placeHolder: "Company",
                    prefixIcon: Icons.title_outlined,
                    onChangeText: (String value) {},
                    onSubmit: (String value) {},
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: AppTextField(
                    controller: userpro.addressController
                      ..selection = TextSelection(
                          baseOffset: userpro.addressController.text.length,
                          extentOffset: userpro.addressController.text.length),
                    borderColor: Colors.grey,
                    isPrefixEnabled: false,
                    placeHolder: "Address",
                    prefixIcon: FontAwesomeIcons.addressBook,
                    onChangeText: (String value) {},
                    onSubmit: (String value) {},
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: RichTextField(
                    bioController: userpro.bioController
                      ..selection = TextSelection(
                          baseOffset: userpro.bioController.text.length,
                          extentOffset: userpro.bioController.text.length),
                  ),
                ),

                ///  profile theme pick color
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 15, vertical: 15),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade300,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Padding(
                          padding:
                              EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                          child: Text(
                            "Profile Theme",
                            style: TextStyle(
                                fontSize: 14, fontWeight: FontWeight.w400),
                          ),
                        ),
                        ColorPickerWidget(
                          colors: colors,
                          onPressed: (color) {
                            // setState(() {
                            selectedColor = color;
                            log("Selected Color: $selectedColor");
                            // });
                          },
                          onEditPressed: () {},
                        ),
                        const Padding(
                          padding: EdgeInsets.symmetric(vertical: 8.0),
                          child: Divider(
                            indent: 0,
                            endIndent: 0,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                "Colors your link Icons",
                                style: TextStyle(
                                    fontSize: 14, fontWeight: FontWeight.w400),
                              ),
                              Transform.scale(
                                scale: 0.8,
                                child: CustomSwitchButton(
                                    value: ref.watch(userpro.newSwitch),
                                    onChanged: (value) {
                                      ref
                                          .read(userpro.newSwitch.notifier)
                                          .boolProviderStatus(value);
                                    }),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                /// add info to card
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  child: AddInfoToCard(
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => const SocialLinkScreen(),
                        ),
                      );
                    },
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                  child: AppTextButton(
                    onPressed: () {
                      if (kIsWeb) {
                        log("web router call");
                        GoRouter.of(context)
                            .go("/cardScreen?userId=${userpro.userModel.uid}");
                        // GoRouter.of(context).go('/cardScreen',
                        //     extra: {"userId": "${userpro.userModel.uid}"});
                        context.goNamed("cardScreen", params: {
                          "userId": "${userpro.userModel.uid}"
                        }, queryParams: {
                          "userId": "${userpro.userModel.uid}"
                        });
                        // GoRouter.of(context).go(
                        //     '/shareQRCodeScreen/${userpro.userModel.uid}');
                        // context.goNamed("shareQRCodeScreen",
                        //     params: {"userId": "${userpro.userModel.uid}"});
                      } else {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => BusinessCardTemplate(
                              userId: "${userpro.userModel.uid}",
                              // userData: userpro.userModel,
                              color: selectedColor,
                              isSocialColorEnabled: ref.watch(
                                userpro.newSwitch,
                              ),
                            ),
                          ),
                        );
                      }
                    },
                    backgroundColor: Colors.grey.shade50,
                    textColor: Colors.black,
                    elevation: 2,
                    title: "Preview This Card",
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                  child: AppTextButton(
                    onPressed: () async {
                      await userpro.onSaveButtonPressed(context);
                      FocusScope.of(context).unfocus();
                    },
                    title: "Save Card",
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  /// animated bottom sheet
  void showAnimateBottomSheet(BuildContext context,
      {required void Function() onCoverImage,
      required void Function() onProfileImage,
      required void Function() onLogoImage}) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(12),
          topRight: Radius.circular(12),
        ),
      ),
      transitionAnimationController: animateController,
      builder: (BuildContext context) {
        return SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(20.0),
            height: MediaQuery.of(context).size.height * 0.5,
            child: Column(
              // mainAxisSize: MainAxisSize.min,
              children: [
                CustomIconAndTextButton(
                  title: "Edit Cover photo",
                  iconData: FontAwesomeIcons.image,
                  onPressed: () {
                    Navigator.of(context).pop();
                    pickImage().then((value) {
                      coverImage = value;
                      onCoverImage();
                    }).catchError((e) {
                      log("Error while Getting image: $e");
                    });
                  },
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      CustomIconAndTextButton(
                        width: MediaQuery.of(context).size.width / 2.5,
                        title: "Add Profile Picture",
                        iconData: FontAwesomeIcons.user,
                        onPressed: () {
                          Navigator.of(context).pop();
                          pickImage().then((value) {
                            profileImage = value;
                            onProfileImage();
                          }).catchError((e) {
                            log("Error while Getting Profile image: $e");
                          });
                        },
                      ),
                      CustomIconAndTextButton(
                        width: MediaQuery.of(context).size.width / 2.5,
                        title: "Add Logo",
                        iconData: FontAwesomeIcons.user,
                        onPressed: () {
                          Navigator.of(context).pop();
                          pickImage().then((value) {
                            logoImage = value;
                            onLogoImage();
                          }).catchError((e) {
                            log("Error while Getting Logo image: $e");
                          });
                        },
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 0, vertical: 15),
                  child: AppTextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    title: "Cancel",
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  /// show model bottom sheet
  // void show(BuildContext context) {
  //   showCupertinoModalPopup(
  //       context: context,
  //       builder: (BuildContext cont) {
  //         return CupertinoActionSheet(
  //           actions: [
  //             CupertinoActionSheetAction(
  //               onPressed: () {
  //                 Navigator.of(cont).pop();
  //                 pickImage().then((value) {
  //                   coverImage = value;
  //                 }).catchError((e) {
  //                   log("Error while Getting image: $e");
  //                 });
  //               },
  //               child: const Text('Add Cover Photo'),
  //             ),
  //             CupertinoActionSheetAction(
  //               onPressed: () {
  //                 Navigator.of(cont).pop();
  //                 pickImage().then((value) {
  //                   profileImage = value;
  //                 }).catchError((e) {
  //                   log("Error while Getting Profile image: $e");
  //                 });
  //               },
  //               child: const Text('Add Profile Picture'),
  //             ),
  //             CupertinoActionSheetAction(
  //               onPressed: () {
  //                 Navigator.of(cont).pop();
  //                 pickImage().then((value) {
  //                   logoImage = value;
  //                 }).catchError((e) {
  //                   log("Error while Getting Logo image: $e");
  //                 });
  //               },
  //               child: const Text('Add Logo'),
  //             ),
  //           ],
  //           cancelButton: CupertinoActionSheetAction(
  //             onPressed: () {
  //               Navigator.of(cont).pop();
  //             },
  //             child: const Text('Cancel', style: TextStyle(color: Colors.red)),
  //           ),
  //         );
  //       });
  // }

  /// pick image
  Future<File?> pickImage() async {
    File? file;
    XFile? xFile = await picker.pickImage(source: ImageSource.gallery);

    if (xFile != null) {
      setState(() {
        file = File(xFile.path);
      });
    }
    return file;
  }
}

class CustomSwitchButton extends StatelessWidget {
  final bool value;
  final void Function(bool)? onChanged;
  const CustomSwitchButton({
    super.key,
    required this.value,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return CupertinoSwitch(
      value: value,
      activeColor: Colors.black,
      thumbColor: Colors.white,
      trackColor: Colors.black54,
      onChanged: onChanged,
    );
  }
}

class CustomSwitchButton1 extends StatelessWidget {
  const CustomSwitchButton1({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, ref, _) {
      final value = ref.watch(boolProvider.notifier);
      return CupertinoSwitch(
        value: value.state,
        activeColor: Colors.black,
        thumbColor: Colors.white,
        trackColor: Colors.black54,
        onChanged: (val) {
          ref.read(boolProvider.notifier).boolProviderStatus(val);
        },
      );
    });
  }
}

class SliverScreen extends StatefulWidget {
  const SliverScreen({Key? key}) : super(key: key);

  @override
  State<SliverScreen> createState() => _SliverScreenState();
}

class _SliverScreenState extends State<SliverScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        scrollDirection: Axis.vertical,
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        shrinkWrap: true,
        slivers: <Widget>[
          SliverAppBar(
            pinned: true,
            floating: true,
            snap: false,
            title: const Text('Link Store'),
            backgroundColor: Colors.white,
            expandedHeight: 80.0,
            elevation: 0,
            scrolledUnderElevation: 0,
            flexibleSpace: FlexibleSpaceBar(
              background: Container(
                color: Colors.white,
              ),
            ),
          ),

          ///
          const SliverPadding(
            padding: EdgeInsets.symmetric(horizontal: 12),
            sliver: SliverToBoxAdapter(
              child: Text(
                "Recommended",
                style: TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 22,
                ),
              ),
            ),
          ),
          // SliverList(
          //   delegate: SliverChildBuilderDelegate(
          //     childCount: recommended.length,
          //         (context, index) {
          //       return Padding(
          //         padding: const EdgeInsets.all(8.0),
          //         child: SocialContactCard(
          //           title: recommended[index].title,
          //           leadingIcon: recommended[index].leadingIcon,
          //           onPressed: () {
          //             Navigator.of(context).push(
          //               MaterialPageRoute(
          //                 builder: (context) => AddLinkCardScreen(
          //                   data: recommended[index],
          //                 ),
          //               ),
          //             );
          //           },
          //         ),
          //       );
          //     },
          //   ),
          // ),
          ///
        ],
      ),
    );
  }
}

/// animated bottom sheet

class BS extends StatefulWidget {
  _BS createState() => _BS();
}

class _BS extends State<BS> {
  bool _showSecond = false;

  @override
  Widget build(BuildContext context) {
    return BottomSheet(
      onClosing: () {},
      builder: (BuildContext context) => AnimatedContainer(
        margin: const EdgeInsets.all(20),
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(30)),
        duration: const Duration(milliseconds: 400),
        child: AnimatedCrossFade(
          firstChild: Container(
            constraints: BoxConstraints.expand(
                height: MediaQuery.of(context).size.height - 200),
//remove constraint and add your widget hierarchy as a child for first view
            padding: const EdgeInsets.all(20),
            child: Align(
              alignment: Alignment.bottomCenter,
              child: ElevatedButton(
                onPressed: () => setState(() => _showSecond = true),
                // padding: EdgeInsets.all(15),
                // shape: RoundedRectangleBorder(
                //     borderRadius: BorderRadius.circular(10)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const <Widget>[
                    Text("Suivant"),
                  ],
                ),
              ),
            ),
          ),
          secondChild: Container(
            constraints: BoxConstraints.expand(
                height: MediaQuery.of(context).size.height / 3),
//remove constraint and add your widget hierarchy as a child for second view
            padding: const EdgeInsets.all(20),
            child: Align(
              alignment: Alignment.bottomCenter,
              child: ElevatedButton(
                onPressed: () => setState(() => _showSecond = false),
                // color: Colors.green,
                // padding: EdgeInsets.all(15),
                // shape: RoundedRectangleBorder(
                //     borderRadius: BorderRadius.circular(10)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    const Text("ok"),
                  ],
                ),
              ),
            ),
          ),
          crossFadeState: _showSecond
              ? CrossFadeState.showSecond
              : CrossFadeState.showFirst,
          duration: const Duration(milliseconds: 400),
        ),
      ),
    );
  }
}
