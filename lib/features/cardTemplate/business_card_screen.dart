import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';

import '../components/circle_button.dart';

class BusinessCardTemplate extends StatefulWidget {
  final Color? color;
  final bool? isSocialColorEnabled;
  const BusinessCardTemplate({Key? key, this.color, this.isSocialColorEnabled})
      : super(key: key);

  @override
  State<BusinessCardTemplate> createState() => _BusinessCardTemplateState();
}

class _BusinessCardTemplateState extends State<BusinessCardTemplate>
    with SingleTickerProviderStateMixin {
  String facebookImage = "assets/images/facebook.png";
  String googleIcon = "assets/icons/google.svg";
  String instagramImage = "assets/icons/instagram.svg";
  String twitterImage = "assets/images/twitter.png";
  String whatsappImage = "assets/images/twitter.png";
  List btnList(BuildContext context) => [
        CircleButton(
          fillColor:
              widget.isSocialColorEnabled == true ? widget.color : Colors.white,
          onPressed: () {},
          child: const Icon(
            Icons.email_outlined,
            size: 35.0,
          ),
        ),
        CircleButton(
          onPressed: () {},
          child: SvgPicture.asset(googleIcon),
        ),
        CircleButton(
          onPressed: () {},
          child: const Icon(
            Icons.apple_outlined,
            size: 35.0,
          ),
        ),
        CircleButton(
          onPressed: () {},
          child: SvgPicture.asset(instagramImage),
        ),
        CircleButton(
          onPressed: () {},
          child: Image.asset(
            facebookImage,
            fit: BoxFit.contain,
          ),
        ),
      ];

  late Animation<double> animation;
  late AnimationController controller;
  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      duration: const Duration(milliseconds: 700),
      vsync: this,
    );
    controller.addListener(() {
      setState(() {});
    });
    controller.forward();
    // controller.addStatusListener((status) {
    //   if (status == AnimationStatus.completed) {
    //   }
    // });
    animation = Tween<double>(begin: 1, end: 0).animate(controller);
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(widget.color == Colors.white
        ? SystemUiOverlayStyle.dark
        : SystemUiOverlayStyle.light);
    final customTheme = ThemeData(
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: widget.color,
        ),
      ),
      textTheme: TextTheme(
        bodyText1: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w700,
                color: Colors.white,
                fontFamily: "InterRegular")
            .copyWith(color: Colors.blueAccent),
      ),
    );
    var size = MediaQuery.of(context).size;
    final orientation = MediaQuery.of(context).orientation;
    return Theme(
      data: customTheme,
      child: Scaffold(
        body: Stack(
          children: [
            Positioned.fill(
              child: Container(
                color: widget.color ?? Colors.white12,
              ),
            ),

            /// cover photo
            Positioned(
              top: kToolbarHeight,
              child: Container(
                width: size.width,
                height: 150,
                color: Colors.white,
              ),
            ),

            /// profile pictures
            Positioned(
              top: 155,
              left: size.width / 2.8,
              child: AnimatedOpacity(
                duration: const Duration(milliseconds: 700),
                opacity: controller.value,
                child: Stack(
                  fit: StackFit.passthrough,
                  children: [
                    Positioned(
                      child: Card(
                        elevation: 5,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(100),
                        ),
                        child: const CircleAvatar(
                          radius: 45,
                          backgroundColor: Colors.white,
                          child: CircleAvatar(
                            radius: 40,
                            backgroundImage:
                                AssetImage("assets/avaters/Avatar 6.jpg"),
                          ),
                        ),
                      ),
                    ),

                    /// company logo
                    Positioned(
                      bottom: 0,
                      right: 0,
                      width: 40,
                      height: 40,
                      child: Material(
                        borderRadius: BorderRadius.circular(100),
                        child: InkWell(
                          borderRadius: BorderRadius.circular(100),
                          onTap: () {},
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(100),
                            child: Container(
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(
                                    color: Colors.blueAccent, width: 1),
                              ),
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
            Positioned(
              top: 270,
              width: size.width,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      "Amir Nazir",
                      style: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 18,
                          fontFamily: "PoppinsBold"),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    child: Text(
                      "Job Title & Company Title",
                      style: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 14,
                      ),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    child: Text(
                      "Rahim Yar Khan",
                      style: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 14,
                      ),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    child: Text(
                      "I am Flutter developer1",
                      style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 14,
                          fontFamily: "InterRegular"),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 50, vertical: 10),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          // backgroundColor: Colors.green,
                          maximumSize: const Size(double.infinity, 40),
                          minimumSize: const Size(double.infinity, 40),
                          elevation: 3,
                          // side: BorderSide(width: 3, color: Colors.brown),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25),
                          )
                          // padding: const EdgeInsets.all(12),
                          ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const BusinessCardTemplate(),
                          ),
                        );
                      },
                      child: Text(
                        "Save Contact",
                        style: Theme.of(context)
                            .textTheme
                            .bodyText1
                            ?.copyWith(color: Colors.white),
                        // style: TextStyle(
                        //     fontSize: 14,
                        //     fontWeight: FontWeight.w700,
                        //     color: Colors.white,
                        //     fontFamily: "InterRegular"),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 300,
                    child: GridView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount:
                              (orientation == Orientation.portrait) ? 3 : 4,
                          // maxCrossAxisExtent: 100,
                          childAspectRatio: 3 / 2,
                          crossAxisSpacing: 20,
                          mainAxisSpacing: 20,
                        ),
                        itemCount: btnList(context).length,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 10),
                        itemBuilder: (BuildContext ctx, index) {
                          return btnList(context)[index];
                          //   GestureDetector(
                          //   onTap: () {},
                          //   child: SizedBox(
                          //     width: MediaQuery.of(context).size.width * 0.09,
                          //     height: MediaQuery.of(context).size.width * 0.09,
                          //     child:
                          //         SvgPicture.asset("assets/icons/email_box.svg"),
                          //   ),
                          // );
                        }),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
