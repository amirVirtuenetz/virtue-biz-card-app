import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../../../core/helpers/auth_enum.dart';
import '../../../core/helpers/helpers.dart';
import '../../../core/helpers/navigation_function.dart';
import '../../components/app_text_field.dart';
import '../../components/text_button.dart';
import '../../providers/auth_provider.dart';
import '../components/rich_text_widget.dart';

Status type = Status.signUp;

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
  bool obscure = true;
  bool confirmObscure = true;
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final FirebaseAuth auth = FirebaseAuth.instance;
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {});

    super.initState();
  }

  @override
  void setState(fn) {
    if (mounted) {
      super.setState(fn);
    }
  }

  bool _isLoading = false;
  bool _isLoading2 = false;
  void loading() {
    setState(() {
      _isLoading = !_isLoading;
    });
  }

  void loading2() {
    if (mounted) {
      setState(() {
        _isLoading2 = !_isLoading2;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.only(bottom: 10),
            child: Consumer(builder: (context, ref, _) {
              final auth = ref.watch(authenticationProvider);
              Future<void> onPressedSignUpFunction() async {
                if (!_formKey.currentState!.validate()) {
                  return;
                }
                if (type == Status.signUp) {
                  loading();
                  await auth
                      .signUpWithEmailAndPassword(
                          // email: auth.signUpEmailController.text,
                          // password: auth.signUpPasswordController.text,
                          context: context)
                      .whenComplete(
                        () => auth.authStateChange.listen(
                          (event) async {
                            if (event == null) {
                              loading();
                              return;
                            }
                          },
                        ),
                      );
                }
              }

              Future<void> signInWithGoogle() async {
                loading2();
                await auth.onGoogleButtonPress(context).whenComplete(
                      () => auth.authStateChange.listen(
                        (event) async {
                          // log("Google Sign-In : $event");
                          if (event == null) {
                            loading2();
                            return;
                          }
                        },
                      ),
                    );
              }

              return Form(
                key: _formKey,
                child: Column(
                  // mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: screenHeightPercentage(context) * 0.05,
                    ),
                    const Align(
                      alignment: Alignment.center,
                      child: CircleAvatar(
                        radius: 60,
                        backgroundImage:
                            AssetImage("assets/images/bizCardLogo.png"),
                        // child: Image.asset(
                        //   'assets/images/bizCardLogo.png',
                        //   fit: BoxFit.fill,
                        // ),
                      ),
                    ),
                    const Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 25, vertical: 25),
                      child: Text(
                        'Sign up with your account to continue the app',
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                            fontFamily: "InterRegular",
                            color: Colors.black),
                      ),
                    ),
                    SizedBox(
                      height: screenHeightPercentage(context) * 0.05,
                    ),

                    /// name field
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 15, vertical: 15),
                      child: AppTextField(
                        controller: auth.signUpNameController,
                        borderColor: Colors.grey,
                        textInputAction: TextInputAction.next,
                        keyboardType: TextInputType.name,
                        placeHolder: 'Name',
                        prefixIcon: FontAwesomeIcons.user,
                        prefixIconSize: 18,
                        isPrefixEnabled: false,
                        errorText: auth.isSignUpNameError == false
                            ? null
                            : auth.errorSignUpNameText,
                        onChangeText: (String value) {
                          setState(() {});
                        },
                        onSubmit: (String value) {},
                        // imageIcon: 'email.svg',
                        // suffixIcon: Icon(Icons.email),
                      ),
                    ),

                    /// email field
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 15, vertical: 15),
                      child: AppTextField(
                        controller: auth.signUpEmailController,
                        placeHolder: "Email",
                        textInputAction: TextInputAction.next,
                        keyboardType: TextInputType.emailAddress,
                        prefixIcon: FontAwesomeIcons.envelope,
                        prefixIconSize: 18,
                        isPrefixEnabled: false,
                        errorText: auth.isSignUpEmailError == false
                            ? null
                            : auth.errorSignUpEmailText,
                        onChangeText: (String value) {
                          setState(() {});
                        },
                        onSubmit: (String value) {},
                        // imageIcon: 'email.svg',
                        // suffixIcon: Icon(Icons.email),
                      ),
                    ),

                    /// password field
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 15, vertical: 10),
                      child: AppTextField(
                        controller: auth.signUpPasswordController,
                        placeHolder: 'Password',
                        keyboardType: TextInputType.visiblePassword,
                        textInputAction: TextInputAction.next,
                        isPrefixEnabled: false,
                        prefixIcon: CupertinoIcons.lock_circle,
                        prefixIconSize: 20,
                        isSuffixEnabled: true,
                        changeObscureText: () {
                          setState(() {
                            obscure = !obscure;
                          });
                        },
                        obscureText: obscure,
                        suffixIcon:
                            "assets/icons/${obscure == true ? 'eye-on.svg' : 'eye-off.svg'}",
                        errorText: auth.isSignUpPasswordError == false
                            ? null
                            : auth.errorSignUpPasswordText,
                        onChangeText: (String value) {
                          setState(() {});
                        },
                        onSubmit: (String value) {},
                      ),
                    ),

                    /// confirm password
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 15, vertical: 10),
                      child: AppTextField(
                        controller: auth.signUpConfirmPasswordController,
                        placeHolder: 'Confirm Password',
                        isPrefixEnabled: false,
                        prefixIcon: CupertinoIcons.lock_circle,
                        prefixIconSize: 20,
                        // imageIcon: 'lock.svg',
                        isSuffixEnabled: true,
                        changeObscureText: () {
                          setState(() {
                            confirmObscure = !confirmObscure;
                          });
                        },
                        obscureText: confirmObscure,
                        suffixIcon:
                            "assets/icons/${confirmObscure == true ? 'eye-on.svg' : 'eye-off.svg'}",
                        errorText: auth.isSignUpConfirmPasswordError == false
                            ? null
                            : auth.errorSignUpConfirmPasswordText,
                        onChangeText: (String value) {
                          setState(() {});
                        },
                        onSubmit: (String value) {},
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),

                    ///
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 15, vertical: 20),
                      child: AppTextButton(
                        title: 'Sign Up',
                        onPressed: onPressedSignUpFunction,
                      ),
                    ),
                    const Align(
                      alignment: Alignment.center,
                      child: Text(
                        'OR',
                        // style: GoogleFonts.manrope(
                        //     textStyle: TextStyle(
                        //       fontSize: 12.sp,
                        //       fontWeight: FontWeight.normal,
                        //     ),
                        // ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 15, vertical: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            alignment: Alignment.center,
                            height: 2,
                            padding: const EdgeInsets.symmetric(horizontal: 50),
                            color: Colors.grey,
                          ),
                          const Text(
                            'Social Login',
                            // style: GoogleFonts.manrope(
                            //     textStyle: TextStyle(
                            //       fontSize: 12.sp,
                            //       fontWeight: FontWeight.normal,
                            //     ),
                            // ),
                          ),
                          Container(
                            alignment: Alignment.center,
                            height: 2,
                            padding: const EdgeInsets.symmetric(horizontal: 50),
                            color: Colors.grey,
                          ),
                        ],
                      ),
                    ),

                    ///
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 15, vertical: 20),
                      child: AppTextButton(
                        backgroundColor: Colors.white,
                        textColor: Colors.black,
                        elevation: 2,
                        title: 'Sign in with Google',
                        isImageIcon: true,
                        imageIcon: "assets/icons/google.svg",
                        onPressed: signInWithGoogle,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 20),
                      child: RichTextWidget(
                        firstTitle: "Already have an account?  ",
                        secondTitle: "Sign In",
                        onTap: () {
                          CustomNavigator.pop(context);
                        },
                      ),
                    ),

                    ///
                  ],
                ),
              );
            }),
          ),
        ),
      ),
    );
  }
}
