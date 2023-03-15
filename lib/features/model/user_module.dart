import 'dart:developer';
import 'dart:io';

import 'package:biz_card/features/model/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:image_picker/image_picker.dart';

import '../../core/helpers/alert_message.dart';
import '../../core/helpers/auth_enum.dart';
import '../../core/helpers/key_constant.dart';
import '../services/firebase_services.dart';
import '../services/shared_preference.dart';
import '../shareQrCode/share_qr_code_screen.dart';

class BoolProvider extends StateNotifier<bool> {
  BoolProvider({getbool = false}) : super(getbool);
  void boolProviderStatus(value) {
    state = value;
  }
}

class UserModule {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final SharePreferencesClass pref = SharePreferencesClass();

  var newSwitch =
      StateNotifierProvider<BoolProvider, bool>((ref) => BoolProvider());

  Stream<User?> get authStateChange => _auth.authStateChanges();

  /// textEditingController
  final TextEditingController cardTitleController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController jobTitleController = TextEditingController();
  final TextEditingController companyController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController bioController = TextEditingController();

  /// user data model
  UserDataModel userModel = UserDataModel();

  /// image picker
  ImagePicker picker = ImagePicker();

  /// images instance
  File? coverImage;
  File? profileImage;
  File? logoImage;

  /// declare variable for updating user profile data

  String coverImageString = '';
  String profileImageString = '';
  String logoImageString = '';

  String brandColor = "000000";

  /// list of colors
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

  /// switch instance
  bool _switchValue = false;
  bool loading = false;
  bool get switchValue => _switchValue;
  set switchValue(bool newval) {
    _switchValue = newval;
  }

  /// get list of data from fire store firebase
  Stream<DocumentSnapshot<Map<String, dynamic>>> getListData() {
    // var data = FirebaseServices.getDocumentStream(_auth.currentUser?.uid);
    // log("Stream Data: ${data}");
    return FirebaseServices.getDocumentStream(_auth.currentUser?.uid);
    // FirebaseFirestore.instance
    //   .collection('users')
    //   .doc(userModel.uid)
    //   .snapshots();
  }

  /// get subCollection   data from fire store firebase
  getSubCollectionData() {
    // var data = FirebaseServices.getDocumentStream(_auth.currentUser?.uid);
    var data = FirebaseServices.fetchSubCollectionData(
        collectionName: "users",
        id: _auth.currentUser!.uid,
        subCollectionName: UsersKey.subCollection);
    // log("subCollection Functions : ${data}");
    return data;
    // FirebaseFirestore.instance
    //   .collection('users')
    //   .doc(userModel.uid)
    //   .snapshots();
  }

  void saveDataLocally(UserDataModel currentUserInstance) {
    var currentUser = currentUserInstance;
    pref.storeStringData(UsersKey.currentUserKey, currentUser.uid);
    pref.storeObjectData(UsersKey.randomUserKey, {
      'displayName': currentUser.displayName,
      'email': currentUser.email,
      'emailVerified': currentUser.emailVerified,
      'isAnonymous': "",
      'creationTime': currentUser.created?.toIso8601String(),
      'lastSignInTime': currentUser.lastSignInTime?.toIso8601String(),
      'phoneNumber': currentUser.phoneNumber,
      'photoURL': currentUser.photoUrl,
      'uid': currentUser.uid,
      'refreshToken': currentUser.uid,
      'isDeleted': currentUser.isDeleted,
      'instagram': currentUser.instagram,
      'website': currentUser.website,
      'contactCard': currentUser.contactCard,
      "qrCode": currentUser.qrCode,
      "coverURL": currentUser.coverUrl,
      "logoURL": currentUser.logoUrl,
      "jobTitle": currentUser.jobTitle,
      "companyName": currentUser.companyName,
      "address": currentUser.address,
      "bio": currentUser.bio,
      "brandColor": currentUser.brandColor,
      "cardTitle": currentUser.cardTitle,
      "linkedIn": '',
      'profileLink': currentUser.profileLink
    }).then((value) {
      log("Current Anonymous User Detail has been saved in Locally from getDataFromFireStore");
    }).catchError((e) {
      // EasyLoading.dismiss();
      log("Error while saving Anonymous User Detail in Locally $e");
    });

    ///
    pref.getStringData(UsersKey.currentUserKey).then((value) {
      log("saved it current  userID: $value");
    });
  }

  /// end save data locally
  /// get data from fireStore database
  Future<void> getDataFromFireStore() async {
    await FirebaseServices.readDocumentData("users", _auth.currentUser!.uid)
        .then((value) {
      log("Successfully read current user data : $value");
      userModel = UserDataModel.fromJson(value!);
      saveDataLocally(userModel);
      log("After Assign to UserDataModel,  read current user data : ${userModel.cardTitle}");
    }).catchError((e) {
      log("getDataFromFireStore error: $e");
    });
  }

