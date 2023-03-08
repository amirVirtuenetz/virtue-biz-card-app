import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../model/link_store_module.dart';
import '../model/user_module.dart';

final userProvider = Provider<UserModule>((ref) {
  return UserModule();
});

final userStateProvider = StreamProvider<User?>((ref) {
  return ref.read(userProvider).authStateChange;
});

/// linkStore provider

final linkStoreProvider = Provider<LinkStoreModuleClass>((ref) {
  return LinkStoreModuleClass();
});
