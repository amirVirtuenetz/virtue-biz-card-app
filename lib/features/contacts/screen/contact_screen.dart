import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../model/user_model.dart';
import '../../providers/user_provider.dart';

class ContactScreen extends ConsumerStatefulWidget {
  const ContactScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<ContactScreen> createState() => _ContactScreenState();
}

class _ContactScreenState extends ConsumerState<ContactScreen> {
  late var userpro;
  UserDataModel userData = UserDataModel();
  Stream<QuerySnapshot<Object?>>? stream;
  final FixedExtentScrollController _controller = FixedExtentScrollController();
  @override
  void initState() {
    userpro = ref.read(userProvider);
    stream = userpro.getContactCardData();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: CustomScrollView(
        shrinkWrap: true,
        slivers: [
          /// sliver app bar
          SliverAppBar(
            pinned: true,
            floating: true,
            snap: false,
            centerTitle: true,
            automaticallyImplyLeading: false,
            title: const Text(
              'Contacts',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w700,
              ),
            ),
            backgroundColor: Colors.white,
            expandedHeight: 50.0,
            elevation: 0,
            scrolledUnderElevation: 0,
            flexibleSpace: FlexibleSpaceBar(
              background: Container(
                color: Colors.white,
              ),
            ),
            // actions: [
            //   Padding(
            //     padding: const EdgeInsets.only(right: 10),
            //     child: TextButton(
            //       style: TextButton.styleFrom(
            //         shape: RoundedRectangleBorder(
            //           borderRadius: BorderRadius.circular(8),
            //         ),
            //       ),
            //       onPressed: () {},
            //       child: const Text(
            //         "Preview",
            //         style: TextStyle(color: Colors.black, fontSize: 14),
            //       ),
            //     ),
            //   )
            // ],
          ),

          ///
          // SliverPadding(
          //   padding: const EdgeInsets.symmetric(horizontal: 0),
          //   sliver: SliverToBoxAdapter(
          //     child: Container(
          //       height: 150,
          //       alignment: Alignment.center,
          //       decoration: BoxDecoration(
          //         color: Colors.grey.shade300,
          //       ),
          //       child: const Column(
          //         mainAxisAlignment: MainAxisAlignment.center,
          //         crossAxisAlignment: CrossAxisAlignment.center,
          //         children: [
          //           Icon(
          //             Icons.ac_unit,
          //             size: 40,
          //           ),
          //           Padding(
          //             padding: EdgeInsets.all(8.0),
          //             child: Text(
          //               "Data",
          //               style: TextStyle(
          //                 color: Colors.black,
          //                 fontSize: 14,
          //                 fontWeight: FontWeight.w400,
          //               ),
          //             ),
          //           )
          //         ],
          //       ),
          //     ),
          //   ),
          // ),
          SliverToBoxAdapter(
            child: SizedBox(
              height: 350,
              child: StreamBuilder<QuerySnapshot>(
                stream: stream,
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  }
                  switch (snapshot.connectionState) {
                    case ConnectionState.waiting:
                      return const Center(child: CircularProgressIndicator());
                    default:
                      return snapshot.data!.docs.isEmpty
                          ? const SizedBox.shrink()
                          : ListView.builder(
                              itemCount: snapshot.data?.docs.length,
                              itemBuilder: (BuildContext context, int index) {
                                DocumentSnapshot document =
                                    snapshot.data!.docs[index];
                                final user = UserDataModel.fromJson(
                                    document.data() as Map<String, dynamic>);
                                log("Snapshot: ${user.displayName}");
                                // String data = document.get("").toString();
                                return Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 5),
                                  child: ListTile(
                                    tileColor: Colors.grey.shade300,
                                    dense: false,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(5),
                                    ),
                                    contentPadding: const EdgeInsets.symmetric(
                                        vertical: 0, horizontal: 10),
                                    leading: ClipOval(
                                      child: CachedNetworkImage(
                                        imageUrl: '${user.photoUrl}',
                                      ),
                                    ),
                                    title: Text("${user.displayName}"),
                                    subtitle: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text("${user.email}"),
                                        Text("${user.jobTitle}"),
                                      ],
                                    ),
                                    isThreeLine: false,
                                    trailing: IconButton(
                                      icon:
                                          const Icon(Icons.more_vert_outlined),
                                      onPressed: () {
                                        openBottomSheet(context,
                                            removeContact: () {
                                          var data = {
                                            'isDeleted': 1,
                                          };
                                          userpro.updateSubCollectionData(
                                              document.id, data);
                                          log("remove contact : ${document.id}");
                                        }, shareContact: () {
                                          userpro.shareContact(document.id);
                                        });
                                      },
                                    ),
                                  ),
                                );
                                //   Container(
                                //   color: Colors.blueAccent,
                                //   child: ListTile(
                                //     title: Text(document.get("type")),
                                //     subtitle: Text(document.get("created")),
                                //   ),
                                // );
                              },
                            );
                  }
                },
              ),
            ),
          ),
          // SliverToBoxAdapter(
          //   child: SizedBox(
          //     height: 200,
          //     child: ListWheelScrollView.useDelegate(
          //       itemExtent: 50,
          //       controller: _controller,
          //       diameterRatio: 2,
          //       useMagnifier: true,
          //       childDelegate: ListWheelChildBuilderDelegate(
          //           childCount: 20,
          //           builder: (BuildContext context, int index) {
          //             return ListTile(
          //               title: Text('$index'),
          //             );
          //           }),
          //       // the height of each item in the list
          //     ),
          //     // ListWheelScrollView(
          //     //   controller: _controller,
          //     //   itemExtent: 80,
          //     //   magnification: 1.2,
          //     //
          //     //   useMagnifier: true,
          //     //   physics: const FixedExtentScrollPhysics(),
          //     //   children: listtiles, // Here listtiles is the List of Widgets.
          //     // ),
          //   ),
          // )
        ],
      ),
    );
  }

  void openBottomSheet(BuildContext context,
      {required dynamic Function() removeContact,
      required dynamic Function() shareContact}) async {
    final action = CupertinoActionSheet(
      title: const Text(
        'Virtue Biz Card',
        style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
      ),
      // message: const Text(
      //   'Choose your favourite player',
      //   style: TextStyle(fontSize: 18),
      // ),
      actions: [
        CupertinoActionSheetAction(
          isDefaultAction: false,
          onPressed: () {},
          child: const Text('Save to Contacts'),
        ),
        CupertinoActionSheetAction(
          isDestructiveAction: false,
          onPressed: () {
            Navigator.pop(context);
            shareContact();
          },
          child: const Text('Share Contacts'),
        ),
        CupertinoActionSheetAction(
          isDestructiveAction: true,
          onPressed: () {
            Navigator.pop(context);
            removeContact();
          },
          child: const Text('Remove Contacts'),
        ),
      ],
      cancelButton: CupertinoActionSheetAction(
        child: const Text('Cancel'),
        onPressed: () {
          Navigator.pop(context);
        },
      ),
    );
    showCupertinoModalPopup(context: context, builder: (context) => action);
  }
}
