import 'package:biz_card/features/bottomNavBar/widgets/fab_bottom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../shareQrCode/share_qr_code_screen.dart';
import 'bottom_bar_list.dart';
import 'model/fab_model.dart';

final selectedIndexProvider = StateProvider<int>((ref) => 0);

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({Key? key}) : super(key: key);

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  int index = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      // body: PersistentTabView(
      //   context,
      //   screens: buildScreens(),
      //   items: navBarItems(),
      //   navBarStyle: NavBarStyle.style19,
      //   // handleAndroidBackButtonPress: false,
      //   bottomScreenMargin: 0,
      //   resizeToAvoidBottomInset: false,
      //   hideNavigationBarWhenKeyboardShows: true,
      //   navBarHeight: MediaQuery.of(context).viewInsets.bottom > 0
      //       ? 0.0
      //       : kBottomNavigationBarHeight,
      //   hideNavigationBar:
      //       MediaQuery.of(context).viewInsets.bottom > 0 ? true : false,
      //   confineInSafeArea: false,
      //   popAllScreensOnTapOfSelectedTab: true,
      //   screenTransitionAnimation: const ScreenTransitionAnimation(
      //     animateTabTransition: true,
      //   ),
      //   itemAnimationProperties: const ItemAnimationProperties(
      //       duration: Duration(milliseconds: 200), curve: Curves.ease),
      //   // padding: NavBarPadding.only(left: 30.w, right: 30.w),
      //   backgroundColor: Colors.white,
      //   // decoration: NavBarDecoration(
      //   //   colorBehindNavBar: Colors.transparent,
      //   //   borderRadius: const BorderRadius.all(
      //   //     Radius.circular(0),
      //   //   ),
      //   //   boxShadow: [
      //   //     MediaQuery.of(context).viewInsets.bottom > 0.0
      //   //         ? const BoxShadow(
      //   //             color: Colors.white, spreadRadius: 0, blurRadius: 0)
      //   //         : const BoxShadow(
      //   //             color: Colors.black38,
      //   //             spreadRadius: -7,
      //   //             blurRadius: 10,
      //   //           ),
      //   //   ],
      //   // ),
      // ),
      bottomNavigationBar: FABBottomAppBar(
        centerItemText: 'Share',
        color: Colors.grey,
        height: kBottomNavigationBarHeight + 20,
        backgroundColor: Colors.white,
        selectedColor: Colors.black,
        notchedShape: const CircularNotchedRectangle(),
        onTabSelected: (i) {
          debugPrint("index here: $i");
          index = i;
          setState(() {});
        },
        items: [
          FABBottomAppBarItem(iconData: Icons.person_outline, text: 'Profile'),
          FABBottomAppBarItem(
              iconData: Icons.contact_phone_outlined, text: 'Contacts'),
          FABBottomAppBarItem(
              iconData: Icons.qr_code_scanner_outlined, text: 'Scan'),
          FABBottomAppBarItem(
              iconData: Icons.settings_outlined, text: 'Setting'),
        ],
      ),
      body: list[index],
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: SizedBox(
        height: 70.0,
        width: 70.0,
        child: FittedBox(
          child: FloatingActionButton(
            backgroundColor: Colors.blueAccent,
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const ShareQRCodeScreen(),
                ),
              );
            },
            elevation: 0.0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(100),
            ),
            child: const Icon(
              Icons.qr_code_2_outlined,
              size: 30,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
