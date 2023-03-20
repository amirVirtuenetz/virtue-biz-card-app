import 'package:biz_card/core/helpers/alert_message.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../providers/auth_provider.dart';
import '../components/container.dart';
import '../components/setting_list_tile.dart';

// class SettingScreen extends ConsumerStatefulWidget {
//   const SettingScreen({Key? key}) : super(key: key);
//
//   @override
//   ConsumerState<SettingScreen> createState() => _SettingScreenState();
// }
//
// class _SettingScreenState extends ConsumerState<SettingScreen>
//     with WidgetsBindingObserver {
//   late var userProvider;
//
//   @override
//   void initState() {
//     super.initState();
//
//     userProvider = ref.read(userProvider);
//     WidgetsBinding.instance.addObserver(this);
//   }
//
//   @override
//   void dispose() {
//     WidgetsBinding.instance.removeObserver(this);
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         centerTitle: true,
//         elevation: 0,
//         scrolledUnderElevation: 0,
//         title: const Text("Biz Card"),
//         automaticallyImplyLeading: false,
//         leading: Transform.translate(
//           offset: const Offset(12, 0),
//           child: IconButton(
//             onPressed: () {},
//             icon: const Icon(FontAwesomeIcons.locationArrow),
//           ),
//         ),
//         actions: [
//           Transform.translate(
//             offset: const Offset(-10, 0),
//             child: Material(
//               color: Colors.transparent,
//               borderRadius: BorderRadius.circular(10),
//               child: InkWell(
//                 borderRadius: BorderRadius.circular(10),
//                 onTap: () {},
//                 child: const SizedBox(
//                   width: 100,
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                     crossAxisAlignment: CrossAxisAlignment.center,
//                     children: [
//                       Text(
//                         "Invite",
//                         style: TextStyle(
//                           fontSize: 16,
//                         ),
//                       ),
//                       Icon(
//                         FontAwesomeIcons.gift,
//                         size: 18,
//                       )
//                     ],
//                   ),
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ),
//       body: SafeArea(
//         child: SingleChildScrollView(
//           child: Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.start,
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 const Text(
//                   "Settings",
//                   style: TextStyle(
//                     fontSize: 26,
//                     fontWeight: FontWeight.w700,
//                   ),
//                 ),
//                 // Text(data.currentUser!.email ?? 'You are logged In'),
//                 SizedBox(
//                   height: 20,
//                 ),
//                 BackgroundContainer(
//                   child: Column(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       const Padding(
//                         padding: EdgeInsets.symmetric(horizontal: 10),
//                         child: Text(
//                           "My Insights",
//                           style: TextStyle(
//                             fontSize: 16,
//                             fontWeight: FontWeight.w400,
//                           ),
//                         ),
//                       ),
//                       Padding(
//                         padding: const EdgeInsets.all(4.0),
//                         child: SettingListTile(
//                           title: "Amir Chachar",
//                           textStyle: const TextStyle(
//                             fontWeight: FontWeight.bold,
//                             fontSize: 16,
//                           ),
//                           onTap: () {},
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//                 SizedBox(
//                   height: 20,
//                 ),
//                 BackgroundContainer(
//                   child: Column(
//                     children: [
//                       SettingSecondListTile(
//                         title: "Activate a Popl Device",
//                         backgroundColor: Colors.transparent,
//                         onTap: () {},
//                       ),
//                       SettingSecondListTile(
//                         backgroundColor: Colors.transparent,
//                         title: "How to Pop",
//                         onTap: () {},
//                       ),
//                       SettingSecondListTile(
//                         backgroundColor: Colors.transparent,
//                         title: "Gat a Popl Device(30% off)",
//                         onTap: () {},
//                       ),
//                     ],
//                   ),
//                 ),
//
//                 /// go Pro
//                 Container(
//                   padding: const EdgeInsets.only(top: 10.0),
//                   // margin: const EdgeInsets.symmetric(horizontal: 0),
//                   width: double.infinity,
//                   child: MaterialButton(
//                     onPressed: () {},
//                     // textColor: Colors.blue.shade700,
//                     elevation: 0,
//                     hoverElevation: 0,
//                     highlightElevation: 0,
//                     disabledElevation: 0,
//                     enableFeedback: false,
//                     color: const Color(0XFFF4F4F4),
//                     // textTheme: ButtonTextTheme.accent,
//                     minWidth: 100,
//                     padding: const EdgeInsets.symmetric(
//                         horizontal: 20, vertical: 20),
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(12),
//                       // side: BorderSide(color: Colors.blue.shade700),
//                     ),
//                     child: const Align(
//                       alignment: Alignment.centerLeft,
//                       child: Text(
//                         "Go Pro",
//                         textAlign: TextAlign.start,
//                         style: TextStyle(
//                           fontSize: 16,
//                           fontWeight: FontWeight.w400,
//                         ),
//                       ),
//                     ),
//                   ),
//                 ),
//
//                 /// free trial popl team
//                 Container(
//                   padding: const EdgeInsets.only(top: 10.0),
//                   // margin: const EdgeInsets.symmetric(horizontal: 0),
//                   width: double.infinity,
//                   child: MaterialButton(
//                     onPressed: () {},
//                     // textColor: Colors.blue.shade700,
//                     elevation: 0,
//                     hoverElevation: 0,
//                     highlightElevation: 0,
//                     disabledElevation: 0,
//                     enableFeedback: false,
//                     color: const Color(0XFFF4F4F4),
//                     // textTheme: ButtonTextTheme.accent,
//                     minWidth: 100,
//                     padding:
//                         const EdgeInsets.symmetric(horizontal: 0, vertical: 15),
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(12),
//                       // side: BorderSide(color: Colors.blue.shade700),
//                     ),
//                     child: ListTile(
//                       title: const Text(
//                         "Popl Teams (Free trial)",
//                         textAlign: TextAlign.start,
//                         style: TextStyle(
//                           fontSize: 16,
//                           fontWeight: FontWeight.w400,
//                         ),
//                       ),
//                       subtitle: const Text(
//                         "Set your team up with digital business cards",
//                         textAlign: TextAlign.start,
//                         style: TextStyle(
//                           fontSize: 12,
//                           fontWeight: FontWeight.w400,
//                         ),
//                       ),
//                       trailing: SizedBox(
//                           width: 30,
//                           height: 30,
//                           child: SvgPicture.asset(
//                               "assets/icons/multiple-users.svg")),
//                       // Icon(FontAwesomeIcons.users),
//                     ),
//                   ),
//                 ),
//
//                 /// complete your profile
//                 Container(
//                   padding: const EdgeInsets.only(top: 10.0),
//                   // margin: const EdgeInsets.symmetric(horizontal: 0),
//                   width: double.infinity,
//                   child: MaterialButton(
//                     onPressed: () {},
//                     // textColor: Colors.blue.shade700,
//                     elevation: 0,
//                     hoverElevation: 0,
//                     highlightElevation: 0,
//                     disabledElevation: 0,
//                     enableFeedback: false,
//                     color: const Color(0XFFF4F4F4),
//                     // textTheme: ButtonTextTheme.accent,
//                     minWidth: 100,
//                     padding: const EdgeInsets.symmetric(
//                         horizontal: 20, vertical: 15),
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(12),
//                       // side: BorderSide(color: Colors.blue.shade700),
//                     ),
//                     child: Column(
//                       mainAxisAlignment: MainAxisAlignment.start,
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         const Padding(
//                           padding: EdgeInsets.symmetric(vertical: 10),
//                           child: Text(
//                             "Complete Your Profile",
//                             textAlign: TextAlign.start,
//                             style: TextStyle(
//                               fontSize: 16,
//                               fontWeight: FontWeight.w400,
//                             ),
//                           ),
//                         ),
//                         Container(
//                           padding: const EdgeInsets.symmetric(
//                               vertical: 6, horizontal: 30),
//                           decoration: BoxDecoration(
//                             borderRadius: BorderRadius.circular(50),
//                             border:
//                                 Border.all(color: Colors.redAccent, width: 1.5),
//                           ),
//                         ),
//                         Padding(
//                           padding: const EdgeInsets.symmetric(
//                               vertical: 5, horizontal: 2),
//                           child: Row(
//                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                             children: const [
//                               Text(
//                                 "0% complete",
//                                 textAlign: TextAlign.start,
//                                 style: TextStyle(
//                                   fontSize: 12,
//                                   fontWeight: FontWeight.w400,
//                                 ),
//                               ),
//                               Text(
//                                 "0/7 tasks done",
//                                 textAlign: TextAlign.start,
//                                 style: TextStyle(
//                                   fontSize: 12,
//                                   fontWeight: FontWeight.w400,
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//                 SizedBox(
//                   height: 20,
//                 ),
//
//                 /// Auto Intro
//                 BackgroundContainer(
//                   child: Column(
//                     children: [
//                       SwitchListTile(
//                           tileColor: const Color(0XFFF4F4F4),
//                           // activeColor: Colors.lightBlueAccent,
//                           inactiveThumbColor: const Color(0XFFC8DCF7),
//                           inactiveTrackColor: const Color(0XFFA5C6F3),
//                           shape: RoundedRectangleBorder(
//                               borderRadius: BorderRadius.circular(12)),
//                           title: const Text(
//                             "Auto Intro",
//                             textAlign: TextAlign.start,
//                             style: TextStyle(
//                               fontSize: 16,
//                               fontWeight: FontWeight.w400,
//                             ),
//                           ),
//                           subtitle: const Text(
//                             "Send an email intro with you and every new connection upon connecting",
//                             textAlign: TextAlign.start,
//                             style: TextStyle(
//                               fontSize: 12,
//                               fontWeight: FontWeight.w400,
//                             ),
//                           ),
//                           value: false,
//                           onChanged: (val) {}),
//                       SwitchListTile(
//                           tileColor: const Color(0XFFF4F4F4),
//                           // activeColor: Colors.lightBlueAccent,
//                           inactiveThumbColor: const Color(0XFFC8DCF7),
//                           inactiveTrackColor: const Color(0XFFA5C6F3),
//                           shape: RoundedRectangleBorder(
//                               borderRadius: BorderRadius.circular(12)),
//                           title: const Text(
//                             "Remove Branding",
//                             textAlign: TextAlign.start,
//                             style: TextStyle(
//                               fontSize: 16,
//                               fontWeight: FontWeight.w400,
//                             ),
//                           ),
//                           subtitle: const Text(
//                             "Remove Pro logo and other branding from your profile",
//                             textAlign: TextAlign.start,
//                             style: TextStyle(
//                               fontSize: 12,
//                               fontWeight: FontWeight.w400,
//                             ),
//                           ),
//                           value: false,
//                           onChanged: (val) {}),
//                     ],
//                   ),
//                 ),
//                 const SizedBox(
//                   height: 10,
//                 ),
//                 SettingSecondListTile(
//                   verticalPadding: 10,
//                   horizontalPadding: 15,
//                   backgroundColor: const Color(0XFFF4F4F4),
//                   title: "Create your Email Signature",
//                   onTap: () {},
//                 ),
//                 BackgroundContainer(
//                   child: Column(
//                     children: const [
//                       ListTile(
//                         title: Text(
//                           "Edit Account Email",
//                           style: TextStyle(
//                             fontSize: 16,
//                             fontWeight: FontWeight.w400,
//                           ),
//                         ),
//                         trailing: SizedBox(
//                           width: 60,
//                           child: Text(
//                             "raisamir660@gmail.com",
//                             overflow: TextOverflow.ellipsis,
//                             style: TextStyle(
//                               fontSize: 12,
//                               fontWeight: FontWeight.w400,
//                             ),
//                           ),
//                         ),
//                       ),
//                       ListTile(
//                         title: Text(
//                           "Edit Profile Link",
//                           style: TextStyle(
//                             fontSize: 16,
//                             fontWeight: FontWeight.w400,
//                           ),
//                         ),
//                         trailing: SizedBox(
//                           width: 60,
//                           child: Text(
//                             "XDHFTh5s",
//                             overflow: TextOverflow.ellipsis,
//                             style: TextStyle(
//                               fontSize: 12,
//                               fontWeight: FontWeight.w400,
//                             ),
//                           ),
//                         ),
//                       ),
//                       ListTile(
//                         title: Text(
//                           "Biz Card Ambassador",
//                           style: TextStyle(
//                             fontSize: 16,
//                             fontWeight: FontWeight.w400,
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//                 Container(
//                   padding: const EdgeInsets.only(
//                       top: 15.0, bottom: kBottomNavigationBarHeight),
//                   // margin: const EdgeInsets.symmetric(horizontal: 0),
//                   width: double.infinity,
//                   child: Column(
//                     children: [
//                       MaterialButton(
//                         onPressed: () async {
//                           AlertMessage.showLoading();
//                           userProvider.signOutGoogle();
//                           AlertMessage.dismissLoading();
//                         },
//                         // textColor: Colors.blue.shade700,
//                         elevation: 0,
//                         hoverElevation: 0,
//                         highlightElevation: 0,
//                         disabledElevation: 0,
//                         enableFeedback: false,
//                         color: const Color(0XFFF4F4F4),
//                         // textTheme: ButtonTextTheme.accent,
//                         minWidth: 100,
//                         padding: const EdgeInsets.symmetric(
//                             horizontal: 20, vertical: 20),
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(12),
//                           // side: BorderSide(color: Colors.blue.shade700),
//                         ),
//                         child: const Align(
//                           alignment: Alignment.centerLeft,
//                           child: Text(
//                             "Sign Out",
//                             textAlign: TextAlign.start,
//                             style: TextStyle(
//                               fontSize: 16,
//                               fontWeight: FontWeight.w400,
//                             ),
//                           ),
//                         ),
//                       ),
//                       Padding(
//                         padding: EdgeInsets.all(8.0),
//                         child: Text.rich(
//                           TextSpan(
//                             children: [
//                               const TextSpan(
//                                 text: 'Version 1.0.0',
//                                 style: TextStyle(
//                                     fontSize: 12, fontWeight: FontWeight.w400),
//                               ),
//                               const TextSpan(
//                                 text: ' - ',
//                                 style: TextStyle(
//                                     fontWeight: FontWeight.normal,
//                                     fontSize: 12),
//                               ),
//                               TextSpan(
//                                 text: ' Terms',
//                                 style: const TextStyle(
//                                     fontSize: 12, fontWeight: FontWeight.bold),
//                                 recognizer: TapGestureRecognizer()
//                                   ..onTap = () {},
//                               ),
//                               TextSpan(
//                                 text: ' & ',
//                                 style: const TextStyle(
//                                     fontSize: 12,
//                                     fontWeight: FontWeight.normal),
//                                 recognizer: TapGestureRecognizer()
//                                   ..onTap = () {},
//                               ),
//                               TextSpan(
//                                 text: 'Privacy',
//                                 style: const TextStyle(
//                                     fontSize: 12, fontWeight: FontWeight.bold),
//                                 recognizer: TapGestureRecognizer()
//                                   ..onTap = () {},
//                               ),
//                             ],
//                           ),
//                         ),
//                       )
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

///
class SettingScreen extends ConsumerWidget {
  const SettingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // first variable is to get the data of Authenticated User
    // final data = ref.watch(fireBaseAuthProvider);

    // log("Data in fireBaseAuthProvider ${data.currentUser}");

    //  Second variable to access the Logout Function
    final auth = ref.watch(authenticationProvider);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        scrolledUnderElevation: 0,
        title: const Text("Biz Card"),
        automaticallyImplyLeading: false,
        leading: Transform.translate(
          offset: const Offset(12, 0),
          child: IconButton(
            onPressed: () {},
            icon: const Icon(FontAwesomeIcons.locationArrow),
          ),
        ),
        actions: [
          Transform.translate(
            offset: const Offset(-10, 0),
            child: Material(
              color: Colors.transparent,
              borderRadius: BorderRadius.circular(10),
              child: InkWell(
                borderRadius: BorderRadius.circular(10),
                onTap: () {},
                child: SizedBox(
                  width: 100,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: const [
                      Text(
                        "Invite",
                        style: TextStyle(
                          fontSize: 16,
                        ),
                      ),
                      Icon(
                        FontAwesomeIcons.gift,
                        size: 18,
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Settings",
                  style: TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                // Text(data.currentUser!.email ?? 'You are logged In'),
                SizedBox(
                  height: 20,
                ),
                BackgroundContainer(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        child: Text(
                          "My Insights",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: SettingListTile(
                          title: "Amir Chachar",
                          textStyle: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                          onTap: () {},
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                BackgroundContainer(
                  child: Column(
                    children: [
                      SettingSecondListTile(
                        title: "Activate a Popl Device",
                        backgroundColor: Colors.transparent,
                        onTap: () {},
                      ),
                      SettingSecondListTile(
                        backgroundColor: Colors.transparent,
                        title: "How to Pop",
                        onTap: () {},
                      ),
                      SettingSecondListTile(
                        backgroundColor: Colors.transparent,
                        title: "Gat a Popl Device(30% off)",
                        onTap: () {},
                      ),
                    ],
                  ),
                ),

                /// go Pro
                Container(
                  padding: const EdgeInsets.only(top: 10.0),
                  // margin: const EdgeInsets.symmetric(horizontal: 0),
                  width: double.infinity,
                  child: MaterialButton(
                    onPressed: () {},
                    // textColor: Colors.blue.shade700,
                    elevation: 0,
                    hoverElevation: 0,
                    highlightElevation: 0,
                    disabledElevation: 0,
                    enableFeedback: false,
                    color: const Color(0XFFF4F4F4),
                    // textTheme: ButtonTextTheme.accent,
                    minWidth: 100,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 20),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                      // side: BorderSide(color: Colors.blue.shade700),
                    ),
                    child: const Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Go Pro",
                        textAlign: TextAlign.start,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                  ),
                ),

                /// free trial popl team
                Container(
                  padding: const EdgeInsets.only(top: 10.0),
                  // margin: const EdgeInsets.symmetric(horizontal: 0),
                  width: double.infinity,
                  child: MaterialButton(
                    onPressed: () {},
                    // textColor: Colors.blue.shade700,
                    elevation: 0,
                    hoverElevation: 0,
                    highlightElevation: 0,
                    disabledElevation: 0,
                    enableFeedback: false,
                    color: const Color(0XFFF4F4F4),
                    // textTheme: ButtonTextTheme.accent,
                    minWidth: 100,
                    padding:
                        const EdgeInsets.symmetric(horizontal: 0, vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                      // side: BorderSide(color: Colors.blue.shade700),
                    ),
                    child: ListTile(
                      title: const Text(
                        "Popl Teams (Free trial)",
                        textAlign: TextAlign.start,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      subtitle: const Text(
                        "Set your team up with digital business cards",
                        textAlign: TextAlign.start,
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      trailing: SizedBox(
                          width: 30,
                          height: 30,
                          child: SvgPicture.asset(
                              "assets/icons/multiple-users.svg")),
                      // Icon(FontAwesomeIcons.users),
                    ),
                  ),
                ),

                /// complete your profile
                Container(
                  padding: const EdgeInsets.only(top: 10.0),
                  // margin: const EdgeInsets.symmetric(horizontal: 0),
                  width: double.infinity,
                  child: MaterialButton(
                    onPressed: () {},
                    // textColor: Colors.blue.shade700,
                    elevation: 0,
                    hoverElevation: 0,
                    highlightElevation: 0,
                    disabledElevation: 0,
                    enableFeedback: false,
                    color: const Color(0XFFF4F4F4),
                    // textTheme: ButtonTextTheme.accent,
                    minWidth: 100,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                      // side: BorderSide(color: Colors.blue.shade700),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Padding(
                          padding: EdgeInsets.symmetric(vertical: 10),
                          child: Text(
                            "Complete Your Profile",
                            textAlign: TextAlign.start,
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(
                              vertical: 6, horizontal: 30),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50),
                            border:
                                Border.all(color: Colors.redAccent, width: 1.5),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 5, horizontal: 2),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: const [
                              Text(
                                "0% complete",
                                textAlign: TextAlign.start,
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              Text(
                                "0/7 tasks done",
                                textAlign: TextAlign.start,
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),

                /// Auto Intro
                BackgroundContainer(
                  child: Column(
                    children: [
                      SwitchListTile(
                          tileColor: const Color(0XFFF4F4F4),
                          // activeColor: Colors.lightBlueAccent,
                          inactiveThumbColor: const Color(0XFFC8DCF7),
                          inactiveTrackColor: const Color(0XFFA5C6F3),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12)),
                          title: const Text(
                            "Auto Intro",
                            textAlign: TextAlign.start,
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          subtitle: const Text(
                            "Send an email intro with you and every new connection upon connecting",
                            textAlign: TextAlign.start,
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          value: false,
                          onChanged: (val) {}),
                      SwitchListTile(
                          tileColor: const Color(0XFFF4F4F4),
                          // activeColor: Colors.lightBlueAccent,
                          inactiveThumbColor: const Color(0XFFC8DCF7),
                          inactiveTrackColor: const Color(0XFFA5C6F3),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12)),
                          title: const Text(
                            "Remove Branding",
                            textAlign: TextAlign.start,
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          subtitle: const Text(
                            "Remove Pro logo and other branding from your profile",
                            textAlign: TextAlign.start,
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          value: false,
                          onChanged: (val) {}),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                SettingSecondListTile(
                  verticalPadding: 10,
                  horizontalPadding: 15,
                  backgroundColor: const Color(0XFFF4F4F4),
                  title: "Create your Email Signature",
                  onTap: () {},
                ),
                BackgroundContainer(
                  child: Column(
                    children: const [
                      ListTile(
                        title: Text(
                          "Edit Account Email",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        trailing: SizedBox(
                          width: 60,
                          child: Text(
                            "raisamir660@gmail.com",
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                      ),
                      ListTile(
                        title: Text(
                          "Edit Profile Link",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        trailing: SizedBox(
                          width: 60,
                          child: Text(
                            "XDHFTh5s",
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                      ),
                      ListTile(
                        title: Text(
                          "Biz Card Ambassador",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.only(
                      top: 15.0, bottom: kBottomNavigationBarHeight),
                  // margin: const EdgeInsets.symmetric(horizontal: 0),
                  width: double.infinity,
                  child: Column(
                    children: [
                      MaterialButton(
                        onPressed: () async {
                          AlertMessage.showLoading();
                          auth.signOutGoogle();
                          AlertMessage.dismissLoading();
                        },
                        // textColor: Colors.blue.shade700,
                        elevation: 0,
                        hoverElevation: 0,
                        highlightElevation: 0,
                        disabledElevation: 0,
                        enableFeedback: false,
                        color: const Color(0XFFF4F4F4),
                        // textTheme: ButtonTextTheme.accent,
                        minWidth: 100,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 20),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                          // side: BorderSide(color: Colors.blue.shade700),
                        ),
                        child: const Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "Sign Out",
                            textAlign: TextAlign.start,
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text.rich(
                          TextSpan(
                            children: [
                              const TextSpan(
                                text: 'Version 1.0.0',
                                style: TextStyle(
                                    fontSize: 12, fontWeight: FontWeight.w400),
                              ),
                              const TextSpan(
                                text: ' - ',
                                style: TextStyle(
                                    fontWeight: FontWeight.normal,
                                    fontSize: 12),
                              ),
                              TextSpan(
                                text: ' Terms',
                                style: const TextStyle(
                                    fontSize: 12, fontWeight: FontWeight.bold),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {},
                              ),
                              TextSpan(
                                text: ' & ',
                                style: const TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.normal),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {},
                              ),
                              TextSpan(
                                text: 'Privacy',
                                style: const TextStyle(
                                    fontSize: 12, fontWeight: FontWeight.bold),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {},
                              ),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
