import "package:flutter/material.dart";
import "package:flutter_svg/svg.dart";
import "package:persistent_bottom_nav_bar/persistent_tab_view.dart";

BuildContext? testContext;

class MainMenu extends StatefulWidget {
  const MainMenu({Key? key}) : super(key: key);

  @override
  _MainMenuState createState() => _MainMenuState();
}

class _MainMenuState extends State<MainMenu> {
  @override
  Widget build(final BuildContext context) => Scaffold(
        appBar: AppBar(
          title: const Text("Sample Project"),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Center(
              child: ElevatedButton(
                child: const Text("Custom widget example"),
                onPressed: () => PersistentNavBarNavigator.pushNewScreen(
                  context,
                  screen: CustomWidgetExample(
                    menuScreenContext: context,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Center(
              child: ElevatedButton(
                child: const Text("Built-in styles example"),
                onPressed: () => PersistentNavBarNavigator.pushNewScreen(
                  context,
                  screen: ProvidedStylesExample(
                    menuScreenContext: context,
                  ),
                ),
              ),
            ),
          ],
        ),
      );
}

// ----------------------------------------- Provided Style ----------------------------------------- //

class ProvidedStylesExample extends StatefulWidget {
  const ProvidedStylesExample({Key? key, required this.menuScreenContext})
      : super(key: key);
  final BuildContext menuScreenContext;

  @override
  _ProvidedStylesExampleState createState() => _ProvidedStylesExampleState();
}

class _ProvidedStylesExampleState extends State<ProvidedStylesExample> {
  PersistentTabController? _controller;
  bool _hideNavBar = false;

  @override
  void initState() {
    super.initState();
    _controller = PersistentTabController();
    _hideNavBar = false;
  }

  List<Widget> _buildScreens() => [
        MainScreen(
          menuScreenContext: widget.menuScreenContext,
          hideStatus: _hideNavBar,
          onScreenHideButtonPressed: () {
            setState(() {
              _hideNavBar = !_hideNavBar;
            });
          },
        ),
        MainScreen(
          menuScreenContext: widget.menuScreenContext,
          hideStatus: _hideNavBar,
          onScreenHideButtonPressed: () {
            setState(() {
              _hideNavBar = !_hideNavBar;
            });
          },
        ),
        MainScreen(
          menuScreenContext: widget.menuScreenContext,
          hideStatus: _hideNavBar,
          onScreenHideButtonPressed: () {
            setState(() {
              _hideNavBar = !_hideNavBar;
            });
          },
        ),
        MainScreen(
          menuScreenContext: widget.menuScreenContext,
          hideStatus: _hideNavBar,
          onScreenHideButtonPressed: () {
            setState(() {
              _hideNavBar = !_hideNavBar;
            });
          },
        ),
        MainScreen(
          menuScreenContext: widget.menuScreenContext,
          hideStatus: _hideNavBar,
          onScreenHideButtonPressed: () {
            setState(() {
              _hideNavBar = !_hideNavBar;
            });
          },
        ),
      ];

  List<PersistentBottomNavBarItem> _navBarsItems() => [
        PersistentBottomNavBarItem(
            icon: const Icon(Icons.home),
            title: "Home",
            activeColorPrimary: Colors.blue,
            inactiveColorPrimary: Colors.grey,
            inactiveColorSecondary: Colors.purple),
        PersistentBottomNavBarItem(
          icon: const Icon(Icons.search),
          title: "Search",
          activeColorPrimary: Colors.teal,
          inactiveColorPrimary: Colors.grey,
          routeAndNavigatorSettings: RouteAndNavigatorSettings(
            initialRoute: "/",
            routes: {
              "/first": (final context) => const MainScreen2(),
              "/second": (final context) => const MainScreen3(),
            },
          ),
        ),
        PersistentBottomNavBarItem(
          icon: const Icon(
            Icons.add,
            color: Colors.yellow,
          ),
          title: "Add",
          activeColorPrimary: Colors.blueAccent,
          inactiveColorPrimary: Colors.grey,
          // routeAndNavigatorSettings: RouteAndNavigatorSettings(
          //   initialRoute: "/",
          //   routes: {
          //     "/first": (final context) => const MainScreen2(),
          //     "/second": (final context) => const MainScreen3(),
          //   },
          // ),
        ),
        PersistentBottomNavBarItem(
          icon: const Icon(Icons.message),
          title: "Messages",
          activeColorPrimary: Colors.deepOrange,
          inactiveColorPrimary: Colors.grey,
          routeAndNavigatorSettings: RouteAndNavigatorSettings(
            initialRoute: "/",
            routes: {
              "/first": (final context) => const MainScreen2(),
              "/second": (final context) => const MainScreen3(),
            },
          ),
        ),
        PersistentBottomNavBarItem(
          icon: const Icon(Icons.settings),
          title: "Settings",
          activeColorPrimary: Colors.indigo,
          inactiveColorPrimary: Colors.grey,
          routeAndNavigatorSettings: RouteAndNavigatorSettings(
            initialRoute: "/",
            routes: {
              "/first": (final context) => const MainScreen2(),
              "/second": (final context) => const MainScreen3(),
            },
          ),
        ),
      ];

  @override
  Widget build(final BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Navigation Bar Demo")),
      drawer: const Drawer(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("This is the Drawer"),
            ],
          ),
        ),
      ),
      body: PersistentTabView(
        context,
        // controller: _controller,
        screens: _buildScreens(),
        items: _navBarsItems(),
        bottomScreenMargin: 0,
        resizeToAvoidBottomInset: true,
        confineInSafeArea: true,
        navBarHeight: MediaQuery.of(context).viewInsets.bottom > 0
            ? 0.0
            : kBottomNavigationBarHeight,
        selectedTabScreenContext: (final context) {
          testContext = context;
        },
        backgroundColor: Colors.black,
        hideNavigationBarWhenKeyboardShows: true,
        hideNavigationBar: _hideNavBar,
        decoration: const NavBarDecoration(colorBehindNavBar: Colors.indigo),
        itemAnimationProperties: const ItemAnimationProperties(
          duration: Duration(milliseconds: 400),
          curve: Curves.ease,
        ),
        screenTransitionAnimation: const ScreenTransitionAnimation(
          animateTabTransition: true,
        ),
        navBarStyle:
            NavBarStyle.style15, // Choose the nav bar style with this property
      ),
    );
  }
}

