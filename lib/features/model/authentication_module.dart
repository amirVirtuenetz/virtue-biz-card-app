import 'dart:developer';

import 'package:biz_card/features/model/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../../core/helpers/alert_message.dart';
import '../../core/helpers/auth_enum.dart';
import '../../core/helpers/key_constant.dart';
import '../services/firebase_services.dart';
import '../services/shared_preference.dart';

// Now This Class Contains 4 Functions currently
// 1. signInWithGoogle
// 2. signOut
// 3. signInWithEmailAndPassword
// 4. signUpWithEmailAndPassword
//  All these functions are async because this involves a future.
//  if async keyword is not used, it will throw an error.
class Authentication {
  // For Authentication related functions you need an instance of FirebaseAuth
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  /// sharedPreference
  final SharePreferencesClass pref = SharePreferencesClass();
  //  This getter will be returning a Stream of User object.
  //  It will be used to check if the user is logged in or not.
  Stream<User?> get authStateChange => _auth.authStateChanges();

  /// TextEditingController
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  /// sign up TextEditingController
  final TextEditingController signUpNameController = TextEditingController();
  final TextEditingController signUpEmailController = TextEditingController();
  final TextEditingController signUpPasswordController =
      TextEditingController();
  final TextEditingController signUpConfirmPasswordController =
      TextEditingController();

  /// user model
  UserDataModel userModel = UserDataModel();

  /// sign Up Form bool check variable
  bool isSignUpNameError = false;
  bool isSignUpEmailError = false;
  bool isSignUpPasswordError = false;
  bool isSignUpConfirmPasswordError = false;

  /// declare variable for error
  bool isEmailError = false;
  bool isPasswordError = false;
  String loginEmailErrorText = '';
  String loginPasswordErrorText = '';

  /// declare variable for updating user profile data

  String coverImage = '';
  String profileImage = '';
  String logoImage = '';

  ///sign in function
  Future<dynamic> signInWithEmailAndPassword({
    var context,
    // required String email, required String password
  }) async {
    // bool isEmail = validateEmail(emailController.text);
    if (emailController.text.trim().isEmpty) {
      isEmailError = true;
      loginEmailErrorText = 'Email should not be empty';
    } else if (passwordController.text.trim().isEmpty) {
      isPasswordError = true;
      loginPasswordErrorText = 'Password should not be empty';
    } else {
      try {
        EasyLoading.show();
        await _auth
            .signInWithEmailAndPassword(
                email: emailController.text.trim(),
                password: passwordController.text.trim())
            .then((value) {
          AlertMessage.successMessage(
              "You have successfully login with your account");
          emailController.clear();
          passwordController.clear();
          isEmailError = false;
          loginEmailErrorText = "";
          isPasswordError = false;
          loginPasswordErrorText = "";
          log("Login Successfully: $value");
        });
        await _auth.currentUser?.reload();
        log("current user id ${_auth.currentUser?.uid}");
        // var currentUser = _auth.currentUser;
        await getDataFromFireStore();
        EasyLoading.dismiss();
      } on FirebaseAuthException catch (e) {
        log("firebaseException: $e");
        switch (e.code) {
          case "invalid-email":
            EasyLoading.dismiss();
            isEmailError = true;
            loginEmailErrorText = 'Email format is incorrect';
            // emailErrorText = 'your email is incorrect';
            // AlertMessage.showMessage(context, 'your email format is incorrect');
            // notifyListeners();
            break;
          case "too-many-requests":
            EasyLoading.dismiss();
            AlertMessage.showMessage(
                context, 'Too many requests, please try again later');
            // notifyListeners();
            break;
          case "user-not-found":
            EasyLoading.dismiss();
            AlertMessage.showMessage(context,
                'There is no user record found corresponding to this identifier');
            break;
          case "wrong-password":
            EasyLoading.dismiss();
            isPasswordError = true;
            loginPasswordErrorText = "Your password is incorrect";
            break;
        }
        log("Firebase Exception-1: $e");
        if (e.toString().contains('firebase_auth/network-request-failed')) {
          EasyLoading.dismiss();
          AlertMessage.showMessage(context, "No Internet Connection");
        }
      }
    }
  }

