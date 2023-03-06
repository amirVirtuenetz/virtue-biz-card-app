import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:biz_card/features/screens/qr_code_generator_screen.dart';
import 'package:biz_card/features/screens/social_link_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';

import '../cardTemplate/business_card_screen.dart';
import '../components/app_text_field.dart';
import '../components/color_picker_diget.dart';
import '../components/rich_text_field.dart';
import '../components/text_button.dart';
import '../model/model.dart';

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

  final TextEditingController cardTitleController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController jobTitleController = TextEditingController();
  final TextEditingController companyController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController bioController = TextEditingController();
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

  bool _switchValue = false;
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
  }

  @override
  void dispose() {
    animateController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    log("Main Widget");
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        extendBody: true,
        appBar: AppBar(
          title: const Text("Add Detail"),
          elevation: 0,
          scrolledUnderElevation: 0,
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                  child: AppTextField(
                    controller: cardTitleController,
                    borderColor: Colors.grey,
                    isPrefixEnabled: false,
                    placeHolder: "Card Title",
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
                        child: Container(
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
                        ),
                      ),
                      Positioned(
                          width: 110,
                          height: 40,
                          right: 0,
                          top: 10,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.black,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            onPressed: () {
                              // show(context);
                              showAnimateBottomSheet(context);
                              // showModalBottomSheet(
                              //   context: context,
                              //   isScrollControlled: true,
                              //   builder: (BuildContext context) {
                              //     return const MyBottomSheet();
                              //   },
                              // );
                            },
                            child: const Text(
                              "Edit Images",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w400,
                                  fontSize: 14),
                            ),
                          )
                          // ClipOval(
                          //   child: Material(
                          //     color: Colors.blue, // Button color
                          //     child: InkWell(
                          //       splashColor: Colors.red, // Splash color
                          //       onTap: () {},
                          //       child: SizedBox(
                          //         width: 56,
                          //         height: 56,
                          //         child: Text("Edit Cover Image"),
                          //       ),
                          //     ),
                          //   ),
                          // ),
                          ),
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
                                child: InkWell(
                                  onTap: () async {
                                    showAnimateBottomSheet(context);
                                  },
                                  child: CircleAvatar(
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
                              child: CircleAvatar(
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
                    controller: nameController,
                    borderColor: Colors.grey,
                    isPrefixEnabled: false,
                    placeHolder: "Name",
                    onChangeText: (String value) {},
                    onSubmit: (String value) {},
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: AppTextField(
                    controller: jobTitleController,
                    borderColor: Colors.grey,
                    isPrefixEnabled: false,
                    placeHolder: "Job Title",
                    onChangeText: (String value) {},
                    onSubmit: (String value) {},
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: AppTextField(
                    controller: companyController,
                    borderColor: Colors.grey,
                    isPrefixEnabled: false,
                    placeHolder: "Company",
                    onChangeText: (String value) {},
                    onSubmit: (String value) {},
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: AppTextField(
                    controller: addressController,
                    borderColor: Colors.grey,
                    isPrefixEnabled: false,
                    placeHolder: "Address",
                    onChangeText: (String value) {},
                    onSubmit: (String value) {},
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: RichTextField(bioController: bioController),
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
                                child: CupertinoSwitch(
                                  value: _switchValue,
                                  activeColor: Colors.black,
                                  thumbColor: Colors.white,
                                  trackColor: Colors.black54,
                                  onChanged: (value) {
                                    setState(() {
                                      _switchValue = value;
                                    });
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
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => BusinessCardTemplate(
                            color: selectedColor,
                            isSocialColorEnabled: _switchValue,
                          ),
                        ),
                      );
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
                    onPressed: () {
                      myData.name = nameController.text;
                      myData.jobTitle = jobTitleController.text;
                      myData.company = companyController.text;
                      myData.address = addressController.text;
                      myData.bio = bioController.text;
                      setState(() {
                        encodedJson = jsonEncode(myData);
                        log("My Data: $encodedJson");
                      });
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => QRGeneratorScreen(
                            data: encodedJson,
                          ),
                        ),
                      );
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
  void showAnimateBottomSheet(BuildContext context) {
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
                  children: <Widget>[
                    const Text("Suivant"),
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
