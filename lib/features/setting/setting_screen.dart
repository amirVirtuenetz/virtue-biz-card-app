import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../providers/auth_provider.dart';

class SettingScreen extends ConsumerWidget {
  const SettingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // first variable is to get the data of Authenticated User
    final data = ref.watch(fireBaseAuthProvider);

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
            offset: Offset(-10, 0),
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
                    children: [
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
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Settings",
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.w700,
                ),
              ),
              Text(data.currentUser!.email ?? 'You are logged In'),
              Text(data.currentUser!.displayName ??
                  ' Great you have Completed this step'),
              Container(
                padding: const EdgeInsets.only(top: 48.0),
                // margin: const EdgeInsets.symmetric(horizontal: 0),
                width: double.infinity,
                child: MaterialButton(
                  onPressed: () => auth.signOut(),
                  textColor: Colors.blue.shade700,
                  textTheme: ButtonTextTheme.primary,
                  minWidth: 100,
                  padding: const EdgeInsets.all(18),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25),
                    side: BorderSide(color: Colors.blue.shade700),
                  ),
                  child: const Text(
                    'Log Out',
                    style: TextStyle(fontWeight: FontWeight.w600),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
