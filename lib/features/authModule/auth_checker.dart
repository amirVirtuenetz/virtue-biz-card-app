import 'package:biz_card/features/authModule/screens/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../bottomNavBar/bottom_nav_bar.dart';
import '../providers/auth_provider.dart';

class AuthChecker extends ConsumerWidget {
  const AuthChecker({Key? key}) : super(key: key);

  //  Notice here we aren't using stateless/statefull widget. Instead we are using
  //  a custom widget that is a consumer of the state.
  //  So if any data changes in the state, the widget will be updated.

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    //  now the following variable contains an asyncValue so now we can use .when method
    //  to imply the condition
    final authState = ref.watch(authStateProvider);
    return authState.when(
      data: (data) {
        if (data != null) return const BottomNavBar();
        return const LoginScreen();
      },
      loading: () => const Center(
        child: CircularProgressIndicator(),
      ),
      error: (e, trace) => Center(
        child: Text("$e   $trace"),
      ),
    );
  }
}
