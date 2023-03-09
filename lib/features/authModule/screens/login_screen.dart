import 'package:biz_card/features/authModule/screens/sign_up_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/helpers/auth_enum.dart';
import '../../../core/helpers/helpers.dart';
import '../../components/app_text_field.dart';
import '../../components/text_button.dart';
import '../../providers/auth_provider.dart';
import '../components/rich_text_widget.dart';

Status type = Status.login;

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey();

  bool obscure = true;
  // final FirebaseAuth auth = FirebaseAuth.instance;
  @override
  void initState() {
    // TODO: implement initState
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

  void _switchType() {
    if (type == Status.signUp) {
      setState(() {
        type = Status.login;
      });
    } else {
      setState(() {
        type = Status.signUp;
      });
    }
    // print(type);
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
              Future<void> onPressedFunction() async {
                if (!_formKey.currentState!.validate()) {
                  return;
                }
                // print(_email.text); // This are your best friend for debugging things
                //  not to mention the debugging tools
                // print(_password.text);
                if (type == Status.login) {
                  loading();
                  await auth
                      .signInWithEmailAndPassword(
                        context: context,
                        // email: auth.emailController.text,
                        // password: auth.passwordController.text
                      )
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

              Future<void> loginWithGoogle() async {
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
                        'Login with your account to continue the app',
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
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 15, vertical: 15),
                      child: AppTextField(
                        controller: auth.emailController,
                        borderColor: Colors.grey,
                        enableBorder: true,
                        prefixImage: "assets/icons/email-icon.svg",
                        placeHolder: 'Email',
                        prefixIcon: Icons.email_outlined,
                        isPrefixEnabled: false,
                        errorText: auth.isEmailError == false
                            ? null
                            : auth.errorEmailText,
                        // auth.isEmailError == true
                        //     ? auth.loginEmailErrorText
                        //     : null,
                        onChangeText: (String value) {
                          setState(() {});
                        },
                        onSubmit: (String value) {},
                        // imageIcon: 'email.svg',
                        // suffixIcon: Icon(Icons.email),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 15, vertical: 10),
                      child: AppTextField(
                        controller: auth.passwordController,
                        borderColor: Colors.grey,
                        placeHolder: 'Password',
                        prefixImage: "assets/icons/password-icon.svg",
                        isPrefixEnabled: false,
                        prefixIcon: CupertinoIcons.lock_circle,
                        // imageIcon: 'lock.svg',
                        errorText: auth.isPasswordError == false
                            ? null
                            : auth.errorPasswordText,
                        // errorText: auth.isPasswordError == true
                        //     ? auth.loginPasswordErrorText
                        //     : null,
                        isSuffixEnabled: true,
                        changeObscureText: () {
                          setState(() {
                            obscure = !obscure;
                          });
                        },
                        obscureText: obscure,
                        suffixIcon:
                            "assets/icons/${obscure == true ? 'eye-on' : 'eye-off'}.svg",
                        onChangeText: (String value) {
                          setState(() {});
                        },
                        onSubmit: (String value) {},
                      ),
                    ),
                    // Align(
                    //   alignment: AlignmentDirectional.centerEnd,
                    //   child: Padding(
                    //     padding: const EdgeInsets.symmetric(
                    //       horizontal: 15,
                    //     ),
                    //     child: TextButton(
                    //       style: ButtonStyle(
                    //         textStyle: MaterialStateProperty.all(
                    //           const TextStyle(
                    //               fontSize: 16,
                    //               fontWeight: FontWeight.w500,
                    //               color: Colors.blue),
                    //         ),
                    //         shape: MaterialStateProperty.all(
                    //           RoundedRectangleBorder(
                    //             borderRadius: BorderRadius.circular(100),
                    //           ),
                    //         ),
                    //       ),
                    //       onPressed: () {},
                    //       child: const Text('Forgot Password?'),
                    //     ),
                    //   ),
                    // ),
                    SizedBox(
                      height: screenHeightPercentage(context) * 0.025,
                    ),

                    ///
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 15, vertical: 20),
                      child: _isLoading
                          ? const Center(child: CircularProgressIndicator())
                          : AppTextButton(
                              title: 'Sign In',
                              onPressed: onPressedFunction,
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
                      child: _isLoading2
                          ? const Center(
                              child: CircularProgressIndicator(),
                            )
                          : AppTextButton(
                              backgroundColor: Colors.white,
                              textColor: Colors.black,
                              elevation: 2,
                              title: 'Sign in with Google',
                              isImageIcon: true,
                              imageIcon: "assets/icons/google.svg",
                              onPressed: loginWithGoogle,
                              // () async {
                              // signInWithGoogle().then((value) {
                              //   log("Google Sign In:  ${value}");
                              // }).catchError((e) {
                              //   log("Google Sign-in Error: ${e}");
                              // });
                              // },
                            ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 20),
                      child: RichTextWidget(
                        firstTitle: "Don't Have An Account?  ",
                        secondTitle: "Sign Up",
                        onTap: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) {
                            return const SignUpScreen();
                          }));
                        },
                      ),
                    ),
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
