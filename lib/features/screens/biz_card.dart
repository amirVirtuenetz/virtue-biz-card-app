import 'dart:developer';
import 'dart:io';

import 'package:biz_card/features/model/user_model.dart';
import 'package:biz_card/features/socialLink/social_link_screen.dart';
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
import '../components/rich_text_field.dart';
import '../components/text_button.dart';
import '../model/model.dart';
import '../providers/user_provider.dart';
import '../services/shared_preference.dart';

// var switchProvider = StateProvider((ref) => false);

class BizCardMain extends StatefulWidget {
  const BizCardMain({
    super.key,
  });

  @override
  State<BizCardMain> createState() => _BizCardMainState();
}

class _BizCardMainState extends State<BizCardMain>
    with TickerProviderStateMixin {
  late AnimationController animateController;

  ImagePicker picker = ImagePicker();
  File? coverImage;
  File? profileImage;
  File? logoImage;
  String? encodedJson;
  QrCodeData myData = QrCodeData();

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
    animateController.dispose();
    super.dispose();
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
            child: Consumer(builder: (context, ref, _) {
              final userpro = ref.watch(userProvider);
              userpro.getDataFromFireStore();
              userpro.getSubCollectionData();
              if (userpro.userModel != null) {
                log("Consumer Widget");
                log("Cover Image: ${userpro.userModel.coverUrl}");
                loading = false;
                log("Loading...............  $loading");
                userpro.cardTitleController.text =
                    userpro.userModel.cardTitle.toString();
                userpro.nameController.text =
                    userpro.userModel.displayName.toString();
                userpro.jobTitleController.text =
                    userpro.userModel.jobTitle.toString();
                userpro.companyController.text =
                    userpro.userModel.companyName.toString();
                userpro.addressController.text =
                    userpro.userModel.address.toString();
                userpro.bioController.text = userpro.userModel.bio.toString();
                // selectedColor = Color(
                //     int.parse("0XFF${auth.userModel.brandColor.toString()}"));
                // log("brand color: ${selectedColor}");
              } else {
                loading = true;
                log("Loading...............  $loading");
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

              return
                  // loading == true
                  //   ? const Center(
                  //       child: CircularProgressIndicator(),
                  //     )
                  //   :
                  Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // SizedBox(
                  //   height: 150,
                  //   child: StreamBuilder<QuerySnapshot>(
                  //     stream: FirebaseFirestore.instance
                  //         .collection('users')
                  //         .doc(userpro.userModel.uid)
                  //         .collection(UsersKey.subCollection)
                  //         .snapshots(),
                  //     builder: (BuildContext context,
                  //         AsyncSnapshot<QuerySnapshot> snapshot) {
                  //       if (snapshot.hasError) {
                  //         return Center(
                  //             child: Text('Error: ${snapshot.error}'));
                  //       }
                  //
                  //       switch (snapshot.connectionState) {
                  //         case ConnectionState.waiting:
                  //           return const CircularProgressIndicator();
                  //         default:
                  //           return ListView.builder(
                  //             itemCount: snapshot.data?.docs.length,
                  //             itemBuilder: (BuildContext context, int index) {
                  //               DocumentSnapshot document =
                  //                   snapshot.data!.docs[index];
                  //               log("Document data: $document");
                  //               return Container(
                  //                 color: Colors.blueAccent,
                  //                 child: ListTile(
                  //                   title: Text(document.get("type")),
                  //                   subtitle: Text(document.get("created")),
                  //                 ),
                  //               );
                  //             },
                  //           );
                  //       }
                  //     },
                  //   ),
                  // ),
                  ///
                  // SizedBox(
                  //   height: 150,
                  //   child: StreamBuilder<DocumentSnapshot>(
                  //     stream: userpro.getListData(),
                  //     builder: (BuildContext context,
                  //         AsyncSnapshot<DocumentSnapshot> snapshot) {
                  //       if (!snapshot.hasData) {
                  //         return const Text('Loading...');
                  //       }
                  //       final List<dynamic> dataList =
                  //           snapshot.data?.get("list");
                  //       if (dataList.isNotEmpty) {
                  //         return ListView.builder(
                  //           itemCount: dataList.length,
                  //           itemBuilder: (BuildContext context, int index) {
                  //             final dynamic data = dataList[index];
                  //             return Padding(
                  //               padding: const EdgeInsets.all(4.0),
                  //               child: SocialContactCard(
                  //                 backgroundColor: Colors.blueAccent,
                  //                 title: data,
                  //                 onPressed: () {},
                  //               ),
                  //             );
                  //             // return a ListTile or any other widget that displays the data
                  //           },
                  //         );
                  //       } else {
                  //         return Container();
                  //       }
                  //     },
                  //   ),
                  // ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 20),
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
                                  child: Image.network(
                                    "${userpro.userModel.coverUrl}",
                                    fit: BoxFit.cover,
                                    errorBuilder: (context, obj, stackTrace) {
                                      return Center(
                                        child: Text("Error: $stackTrace"),
                                      );
                                    },
                                  ),
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
                                          onTap: () async {
                                            showAnimateBottomSheet(context,
                                                onCoverImage:
                                                    onUploadCoverImage,
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
                                                          backgroundImage:
                                                              AssetImage(
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
                                                        BorderRadius.circular(
                                                            50),
                                                  ),
                                                  child: ClipRRect(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            100),
                                                    child: Image.network(
                                                      "${userpro.userModel.photoUrl}",
                                                      fit: BoxFit.cover,
                                                      errorBuilder: (context,
                                                          obj, stackTrace) {
                                                        return Center(
                                                          child: Text(
                                                              "Error: ${stackTrace}"),
                                                        );
                                                      },
                                                    ),
                                                  ),
                                                ),
                                        )
                                      : InkWell(
                                          onTap: () {
                                            showAnimateBottomSheet(context,
                                                onCoverImage:
                                                    onUploadCoverImage,
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
                                                        BorderRadius.circular(
                                                            50),
                                                  ),
                                                  child: ClipRRect(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            100),
                                                    child: Image.network(
                                                      "${userpro.userModel.photoUrl}",
                                                      fit: BoxFit.cover,
                                                      errorBuilder: (context,
                                                          obj, stackTrace) {
                                                        return Center(
                                                          child: Text(
                                                              "Error: ${stackTrace}"),
                                                        );
                                                      },
                                                      // frameBuilder: (BuildContext
                                                      //         context,
                                                      //     Widget child,
                                                      //     int? frame,
                                                      //     bool wasSyncLoaded) {
                                                      //   if (wasSyncLoaded) {
                                                      //     return child;
                                                      //   }
                                                      //   return frame == null
                                                      //       ? const ShimmerEffect()
                                                      //       : child;
                                                      // },
                                                    ),
                                                  ),
                                                )
                                              : CircleAvatar(
                                                  radius: 55,
                                                  backgroundColor: Colors.white,
                                                  child: CircleAvatar(
                                                    radius: 50,
                                                    backgroundImage: FileImage(
                                                        profileImage!),
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
                                                  child: Image.network(
                                                    "${userpro.userModel.logoUrl}",
                                                    fit: BoxFit.cover,
                                                    width: 40,
                                                    height: 40,
                                                    errorBuilder: (context, obj,
                                                        stackTrace) {
                                                      return Center(
                                                        child: Text(
                                                            "Error: ${stackTrace}"),
                                                      );
                                                    },
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
                                      ),
                              )
                            ],
                          ),
                        ),
                      ],
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
                            extentOffset:
                                userpro.jobTitleController.text.length),
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
                            extentOffset:
                                userpro.companyController.text.length),
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
                            extentOffset:
                                userpro.addressController.text.length),
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
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 10),
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
                            padding: EdgeInsets.symmetric(
                                horizontal: 5, vertical: 5),
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
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400),
                                ),
                                Transform.scale(
                                  scale: 0.8,
                                  child: CupertinoSwitch(
                                    value: ref.watch(userpro.newSwitch),
                                    activeColor: Colors.black,
                                    thumbColor: Colors.white,
                                    trackColor: Colors.black54,
                                    onChanged: (value) {
                                      ref
                                          .read(userpro.newSwitch.notifier)
                                          .boolProviderStatus(value);

                                      // setState(() {
                                      //   userpro.switchValue = value;
                                      // });
                                    },
                                  ),
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
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 10),
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
                    padding: const EdgeInsets.symmetric(
                        horizontal: 40, vertical: 15),
                    child: AppTextButton(
                      onPressed: () {
                        if (kIsWeb) {
                          log("web router call");
                          GoRouter.of(context).go(
                              "/cardScreen?userId=${userpro.userModel.uid}");
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
                    padding: const EdgeInsets.symmetric(
                        horizontal: 40, vertical: 15),
                    child: AppTextButton(
                      onPressed: () async {
                        await userpro.onSaveButtonPressed(context);
                        FocusScope.of(context).unfocus();
                        // myData.name = nameController.text;
                        // myData.jobTitle = jobTitleController.text;
                        // myData.company = companyController.text;
                        // myData.address = addressController.text;
                        // myData.bio = bioController.text;
                        // setState(() {
                        //   encodedJson = jsonEncode(myData);
                        //   log("My Data: $encodedJson");
                        // });
                        // Navigator.push(
                        //   context,
                        //   MaterialPageRoute(
                        //     builder: (context) => QRGeneratorScreen(
                        //       data: encodedJson,
                        //     ),
                        //   ),
                        // );
                      },
                      title: "Save Card",
                    ),
                  ),
                ],
              );
            }),
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

