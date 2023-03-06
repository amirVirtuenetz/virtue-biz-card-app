import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';

import '../../core/helpers/key_constant.dart';

class FirebaseServices {
  static final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final DatabaseReference databaseReference = FirebaseDatabase.instance.ref();
  final CollectionReference collection =
      _firestore.collection('userCollection');
  final User? firebaseAuth = FirebaseAuth.instance.currentUser;

  // storeUserData(
  //     {required String userName,
  //     required String collectionName,
  //     var documentId}) async {
  //   CollectionReference collectionReference =
  //       _firestore.collection(collectionName);
  //   DocumentReference reference = collectionReference.doc(documentId);
  //   UserModel userModel = UserModel(
  //       uid: firebaseAuth?.uid,
  //       name: firebaseAuth?.displayName,
  //       presence: true,
  //       lastSeenInEpoch: DateTime.now().millisecondsSinceEpoch);
  //
  //   var data = userModel.toJson();
  //
  //   await reference.set(data).whenComplete(() {
  //     log("user data add");
  //   }).catchError((e) {
  //     log("Firebase error $e");
  //   });
  // }

  // static getUserData() async {
  //   final CollectionReference collectionReference =
  //       _firestore.collection('userCollection');
  //   Stream<QuerySnapshot> snapshot = collectionReference
  //       .orderBy('lastSeenInEpoch', descending: true)
  //       .snapshots();
  //
  //   return snapshot;
  // }

  // 2
  Stream<QuerySnapshot> getStream() {
    return collection.snapshots();
  }

  updateUserPresence() async {
    Map<String, dynamic> presenceUserData = {
      'presence': true,
      'lastSeenInEpoch': DateTime.now().millisecondsSinceEpoch
    };

    await databaseReference
        .child(firebaseAuth!.uid)
        .update(presenceUserData)
        .whenComplete(() {
      log("your presence");
    }).catchError((e) {
      log("Error while update presence $e");
    });
    Map<String, dynamic> presenceStatusFalse = {
      'presence': false,
      'lastSeenInEpoch': DateTime.now().millisecondsSinceEpoch
    };

    databaseReference
        .child(firebaseAuth!.uid)
        .onDisconnect()
        .update(presenceStatusFalse);
  }

  static Future<Map<String, dynamic>?> readDocumentData(
      String collectionName, String documentName) async {
    final snapshot =
        await _firestore.collection(collectionName).doc(documentName).get();
    return snapshot.data();
  }

  static Future<void> addData(
      String collectionName, var documentId, Map<String, dynamic> data) async {
    await _firestore.collection(collectionName).doc(documentId).set(data);
  }

  /// for subCollection Data
  static Future<void> addDataToSubCollection(
      String collectionName, documentId, Map<String, dynamic> data) async {
    await _firestore
        .collection(collectionName)
        .doc(documentId)
        .collection(UsersKey.userImageSubCollection)
        .doc()
        .set(data);
    // await _firestore.collection(collectionName).doc(documentId).set(data);
  }

  static fetchSubCollectionData(String collectionName, String id,
      String subCollectionName, Map<String, dynamic> data) async {
    var list;
    await _firestore
        .collection(collectionName)
        .doc(id)
        .collection(subCollectionName)
        .get()
        .then((value) => {
              if (value.docs.isNotEmpty) {list = value.docs}
            });
    // await _firestore.collection(collectionName).doc(id).get().then((value) => {
    //       if (value.exists) {list = value.data()}
    //     });
    return list;
  }

  static Future<dynamic> updateSubCollectionData(String collectionRef,
      var documentId, var subDocumentId, Map<String, dynamic> data) async {
    return await _firestore
        .collection(collectionRef)
        .doc(documentId)
        .collection(UsersKey.userImageSubCollection)
        .doc(subDocumentId)
        .update(data);
  }

  /// end subCollection
  static Future<void> updateData(
      String collectionRef, var id, Map<String, dynamic> data) async {
    await _firestore
        .collection(collectionRef)
        .doc(id)
        .update(data)
        .catchError((e) {
      print(e);
    });
    return;
  }

  static Future<void> deleteTask(String collectionRef, String id) async {
    await _firestore.collection(collectionRef).doc(id).delete().catchError((e) {
      print(e);
    });
    return;
  }

  static Future<void> addNewUser(Map<String, dynamic> user) async {
    await _firestore.collection('signup-user').doc().set(user);
  }

  static Future<String> fetchUserData(
      String collectionName, String id, Map<String, dynamic> data) async {
    var list;
    await _firestore.collection(collectionName).doc(id).get().then((value) => {
          if (value.exists) {list = value.data()}
        });
    return list;
  }

  static Future<Map> fetchUsers(String collectionRef) async {
    CollectionReference ref = _firestore.collection(collectionRef);
    QuerySnapshot snapshot = await ref.get();
    Map<String, dynamic>? data = <String, dynamic>{};
    for (var item in snapshot.docs) {
      data = item.data() as Map<String, dynamic>?;
      // var name = data!['name'];
      // print(name);
    }
    return data!;
  }

  static Future<void> deleteAction(String id, String collectionRef) async {
    await _firestore.collection(collectionRef).doc(id).delete().catchError((e) {
      print(e);
    });
    return;
  }

  static Future<String> uploadImage(var image) async {
    final FirebaseStorage firebaseStorage = FirebaseStorage.instance;
    var fileName = image.path.split('/').last;
    log('file name: $fileName');
    final metadata = SettableMetadata(contentType: "image/jpeg");
    var snapshot = await firebaseStorage
        .ref()
        .child('images/$fileName')
        .putFile(image, metadata)
        .whenComplete(() {
      log("image uploaded: ");
    });
    var downloadUrl = await snapshot.ref.getDownloadURL();
    return downloadUrl;
  }
}

class UserModel {
  String? uid;
  String? name;
  bool? presence;
  int? lastSeenInEpoch;
  UserModel({
    required uid,
    required name,
    required presence,
    required lastSeenInEpoch,
  });

  UserModel.fromJson(Map<String, dynamic> json) {
    uid = json['uid'];
    name = json['name'];
    presence = json['presence'];
    lastSeenInEpoch = json['lastSeenInEpoch'];
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['uid'] = this.uid;
    data['name'] = this.name;
    data['presence'] = this.presence;
    data['lastSeenInEpoch'] = this.lastSeenInEpoch;
    return data;
  }
}