  /// check if email is valid or not
  bool validateEmail(String value) {
    Pattern p1 =
        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+";
    Pattern pattern =
        r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]"
        r"{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]"
        r"{0,253}[a-zA-Z0-9])?)*$";
    RegExp regex = RegExp(p1.toString());
    return regex.hasMatch(value);
  }

  /// check google user is already logged in or not
  Future<bool> checkGoogleUser() async {
    bool isLoggedIn = false;
    _googleSignIn.onCurrentUserChanged.listen((GoogleSignInAccount? account) {
      if (account != null) {
        isLoggedIn = true;
      } else {
        isLoggedIn = false;
      }
    });

    return isLoggedIn;
  }

  /// sign up with email and password
  Future<void> signUpWithEmailAndPassword({var context}) async {
    // bool isEmail = validateEmail(signUpEmailController.text);
    if (signUpNameController.text.isEmpty) {
      isSignUpNameError = true;
    } else if (signUpEmailController.text.isEmpty) {
      isSignUpEmailError = true;
    } else if (signUpPasswordController.text.isEmpty) {
      isSignUpPasswordError = true;
    } else if (signUpConfirmPasswordController.text.isEmpty) {
      isSignUpConfirmPasswordError = true;
    } else {
      try {
        EasyLoading.show();
        UserCredential userCredential =
            await _auth.createUserWithEmailAndPassword(
                email: signUpEmailController.text.trim(),
                password: signUpPasswordController.text.trim());
        log("userCredential $userCredential");
        AlertMessage.successMessage(
            "You have successfully sign up with your account");
        isSignUpNameError = false;
        isSignUpEmailError = false;
        isSignUpPasswordError = false;
        isSignUpConfirmPasswordError = false;
        var currentUser = _auth.currentUser;
        // saveDataLocally(currentUser);
        Map<String, dynamic> userInfo = {
          'displayName': signUpNameController.text,
          'email': signUpEmailController.text,
          'phoneNumber': currentUser?.providerData[0].phoneNumber,
          'photoURL': currentUser?.providerData[0].photoURL,
          'providedId': currentUser?.providerData[0].providerId,
          'uid': currentUser?.uid,
          'emailVerified': currentUser?.emailVerified,
          'creationTime': currentUser?.metadata.creationTime.toString(),
          'lastSignInTime': currentUser?.metadata.lastSignInTime.toString(),
          'created': DateTime.now().toIso8601String(),
          'updated': '',
          'isDeleted': 0,
          'instagram': '',
          'website': '',
          'contactCard': '',
          "qrCode": '',
          "coverURL": '',
          "logoURL": '',
          "jobTitle": '',
          "companyName": '',
          "address": '',
          "bio": '',
          "brandColor": '',
          "cardTitle": '',
          "linkedIn": '',
          "list": '',
          'profileLink': ''
        };
        await FirebaseServices.addData('users', currentUser?.uid, userInfo);
        signUpNameController.clear();
        signUpEmailController.clear();
        signUpPasswordController.clear();
        signUpConfirmPasswordController.clear();
        EasyLoading.dismiss();

        ///
        // AlertMessage.showMessage(
        //     context, 'you have successfully create your account.');
        // fullNameController.clear();
        // signUpEmailController.clear();
        // signUpPasswordController.clear();
        // signUpConfirmPasswordController.clear();
        // CustomNavigator.pushAndRemoveAllStack(context, const DashboardScreen());
      } on FirebaseAuthException catch (e) {
        switch (e.code) {
          case "weak-password":
            log("weak-password : ${e.code}");
            AlertMessage.showMessage(context, 'your password is weak');
            // EasyLoading.dismiss();
            break;
          case "email-already-in-use":
            log("email-already-in-use : ${e.code}");
            isSignUpEmailError = true;
            // _isSignUpEmailErrorText = "This email already exist";
            AlertMessage.showMessage(context, 'This email already exist');
            EasyLoading.dismiss();
            break;
        }
      }
    }
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

  Future<void> getDataFromFireStore() async {
    await FirebaseServices.readDocumentData("users", _auth.currentUser!.uid)
        .then((value) {
      log("Successfully read current user data : $value");
      userModel = UserDataModel.fromJson(value!);
      saveDataLocally(userModel);
      log("After Assign to UserDataModel,  read current user data : ${userModel.email}");
    }).catchError((e) {
      log("getDataFromFireStore error: $e");
    });
  }

  /// add data to firebase
  Future<void> addToFirebaseData(var currentUserInstance) async {
    var currentUser = currentUserInstance;
    Map<String, dynamic> userInfo = {
      'displayName': currentUser?.displayName,
      'email': currentUser?.email,
      'phoneNumber': currentUser?.providerData[0].phoneNumber,
      'photoURL': currentUser?.providerData[0].photoURL,
      'providedId': currentUser?.providerData[0].providerId,
      'uid': currentUser?.uid,
      'emailVerified': currentUser?.emailVerified,
      'creationTime': currentUser?.metadata.creationTime.toIso8601String(),
      'lastSignInTime': currentUser?.metadata.lastSignInTime.toIso8601String(),
      'created': DateTime.now().toIso8601String(),
      'updated': '',
      'isDeleted': 0,
      'instagram': '',
      'website': '',
      'contactCard': '',
      "qrCode": '',
      "coverURL": '',
      "logoURL": '',
      "jobTitle": '',
      "companyName": '',
      "address": '',
      "bio": '',
      "brandColor": '',
      "cardTitle": '',
      "linkedIn": '',
      "list": '',
      'profileLink': ''
    };
    await FirebaseServices.addData('users', currentUser?.uid, userInfo)
        .then((value) {
      log("Data has been saved in FireStore Database ");
    }).catchError((e) {
      log("Error while saving data in FireStore Database");
    });
  }

  /// update data to firestore and locally

  uploadAndGetUrl({required var image, required ImageTypes types}) async {
    switch (types) {
      case ImageTypes.coverImage:
        _getImageUrl(image).then((value) {
          coverImage = value;
          log("Cover Http Image Path: $coverImage");
        }).catchError((e) {
          log("Error while getting Cover http image path: $e");
        });
        break;
      case ImageTypes.profileImage:
        _getImageUrl(image).then((value) {
          profileImage = value;
          log("Profile Http Image Path: $profileImage");
        }).catchError((e) {
          log("Error while getting profile http image path: $e");
        });
        break;
      case ImageTypes.logoImage:
        _getImageUrl(image).then((value) {
          logoImage = value;
          log("Logo Http Image Path: $logoImage");
        }).catchError((e) {
          log("Error while getting Logo http image path: $e");
        });
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

  ///
  Future<void> onGoogleButtonPress(var context) async {
    await signInWithGoogle(context).then((value) async {
      log('Google Sign-in onGoogleButtonPress: ${value.user}');
      var currentUser = value.user;
      log("Current Google User: $currentUser");

      /// data saved in firebase
      await addToFirebaseData(currentUser);
      await getDataFromFireStore();

      /// data saved in shared preferences
      // saveDataLocally(currentUser);
    }).catchError((e) {
      log("Google Sign in error : $e");
    });
  }

  ///
  Future<UserCredential> signInWithGoogle(var context) async {
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
    // log("google user ${googleUser}");

    // preferenceClass.storeObjectData(UsersKey.googleUserKey, googleUser);
    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;
    log("user google sign in credential ${googleAuth?.accessToken}");
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );
    return await _auth.signInWithCredential(credential);
  }

  Future<void> signOutGoogle() async {
    await _googleSignIn.signOut();
    await _auth.signOut();
    // await _googleSignIn.disconnect();
    // await FirebaseAuth.instance.signOut();
    // preferenceClass.removeData(UsersKey.googleUserKey);
    log("User Sign Out");
  }

  ///
  /// check email exist or not
  Future<bool> checkIfEmailUsed(String email, var context) async {
    try {
      final data = await _auth.fetchSignInMethodsForEmail(email);
      if (data.isNotEmpty) {
        return true;
      } else {
        // AlertMessage.showMessage(
        //     context, 'Email already exist. try with another Email');
        return false;
      }
    } catch (e) {
      log("Firebase error: $e");
      return true;
    }
  }

  //  SignOut the current user
  Future<void> signOut() async {
    await _auth.signOut();
  }

  /// for email field
  String? get errorEmailText {
    final text = emailController.value.text;
    bool isEmail = validateEmail(emailController.text);
    if (text.isEmpty) {
      return "Email should not be empty";
    }
    if (!isEmail) {
      return "Email is Invalid";
    }
    return null;
  }

  /// for password field
  String? get errorPasswordText {
    final text = passwordController.value.text;
    if (text.isEmpty) {
      return "Password should not be empty";
    }
    return null;
  }

  /// error check for sign-up screen
  /// for Name field
  String? get errorSignUpNameText {
    final text = signUpNameController.value.text;

    if (text.isEmpty) {
      return "Name should not be empty";
    }
    // else if (text.length < 4) {
    //   return "Name should not be less than 4 characters";
    // }
    return null;
  }

  String? get errorSignUpEmailText {
    final text = signUpEmailController.value.text;
    bool isEmail = validateEmail(signUpEmailController.text);
    if (text.isEmpty) {
      return "Email should not be empty";
    }
    if (!isEmail) {
      return "Email is Invalid";
    }
    return null;
  }

  /// for password field
  String? get errorSignUpPasswordText {
    final text = signUpPasswordController.value.text;
    if (text.isEmpty) {
      return "Password should not be empty";
    }
    return null;
  }

  /// for confirm  password field
  String? get errorSignUpConfirmPasswordText {
    final confirmPassword = signUpConfirmPasswordController.value.text;
    final password = signUpPasswordController.value.text;
    if (password != confirmPassword) {
      return "Password did not match";
    }
    return null;
  }
}