class CustomIconAndTextButton extends StatelessWidget {
  final void Function() onPressed;
  final String title;
  final IconData iconData;
  final double? width;
  const CustomIconAndTextButton({
    Key? key,
    required this.onPressed,
    required this.title,
    required this.iconData,
    this.width,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      // padding: const EdgeInsets.symmetric(vertical: 30),
      width: width ?? MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        color: Colors.grey.shade300,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Material(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(12),
        child: InkWell(
          borderRadius: BorderRadius.circular(12),
          onTap: onPressed,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(
                height: 10,
              ),
              Icon(
                iconData,
                size: 40,
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
                child: Text(
                  title,
                  textAlign: TextAlign.center,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class AddInfoToCard extends StatelessWidget {
  final void Function() onPressed;
  const AddInfoToCard({
    Key? key,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      // padding: const EdgeInsets.symmetric(
      //     horizontal: 15, vertical: 15),
      decoration: BoxDecoration(
        color: Colors.grey.shade300,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Material(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(12),
        child: InkWell(
          borderRadius: BorderRadius.circular(12),
          onTap: onPressed,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: const [
              Icon(
                Icons.add_outlined,
                size: 50,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                child: Text(
                  "Add Info to Card",
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 5, bottom: 12),
                child: Text(
                  "Add contact info,links, and more to your card",
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
                ),
              ),
            ],
          ),
        ),
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

///  profile image widget
class ProfileImageWidget extends StatelessWidget {
  final void Function() onPressed;
  final String image;
  final String newtWorkImage;
  final bool isNetworkImage;
  const ProfileImageWidget(
      {Key? key,
      required this.onPressed,
      required this.image,
      required this.isNetworkImage,
      required this.newtWorkImage})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(100),
      ),
      child: isNetworkImage == false
          ? InkWell(
              onTap: onPressed,
              child: image.isEmpty
                  ? CircleAvatar(
                      radius: 55,
                      backgroundColor: Colors.white,
                      child: image.isEmpty
                          ? const CircleAvatar(
                              radius: 50,
                              backgroundImage:
                                  AssetImage("assets/avaters/Avatar 2.jpg"),
                            )
                          : CircleAvatar(
                              radius: 50,
                              backgroundImage: FileImage(
                                File(image),
                              ),
                            ),
                    )
                  : Container(
                      width: 100,
                      height: 100,
                      decoration: BoxDecoration(
                        // color: Colors.blue,
                        borderRadius: BorderRadius.circular(50),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(100),
                        child: Image.network(
                          newtWorkImage,
                          fit: BoxFit.cover,
                          errorBuilder: (context, obj, stackTrace) {
                            return Center(
                              child: Text("Error: $stackTrace"),
                            );
                          },
                        ),
                      ),
                    ),
            )
          : InkWell(
              onTap: onPressed,
              child: image.isEmpty
                  ? Container(
                      width: 100,
                      height: 100,
                      decoration: BoxDecoration(
                        // color: Colors.blue,
                        borderRadius: BorderRadius.circular(50),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(100),
                        child: Image.network(
                          newtWorkImage,
                          fit: BoxFit.cover,
                          errorBuilder: (context, obj, stackTrace) {
                            return Center(
                              child: Text("Error: $stackTrace"),
                            );
                          },
                        ),
                      ),
                    )
                  : CircleAvatar(
                      radius: 55,
                      backgroundColor: Colors.white,
                      child: CircleAvatar(
                        radius: 50,
                        backgroundImage: FileImage(
                          File(image),
                        ),
                      ),
                    ),
            ),
    );
  }
}

class MyWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Consumer(
          builder: (context, ref, _) {
            final documentSnapshot = ref.watch(documentSnapshotProvider);

            return documentSnapshot.when(
              data: (snapshot) {
                final data =
                    snapshot.data(); // Access the data from the snapshot
                return Text('Data: $data');
              },
              loading: () => CircularProgressIndicator(),
              error: (error, stackTrace) => Text('Error: $error'),
            );
          },
        ),
      ),
    );
  }
}