// ----------------------------------------- Custom Style ----------------------------------------- //

class CustomNavBarWidget extends StatelessWidget {
  const CustomNavBarWidget(
    this.items, {
    Key? key,
    required this.selectedIndex,
    required this.onItemSelected,
  }) : super(key: key);
  final int selectedIndex;
  final List<PersistentBottomNavBarItem> items;
  final ValueChanged<int> onItemSelected;

  Widget _buildItem(
          final PersistentBottomNavBarItem item, final bool isSelected) =>
      Container(
        alignment: Alignment.center,
        height: kBottomNavigationBarHeight,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Flexible(
              child: IconTheme(
                data: IconThemeData(
                    size: 26,
                    color: isSelected
                        ? (item.activeColorSecondary ?? item.activeColorPrimary)
                        : item.inactiveColorPrimary ?? item.activeColorPrimary),
                child: isSelected ? item.icon : item.inactiveIcon ?? item.icon,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 5),
              child: Material(
                type: MaterialType.transparency,
                child: FittedBox(
                  child: Text(
                    "${item.title}",
                    style: TextStyle(
                        color: isSelected
                            ? (item.activeColorSecondary ??
                                item.activeColorPrimary)
                            : item.inactiveColorPrimary,
                        fontWeight: FontWeight.w400,
                        fontSize: 12),
                  ),
                ),
              ),
            )
          ],
        ),
      );

  @override
  Widget build(final BuildContext context) => Container(
        color: Colors.white,
        child: SizedBox(
          width: double.infinity,
          height: kBottomNavigationBarHeight,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: items.map((final item) {
              final int index = items.indexOf(item);
              return Flexible(
                child: GestureDetector(
                  onTap: () {
                    onItemSelected(index);
                  },
                  child: _buildItem(item, selectedIndex == index),
                ),
              );
            }).toList(),
          ),
        ),
      );
}

