import 'dart:math';

import 'package:biz_card/features/screens/biz_card.dart';
import 'package:flutter/material.dart';

import '../qrCode_scan/qr_image_scan.dart';
import '../setting/screens/setting_screen.dart';
import '../shareQrCode/share_qr_code_screen.dart';

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({Key? key}) : super(key: key);

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  int index = 0;
  // Map<int, GlobalKey<NavigatorState>> navigatorKeys = {
  //   0: GlobalKey<NavigatorState>(),
  //   1: GlobalKey<NavigatorState>(),
  //   2: GlobalKey<NavigatorState>(),
  //   3: GlobalKey<NavigatorState>(),
  // };

  List list = [
    const BizCardMain(),
    Container(
      alignment: Alignment.center,
      child: const Text("Contacts"),
    ),
    // const QRCodeScannerScreen(),
    // Container(
    //   alignment: Alignment.center,
    //   child: const Text("Scan"),
    // ),
    const BarcodeScannerWithController(),
    // Container(
    //   alignment: Alignment.center,
    //   child: const Text("Setting"),
    // ),
    const SettingScreen(),
  ];
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
          print("index: $i");
          setState(() {
            index = i;
          });
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
            ),
          ),
        ),
      ),
    );
  }

  // buildNavigator() {
  //   return Navigator(
  //     key: navigatorKeys[index],
  //     onGenerateRoute: (RouteSettings settings) {
  //       return MaterialPageRoute(
  //         builder: (_) => list.elementAt(index),
  //       );
  //     },
  //   );
  // }
}

class FABBottomAppBarItem {
  FABBottomAppBarItem({required this.iconData, required this.text});
  IconData iconData;
  String text;
}

class FABBottomAppBar extends StatefulWidget {
  FABBottomAppBar({
    super.key,
    required this.items,
    required this.centerItemText,
    this.height = 60.0,
    this.iconSize = 24.0,
    required this.backgroundColor,
    required this.color,
    required this.selectedColor,
    required this.notchedShape,
    required this.onTabSelected,
  }) {
    assert(items.length == 2 || items.length == 4);
  }
  final List<FABBottomAppBarItem> items;
  final String centerItemText;
  final double height;
  final double iconSize;
  final Color backgroundColor;
  final Color color;
  final Color selectedColor;
  final NotchedShape notchedShape;
  final ValueChanged<int> onTabSelected;

  @override
  State<StatefulWidget> createState() => FABBottomAppBarState();
}

class FABBottomAppBarState extends State<FABBottomAppBar> {
  int _selectedIndex = 0;

  _updateIndex(int index) {
    widget.onTabSelected(index);
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> items = List.generate(widget.items.length, (int index) {
      return _buildTabItem(
        item: widget.items[index],
        index: index,
        onPressed: _updateIndex,
      );
    });
    items.insert(items.length >> 1, _buildMiddleTabItem());

    return BottomAppBar(
      shape: widget.notchedShape,
      color: widget.backgroundColor,
      notchMargin: 0,
      clipBehavior: Clip.antiAlias,
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: items,
      ),
    );
  }

  Widget _buildMiddleTabItem() {
    return Expanded(
      child: SizedBox(
        height: widget.height,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(height: widget.iconSize + 5),
            Text(
              widget.centerItemText ?? '',
              style: TextStyle(color: widget.color),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTabItem({
    required FABBottomAppBarItem item,
    required int index,
    required ValueChanged<int> onPressed,
  }) {
    Color color = _selectedIndex == index ? widget.selectedColor : widget.color;
    return Expanded(
      child: SizedBox(
        height: widget.height,
        child: Material(
          type: MaterialType.transparency,
          child: InkWell(
            onTap: () => onPressed(index),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Icon(item.iconData, color: color, size: widget.iconSize + 5),
                Text(
                  item.text,
                  style: TextStyle(color: color),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class CircularOuterNotchedRectangle extends NotchedShape {
  const CircularOuterNotchedRectangle({this.extraOffset = 10.0});

  final double extraOffset;
  @override
  Path getOuterPath(Rect host, Rect? guest) {
    if (guest == null || !host.overlaps(guest)) return Path()..addRect(host);

    final double notchRadius = guest.width / 2.0;

    const double s1 = 15.0;
    const double s2 = 1.0;

    final double r = notchRadius + extraOffset / 2;
    final double a = -1.0 * r - s2;
    final double b = host.top + guest.center.dy;

    final double n2 = sqrt(b * b * r * r * (a * a + b * b - r * r));
    final double p2xA = ((a * r * r) - n2) / (a * a + b * b);
    final double p2xB = ((a * r * r) + n2) / (a * a + b * b);
    final double p2yA = sqrt(r * r - p2xA * p2xA) - extraOffset / 2;
    final double p2yB = sqrt(r * r - p2xB * p2xB) - extraOffset / 2;

    final List<Offset> p = List.filled(6, const Offset(0, 0));

    // p0, p1, and p2 are the control points for segment A.
    p[0] = Offset(a - s1, b);
    p[1] = Offset(a, b);
    p[2] = p2yA > p2yB ? Offset(p2xA, -p2yA) : Offset(p2xB, p2yB);

    // p3, p4, and p5 are the control points for segment B, which is a mirror
    // of segment A around the y axis.
    p[3] = Offset(-1.0 * p[2].dx, -p[2].dy);
    p[4] = Offset(-1.0 * p[1].dx, p[1].dy);
    p[5] = Offset(-1.0 * p[0].dx, p[0].dy);

    // translate all points back to the absolute coordinate system.
    for (int i = 0; i < p.length; i += 1) {
      p[i] += guest.center;
    }

    return Path()
      ..moveTo(host.left, -host.top)
      ..lineTo(p[0].dx, p[0].dy)
      ..quadraticBezierTo(p[1].dx, p[1].dy, p[2].dx, -p[2].dy)
      ..arcToPoint(
        p[3],
        radius: Radius.circular(notchRadius),
        clockwise: true,
      )
      ..quadraticBezierTo(p[4].dx, p[4].dy, p[5].dx, p[5].dy)
      ..lineTo(host.right, host.top)
      ..lineTo(host.right, host.bottom)
      ..lineTo(host.left, host.bottom)
      ..close();
  }
}
