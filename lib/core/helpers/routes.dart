import 'dart:developer';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../features/bottomNavBar/bottom_nav_bar.dart';
import '../../features/cardTemplate/business_card_screen.dart';
import '../../features/defaultsScreen/error_screen.dart';
import '../../main.dart';

final firebaseInitializerProvider = FutureProvider<FirebaseApp>((ref) async {
  return await Firebase.initializeApp();
});

class AppRoute {
  final GoRouter routes = GoRouter(
    routes: [
      GoRoute(
        name: "home",
        path: "/",
        builder: (context, state) {
          return App();
        },
        redirect: (context, redirect) {
          return redirectPathProvider.name;
        },
        // redirect: (BuildContext context, state) {
        //   final initialize = context.read(firebaseInitializerProvider);
        //   initialize.when(
        //     data: (data) {
        //       return const AuthChecker();
        //     },
        //     error: (e, stackTrace) => Center(
        //       child: Text("Error: $e  StackTrace : $stackTrace"),
        //     ),
        //     loading: () => const CircularProgressIndicator(),
        //   );
        //   return null;
        // }

        ///
        // routes: [
        //   GoRoute(path: "a", builder: (context, state) => const A(), routes: [
        //     GoRoute(path: "b", builder: (context, state) => const B(), routes: [
        //       GoRoute(
        //         path: "c",
        //         builder: (context, state) => const C(),
        //       )
        //     ])
        //   ])
        // ],
      ),
      GoRoute(
          name: "dashboard",
          path: "/dashboard",
          builder: (context, state) {
            return const BottomNavBar();
          }),
      GoRoute(
        name: "cardScreen",
        path: "/cardScreen:userId",
        // path: "/cardScreen",
        builder: (context, state) {
          log("Data : ${state.params}");
          state.queryParams.forEach((key, value) {
            log("Key: $key  Value : $value");
          });
          return BusinessCardTemplate(
            isSocialColorEnabled: true,
            color: Colors.blueAccent,
            // userData: UserDataModel(
            //     displayName: "Amir Nazir",
            //     email: "amirVirtuenetz@gmail.com",
            //     jobTitle: "Flutter developer",
            //     companyName: "Virtuenetz",
            //     address: "Rahim Yar Khan",
            //     bio: "I am flutter developer",
            //     photoUrl:
            //         "https://fastly.picsum.photos/id/1081/200/300.jpg?hmac=ntCnXquH7cpEF0vi5yvz1wKAlRyd2EZwZJQbgtfknu8",
            //     coverUrl:
            //         "https://fastly.picsum.photos/id/1081/200/300.jpg?hmac=ntCnXquH7cpEF0vi5yvz1wKAlRyd2EZwZJQbgtfknu8",
            //     logoUrl:
            //         "https://fastly.picsum.photos/id/1081/200/300.jpg?hmac=ntCnXquH7cpEF0vi5yvz1wKAlRyd2EZwZJQbgtfknu8"),
            // data: state.params["name"],
          );
        },
      ),
    ],
    errorBuilder: (context, state) => const ErrorScreen(),
  );
}

final redirectPathProvider = Provider<String>((ref) {
  final initialize = ref.watch(firebaseInitializerProvider);
  return initialize.maybeWhen(
    data: (_) => "/dashboard",
    orElse: () => "/",
  );
});