class MainScreen extends StatelessWidget {
  const MainScreen(
      {Key? key,
      required this.menuScreenContext,
      required this.onScreenHideButtonPressed,
      this.hideStatus = false})
      : super(key: key);
  final BuildContext menuScreenContext;
  final VoidCallback onScreenHideButtonPressed;
  final bool hideStatus;

  @override
  Widget build(final BuildContext context) => SingleChildScrollView(
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Scaffold(
            backgroundColor: Colors.indigo,
            body: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 30, vertical: 20),
                  child: TextField(
                    decoration: InputDecoration(hintText: "Test Text Field"),
                  ),
                ),
                Center(
                  child: ElevatedButton(
                    onPressed: () {
                      PersistentNavBarNavigator.pushNewScreenWithRouteSettings(
                        context,
                        settings: const RouteSettings(name: "/home"),
                        screen: const MainScreen2(),
                        pageTransitionAnimation:
                            PageTransitionAnimation.scaleRotate,
                      );
                    },
                    child: const Text(
                      "Go to Second Screen ->",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
                Center(
                  child: ElevatedButton(
                    onPressed: () {
                      showModalBottomSheet(
                        context: context,
                        backgroundColor: Colors.white,
                        useRootNavigator: true,
                        builder: (final context) => Center(
                          child: ElevatedButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: const Text(
                              "Exit",
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                      );
                    },
                    child: const Text(
                      "Push bottom sheet on TOP of Nav Bar",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
                Center(
                  child: ElevatedButton(
                    onPressed: () {
                      showModalBottomSheet(
                        context: context,
                        backgroundColor: Colors.white,
                        useRootNavigator: false,
                        builder: (final context) => Center(
                          child: ElevatedButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: const Text(
                              "Exit",
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                      );
                    },
                    child: const Text(
                      "Push bottom sheet BEHIND the Nav Bar",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
                Center(
                  child: ElevatedButton(
                    onPressed: () {
                      PersistentNavBarNavigator.pushDynamicScreen(context,
                          screen: SampleModalScreen(), withNavBar: true);
                    },
                    child: const Text(
                      "Push Dynamic/Modal Screen",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
                Center(
                  child: ElevatedButton(
                    onPressed: onScreenHideButtonPressed,
                    child: Text(
                      hideStatus
                          ? "Unhide Navigation Bar"
                          : "Hide Navigation Bar",
                      style: const TextStyle(color: Colors.white),
                    ),
                  ),
                ),
                Center(
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.of(menuScreenContext).pop();
                    },
                    child: const Text(
                      "<- Main Menu",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 60,
                ),
              ],
            ),
          ),
        ),
      );
}

class MainScreen2 extends StatelessWidget {
  const MainScreen2({Key? key}) : super(key: key);

  @override
  Widget build(final BuildContext context) => Scaffold(
        backgroundColor: Colors.teal,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              ElevatedButton(
                onPressed: () {
                  PersistentNavBarNavigator.pushNewScreen(context,
                      screen: const MainScreen3());
                },
                child: const Text(
                  "Go to Third Screen",
                  style: TextStyle(color: Colors.white),
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text(
                  "Go Back to First Screen",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      );
}

class MainScreen3 extends StatelessWidget {
  const MainScreen3({Key? key}) : super(key: key);

  @override
  Widget build(final BuildContext context) => Scaffold(
        backgroundColor: Colors.deepOrangeAccent,
        body: Center(
          child: ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text(
              "Go Back to Second Screen",
              style: TextStyle(color: Colors.white),
            ),
          ),
        ),
      );
}

class CustomWidgetExample extends StatefulWidget {
  const CustomWidgetExample({Key? key, required this.menuScreenContext})
      : super(key: key);
  final BuildContext menuScreenContext;

  @override
  _CustomWidgetExampleState createState() => _CustomWidgetExampleState();
}

class _CustomWidgetExampleState extends State<CustomWidgetExample> {
  PersistentTabController? _controller;
  bool _hideNavBar = false;

  @override
  void initState() {
    super.initState();
    _controller = PersistentTabController();
    _hideNavBar = false;
  }

  List<Widget> _buildScreens() => [
        MainScreen(
          menuScreenContext: widget.menuScreenContext,
          hideStatus: _hideNavBar,
          onScreenHideButtonPressed: () {
            setState(() {
              _hideNavBar = !_hideNavBar;
            });
          },
        ),
        MainScreen(
          menuScreenContext: widget.menuScreenContext,
          hideStatus: _hideNavBar,
          onScreenHideButtonPressed: () {
            setState(() {
              _hideNavBar = !_hideNavBar;
            });
          },
        ),
        MainScreen(
          menuScreenContext: widget.menuScreenContext,
          hideStatus: _hideNavBar,
          onScreenHideButtonPressed: () {
            setState(() {
              _hideNavBar = !_hideNavBar;
            });
          },
        ),
        MainScreen(
          menuScreenContext: widget.menuScreenContext,
          hideStatus: _hideNavBar,
          onScreenHideButtonPressed: () {
            setState(() {
              _hideNavBar = !_hideNavBar;
            });
          },
        ),
        MainScreen(
          menuScreenContext: widget.menuScreenContext,
          hideStatus: _hideNavBar,
          onScreenHideButtonPressed: () {
            setState(() {
              _hideNavBar = !_hideNavBar;
            });
          },
        ),
      ];

  List<PersistentBottomNavBarItem> _navBarsItems() => [
        PersistentBottomNavBarItem(
          icon: const Icon(Icons.home),
          title: "Home",
          activeColorPrimary: Colors.blue,
          inactiveColorPrimary: Colors.grey,
        ),
        PersistentBottomNavBarItem(
          icon: const Icon(Icons.search),
          title: "Search",
          activeColorPrimary: Colors.teal,
          inactiveColorPrimary: Colors.grey,
        ),
        PersistentBottomNavBarItem(
          icon: const Icon(Icons.add),
          title: "Add",
          activeColorPrimary: Colors.deepOrange,
          inactiveColorPrimary: Colors.grey,
        ),
        PersistentBottomNavBarItem(
          icon: const Icon(Icons.settings),
          title: "Settings",
          activeColorPrimary: Colors.indigo,
          inactiveColorPrimary: Colors.grey,
        ),
        PersistentBottomNavBarItem(
          icon: const Icon(Icons.settings),
          title: "Settings",
          activeColorPrimary: Colors.indigo,
          inactiveColorPrimary: Colors.grey,
        ),
      ];

  @override
  Widget build(final BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Navigation Bar Demo custom")),
      drawer: Drawer(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const <Widget>[
              Text("This is the Drawer"),
            ],
          ),
        ),
      ),
      body: PersistentTabView.custom(
        context,
        controller: _controller,
        screens: _buildScreens(),
        resizeToAvoidBottomInset: true,
        itemCount: 5,
        hideNavigationBar: _hideNavBar,
        hideNavigationBarWhenKeyboardShows: true,
        selectedTabScreenContext: (final context) {
          testContext = context;
        },
        onWillPop: (BuildContext? ctx) async {
          await showDialog(
            context: ctx!,
            useSafeArea: true,
            builder: (final context) => Container(
              height: 50,
              width: 50,
              color: Colors.white,
              child: ElevatedButton(
                child: const Text("Close"),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ),
          );
          return false;
        },
        screenTransitionAnimation: const ScreenTransitionAnimation(
          animateTabTransition: true,
        ),
        customWidget: CustomNavBarWidget(
          _navBarsItems(),
          onItemSelected: (final index) {
            setState(() {
              _controller?.index = index; // THIS IS CRITICAL!! Don't miss it!
            });
          },
          selectedIndex: _controller!.index,
        ),
      ),
    );
  }
}

class SampleModalScreen extends ModalRoute<void> {
  SampleModalScreen();

  @override
  Duration get transitionDuration => const Duration(milliseconds: 500);

  @override
  bool get opaque => false;

  @override
  bool get barrierDismissible => false;

  @override
  Color get barrierColor => Colors.black.withOpacity(0.5);

  @override
  String? get barrierLabel => null;

  @override
  bool get maintainState => true;

  @override
  Widget buildPage(
    final BuildContext context,
    final Animation<double> animation,
    final Animation<double> secondaryAnimation,
    // This makes sure that text and other content follows the material style
  ) =>
      Material(
        type: MaterialType.transparency,
        // make sure that the overlay content is not cut off
        child: SafeArea(
          child: _buildOverlayContent(context),
        ),
      );

  Widget _buildOverlayContent(final BuildContext context) => Container(
        height: MediaQuery.of(context).size.height * 0.3,
        width: MediaQuery.of(context).size.width * 0.3,
        margin: const EdgeInsets.all(30),
        padding: const EdgeInsets.symmetric(horizontal: 30),
        color: Colors.amber,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              "This is a modal screen",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.black,
                fontSize: 26,
              ),
            ),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text(
                  "Return",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      );
}

class CustomBottomNavigationBar extends StatelessWidget {
  const CustomBottomNavigationBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      body: PersistentTabView(
        context,
        screens: buildScreens(),
        items: navBarItems(),
        navBarStyle: NavBarStyle.style15,
        // handleAndroidBackButtonPress: false,
        bottomScreenMargin: 0,
        resizeToAvoidBottomInset: false,
        hideNavigationBarWhenKeyboardShows: true,
        navBarHeight: MediaQuery.of(context).viewInsets.bottom > 0
            ? 0.0
            : kBottomNavigationBarHeight,
        hideNavigationBar:
            MediaQuery.of(context).viewInsets.bottom > 0 ? true : false,
        confineInSafeArea: false,
        popAllScreensOnTapOfSelectedTab: true,
        screenTransitionAnimation: const ScreenTransitionAnimation(
          animateTabTransition: true,
        ),
        itemAnimationProperties: const ItemAnimationProperties(
            duration: Duration(milliseconds: 200), curve: Curves.ease),
        // padding: NavBarPadding.only(left: 30.w, right: 30.w),
        backgroundColor: Colors.white,

        // decoration: NavBarDecoration(
        //   colorBehindNavBar: Colors.transparent,
        //   borderRadius: const BorderRadius.all(
        //     Radius.circular(0),
        //   ),
        //   boxShadow: [
        //     MediaQuery.of(context).viewInsets.bottom > 0.0
        //         ? const BoxShadow(
        //             color: Colors.white, spreadRadius: 0, blurRadius: 0)
        //         : const BoxShadow(
        //             color: Colors.black38,
        //             spreadRadius: -7,
        //             blurRadius: 10,
        //           ),
        //   ],
        // ),
      ),
    );
  }
}

List<Widget> buildScreens() {
  return [
    Container(
      child: Text("Home"),
    ),
    Container(
      child: Text("Contact"),
    ),
    Container(
      child: Text("Scan"),
    ),
    Container(
      child: Text("Setting"),
    ),
  ];
}

String homeIcon = "assets/icons/home.svg";
String contactIcon = "assets/icons/library.svg";
String scannerIcon = "assets/icons/code.svg";
String settingIcon = "assets/icons/multiple-users.svg";

List<PersistentBottomNavBarItem> navBarItems() {
  return [
    buildPersistentBottomNavBarItem(homeIcon),
    buildPersistentBottomNavBarItem(contactIcon),
    buildPersistentBottomNavBarItem(scannerIcon),
    buildPersistentBottomNavBarItem(settingIcon),
  ];
}

PersistentBottomNavBarItem buildPersistentBottomNavBarItem(String iconName) {
  return PersistentBottomNavBarItem(
      icon: CustomImageIcon(
        icon: iconName,
        color: Colors.black,
      ),
      inactiveIcon: CustomImageIcon(
        icon: iconName,
        // color: AppColors.inActiveBottomBarIconColor,
      ),
      activeColorPrimary: Colors.transparent);
}

class CustomImageIcon extends StatelessWidget {
  final String icon;
  final BoxFit? fit;
  final double? width, height;
  final Color? color;
  const CustomImageIcon(
      {Key? key,
      required this.icon,
      this.fit,
      this.width,
      this.height,
      this.color = const Color.fromRGBO(143, 155, 179, 1)})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: icon.contains('svg')
          ? SvgPicture.asset(
              icon,
              fit: fit ?? BoxFit.cover,
              width: 30,
              height: 30,
              color: color,
            )
          : Image.asset(
              icon,
              fit: fit ?? BoxFit.contain,
              gaplessPlayback: true,
              filterQuality: FilterQuality.high,
              width: 30,
              height: 30,
              color: color,
            ),
    );
  }
}
