import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:url_strategy/url_strategy.dart';

import 'features/authModule/auth_checker.dart';

//  This is a FutureProvider that will be used to check whether the firebase has been initialized or not
final firebaseInitializerProvider = FutureProvider<FirebaseApp>((ref) async {
  return await Firebase.initializeApp();
});

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // DartPluginRegistrant.ensureInitialized();
  if (kIsWeb) {
    FirebaseOptions firebaseConfigOption = const FirebaseOptions(
        apiKey: "AIzaSyB8MkOYYWojiPMtiCdDE_WvjDmSq-V5LZU",
        authDomain: "biz-card-9fa8a.firebaseapp.com",
        databaseURL: "https://biz-card-9fa8a-default-rtdb.firebaseio.com",
        projectId: "biz-card-9fa8a",
        storageBucket: "biz-card-9fa8a.appspot.com",
        messagingSenderId: "775724473313",
        appId: "1:775724473313:web:06bf231da62d01624a10a0",
        measurementId: "G-ES75MS06GK");
    await Firebase.initializeApp(options: firebaseConfigOption);
  } else {
    await Firebase.initializeApp();
    FirebaseDatabase.instance.setPersistenceEnabled(true);
  }
  FirebaseFirestore.instance.settings = const Settings(
      persistenceEnabled: true, cacheSizeBytes: Settings.CACHE_SIZE_UNLIMITED);
  configLoading();
  setPathUrlStrategy();
  runApp(
    ProviderScope(
      child: App(),
    ),
  );
}

class App extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final initialize = ref.watch(firebaseInitializerProvider);
    return MaterialApp(
      title: 'Flutter Biz Card App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: initialize.when(
        data: (data) {
          return const AuthChecker();
        },
        error: (e, stackTrace) => Center(
          child: Text("Error: $e  StackTrace : $stackTrace"),
        ),
        loading: () => const CircularProgressIndicator(),
      ),
      builder: EasyLoading.init(),
    );
  }
}

void configLoading() {
  EasyLoading.instance
    ..displayDuration = const Duration(milliseconds: 2000)
    ..indicatorType = EasyLoadingIndicatorType.fadingCircle
    ..loadingStyle = EasyLoadingStyle.dark
    ..indicatorSize = 45.0
    ..radius = 10.0
    ..progressColor = Colors.blueAccent
    ..backgroundColor = Colors.black
    ..indicatorColor = Colors.green
    ..textColor = Colors.white
    ..maskColor = Colors.blue.withOpacity(0.5)
    ..userInteractions = false;
  // ..dismissOnTap = false;
}
// class MyApp extends StatelessWidget {
//   const MyApp({super.key});
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Flutter Biz Card',
//       debugShowCheckedModeBanner: false,
//       theme: ThemeData(
//         useMaterial3: true,
//         // is not restarted.
//         primarySwatch: Colors.blue,
//       ),
//       home: const LoginScreen(),
//     );
//   }
// }
