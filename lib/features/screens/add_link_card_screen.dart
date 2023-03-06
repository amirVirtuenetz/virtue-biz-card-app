import 'dart:developer';
import 'dart:io';

import 'package:biz_card/features/model/recommend_model.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../components/text_button.dart';

class AddLinkCardScreen extends StatefulWidget {
  final RecommendedLink? data;
  const AddLinkCardScreen({Key? key, this.data}) : super(key: key);

  @override
  State<AddLinkCardScreen> createState() => _AddLinkCardScreenState();
}

class _AddLinkCardScreenState extends State<AddLinkCardScreen> {
  final TextEditingController controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        body: CustomScrollView(
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
          shrinkWrap: true,
          slivers: <Widget>[
            /// sliver app bar
            SliverAppBar(
              pinned: true,
              floating: true,
              snap: false,
              leading: IconButton(
                iconSize: 30,
                onPressed: () {
                  Navigator.of(context).pop();
                },
                icon: const Icon(Icons.close),
              ),
              centerTitle: true,
              title: Text('${widget.data?.title}'),
              backgroundColor: Colors.white,
              expandedHeight: 80.0,
              flexibleSpace: FlexibleSpaceBar(
                background: Container(),
              ),
              actions: [
                Padding(
                  padding: const EdgeInsets.only(right: 10),
                  child: TextButton(
                    style: TextButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    onPressed: () async {
                      if (controller.text.contains("@gmail")) {
                        String email = Uri.encodeComponent(controller.text);
                        String subject = Uri.encodeComponent("Hello Flutter");
                        String body =
                            Uri.encodeComponent("Hi! I'm Flutter Developer");
                        print(subject); //output: Hello%20Flutter
                        Uri mail = Uri.parse(
                            "mailto:$email?subject=$subject&body=$body");
                        var uri =
                            'mailto:${controller.text}?subject=Greetings&body=Hello%20World';
                        if (await canLaunchUrl(mail)) {
                          await launchUrl(mail);
                        } else {
                          throw 'Could not launch $mail';
                        }
                      } else {
                        if (Platform.isAndroid) {
                          var url = controller.text;
                          if (url.startsWith("https://www.facebook.com/")) {
                            final url2 = "fb://facewebmodal/f?href=$url";
                            // final intent2 = AndroidIntent(action: "action_view", data: url2);
                            // final canWork = await intent2.canResolveActivity();
                            // if (canWork) return intent2.launch();
                          }
                          // final intent = AndroidIntent(action: "action_view", data: url);
                          // return intent.launch();
                        } else {
                          if (await canLaunchUrl(Uri.parse(controller.text))) {
                            await launch(controller.text, forceSafariVC: false);
                          } else {
                            throw "Could not launch ${controller.text}";
                          }
                        }
                      }
                    },
                    child: const Text(
                      "Preview",
                      style: TextStyle(color: Colors.black, fontSize: 14),
                    ),
                  ),
                )
              ],
            ),

            ///
            SliverPadding(
              padding: const EdgeInsets.symmetric(horizontal: 0),
              sliver: SliverToBoxAdapter(
                child: Container(
                  height: 150,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade300,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(
                        widget.data?.leadingIcon,
                        size: 40,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "${widget.data?.title}",
                          style: const TextStyle(
                            color: Colors.black,
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),

            /// TextField
            SliverPadding(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 30),
              sliver: SliverToBoxAdapter(
                child: TextField(
                  controller: controller,
                  style: const TextStyle(
                    // height: 1,
                    fontSize: 16,
                    fontFamily: 'InterRegular',
                    // color: const Color(0XFF111827),
                  ),
                  decoration: InputDecoration(
                    hintText: "Add Data",
                    // contentPadding: EdgeInsets.symmetric(horizontal: 15),
                    prefixIconConstraints: const BoxConstraints(
                      maxWidth: 100,
                      minWidth: 30,
                      maxHeight: 62,
                    ),
                    prefixIcon: Padding(
                      padding: const EdgeInsets.only(left: 0, right: 10),
                      child: Container(
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            color: Colors.grey.shade300,
                            borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(12),
                              bottomLeft: Radius.circular(12),
                            )),
                        child: Text(
                          "${widget.data?.title}",
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                    // contentPadding: const EdgeInsets.symmetric(
                    //   horizontal: 15,
                    //   vertical: 15,
                    // ),
                    hintStyle: const TextStyle(
                      fontSize: 16,
                      // height: 1.4,
                      fontFamily: "InterRegular",
                      fontWeight: FontWeight.w400,
                    ),
                    filled: true,
                    isDense: false,
                    border: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(12),
                      ),
                      borderSide: BorderSide(
                        width: 1,
                        color: Colors.white,
                      ),
                    ),
                    enabledBorder: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(12),
                      ),
                      borderSide: BorderSide(width: 1, color: Colors.grey),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: const BorderRadius.all(Radius.circular(12)),
                      borderSide: BorderSide(
                        width: 1,
                        color: const Color(0xff111827).withOpacity(0.2),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            const SliverToBoxAdapter(
              child: SizedBox(
                height: 100,
              ),
            ),
            SliverPadding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
              sliver: SliverToBoxAdapter(
                child: AppTextButton(
                  key: const Key("btn-1"),
                  onPressed: () {},
                  backgroundColor: Colors.grey.shade50,
                  textColor: Colors.black,
                  elevation: 2,
                  title: "Add Another",
                ),
              ),
            ),
            SliverPadding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
              sliver: SliverToBoxAdapter(
                child: AppTextButton(
                  key: const Key("btn-2"),
                  onPressed: () {
                    bool validURL = Uri.parse(controller.text).isAbsolute;
                    if (validURL) {
                      log("link is valid");
                    } else {
                      log("link invalid");
                    }
                  },
                  title: "Save Link",
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