  Future<void> updateUserData() async {
    var currentUser = _auth.currentUser;
    AlertMessage.showLoading();
    Map<String, dynamic> userInfo = {
      'displayName': nameController.text,
      // 'email': userModel.email.toString(),
      // 'phoneNumber': currentUser?.providerData[0].phoneNumber,
      // 'photoURL': profileImageString,
      // 'providedId': currentUser?.providerData[0].providerId,
      'uid': currentUser?.uid,
      // 'emailVerified': currentUser?.emailVerified,
      // 'creationTime': currentUser?.metadata.creationTime.toString(),
      // 'lastSignInTime': currentUser?.metadata.lastSignInTime.toString(),
      // 'created': DateTime.now().toIso8601String(),
      'updated': DateTime.now().toIso8601String(),
      // 'isDeleted': 0,
      // 'instagram': '',
      // 'website': '',
      // 'contactCard': '',
      // "qrCode": '',
      // "coverURL": coverImageString,
      // "logoURL": logoImageString,
      "jobTitle": jobTitleController.text,
      "companyName": companyController.text,
      "address": addressController.text,
      "bio": bioController.text,
      // "brandColor": '',
      "cardTitle": cardTitleController.text
    };
    await FirebaseServices.updateData('users', currentUser?.uid, userInfo)
        .then((value) {
      log("Successfully updated: ");
    }).catchError((e) {
      log("Error while updating profile data:  $e");
    });
    // await FirebaseServices.addData('card', currentUser?.uid, userInfo)
    //     .then((value) {
    //   log("Successfully updated: ");
    // }).catchError((e) {
    //   log("Error while updating profile data:  $e");
    // });
    AlertMessage.dismissLoading();
  }

  uploadAndGetUrl({required var image, required ImageTypes types}) async {
    var currentUser = _auth.currentUser;
    switch (types) {
      case ImageTypes.coverImage:
        if (image != null) {
          _getImageUrl(image).then((value) async {
            coverImageString = value;
            log("Cover Http Image Path: $coverImageString");
            AlertMessage.showLoading();
            await FirebaseServices.updateData(
                    'users', currentUser?.uid, {"coverURL": coverImageString})
                .then((value) async {
              AlertMessage.successMessage(
                  "Image has been updated in fireStore");
              await getDataFromFireStore();
              log("Successfully updated: ");
            }).catchError((e) {
              AlertMessage.dismissLoading();
              log("Error while updating profile data:  $e");
            });
          }).catchError((e) {
            log("Error while getting Cover http image path: $e");
          });
        } else {
          log("No Cover Image selected");
        }

        break;
      case ImageTypes.profileImage:
        if (image != null) {
          _getImageUrl(image).then((value) async {
            profileImageString = value;
            log("Profile Http Image Path: $profileImageString");
            AlertMessage.showLoading();
            await FirebaseServices.updateData(
                    'users', currentUser?.uid, {"photoURL": profileImageString})
                .then((value) async {
              AlertMessage.successMessage(
                  "Image has been updated in fireStore");
              await getDataFromFireStore();
              log("Successfully updated: ");
            }).catchError((e) {
              AlertMessage.dismissLoading();
              log("Error while updating profile data:  $e");
            });
          }).catchError((e) {
            log("Error while getting profile http image path: $e");
          });
        } else {
          log("No Profile Image selected");
        }

        break;
      case ImageTypes.logoImage:
        if (image != null) {
          _getImageUrl(image).then((value) async {
            logoImageString = value;
            log("Logo Http Image Path: $logoImageString");
            AlertMessage.showLoading();
            await FirebaseServices.updateData(
                    'users', currentUser?.uid, {"logoURL": logoImageString})
                .then((value) async {
              AlertMessage.successMessage(
                  "Image has been updated in fireStore");
              await getDataFromFireStore();
              log("Successfully updated: ");
            }).catchError((e) {
              AlertMessage.dismissLoading();
              log("Error while updating profile data:  $e");
            });
          }).catchError((e) {
            log("Error while getting Logo http image path: $e");
          });
        } else {
          log("No Logo image selected");
        }

        break;
      default:
        null;
    }
  }

  Future<String> _getImageUrl(var image) async {
    AlertMessage.showLoading();
    var imagePath = await FirebaseServices.uploadImage(image);
    // log("Cover Http Image Path: $coverImage");
    AlertMessage.successMessage("Your Image has been uploaded");
    AlertMessage.dismissLoading();
    return imagePath;
  }

  onSaveButtonPressed(var context) async {
    log("save button pressed");
    await updateUserData().then((value) async {
      await getDataFromFireStore();
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const ShareQRCodeScreen(),
        ),
      );
    }).catchError((e) {});
  }
}
