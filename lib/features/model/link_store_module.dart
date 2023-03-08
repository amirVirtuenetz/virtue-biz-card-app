import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../core/helpers/alert_message.dart';
import '../../core/helpers/auth_enum.dart';
import '../services/firebase_services.dart';
import '../services/shared_preference.dart';

class LinkStoreModuleClass {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final SharePreferencesClass pref = SharePreferencesClass();

  final TextEditingController controller = TextEditingController();
  // Stream<User?> get authStateChange => _auth.authStateChanges();

  Future<void> _updateSocialLink(Map<String, dynamic> data) async {
    var currentUser = _auth.currentUser;
    AlertMessage.showLoading();
    await FirebaseServices.updateData('users', currentUser?.uid, data)
        .then((value) {
      log("Successfully updated: ");
    }).catchError((e) {
      log("Error while updating profile data:  $e");
    });
    AlertMessage.dismissLoading();
  }

  updateLink({required SocialLinkTypes type}) async {
    switch (type) {
      case SocialLinkTypes.number:
        if (controller.text.trim().isEmpty) {
          AlertMessage.warningMessage("Please enter your phone number");
        } else {
          Map<String, dynamic> userInfo = {
            'updated': DateTime.now().toIso8601String(),
            'phoneNumber': controller.text,
          };
          _updateSocialLink(userInfo).then((value) {
            controller.clear();
            AlertMessage.successMessage("Your Phone number has been added");
          });
        }
        break;
      case SocialLinkTypes.email:
        if (controller.text.trim().isEmpty) {
          AlertMessage.warningMessage("Please enter your email address");
        } else {
          Map<String, dynamic> userInfo = {
            'updated': DateTime.now().toIso8601String(),
            'email': controller.text,
          };
          _updateSocialLink(userInfo).then((value) {
            controller.clear();
            AlertMessage.successMessage("Your Email has been added");
          });
        }
        break;
      case SocialLinkTypes.instagram:
        if (controller.text.trim().isEmpty) {
          AlertMessage.warningMessage("Please enter your instagram username");
        } else {
          var username = "https://instagram.com/${controller.text}";
          Map<String, dynamic> userInfo = {
            'updated': DateTime.now().toIso8601String(),
            'instagram': username,
          };
          _updateSocialLink(userInfo).then((value) {
            controller.clear();
            AlertMessage.successMessage("Your instagram link has been added");
          });
        }

        break;
      case SocialLinkTypes.website:
        if (controller.text.trim().isEmpty) {
          AlertMessage.warningMessage("Please enter your website link");
        } else {
          bool validURL = Uri.parse(controller.text).isAbsolute;
          if (validURL) {
            log("link is valid");
            Map<String, dynamic> userInfo = {
              'updated': DateTime.now().toIso8601String(),
              'website': controller.text,
            };
            _updateSocialLink(userInfo).then((value) {
              controller.clear();
              AlertMessage.successMessage("Your website link has been added");
            });
          } else {
            AlertMessage.warningMessage("This link is not valid");
            log("link invalid");
          }
        }
        break;
      case SocialLinkTypes.linkedIn:
        Map<String, dynamic> userInfo = {
          'updated': DateTime.now().toIso8601String(),
          'linkedIn': controller.text,
        };
        _updateSocialLink(userInfo).then((value) {
          controller.clear();
          AlertMessage.successMessage("Your linkedIn url has been added");
        });
        break;
      case SocialLinkTypes.contactCard:
        Map<String, dynamic> userInfo = {
          'updated': DateTime.now().toIso8601String(),
          'contactCard': controller.text,
        };
        _updateSocialLink(userInfo).then((value) {
          controller.clear();
          AlertMessage.successMessage("Your contact card has been added");
        });
        break;
      default:
        break;
    }
  }

  String? validateMobile(String value) {
    String patttern = r'(^(?:[+0]9)?[0-9]{10,12}$)';
    RegExp regExp = RegExp(patttern);
    if (value.isEmpty) {
      return 'Please enter mobile number';
    } else if (!regExp.hasMatch(value)) {
      return 'Please enter valid mobile number';
    }
    return null;
  }
}
