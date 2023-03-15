import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../components/circle_button.dart';

class BusinessCardUI extends StatefulWidget {
  const BusinessCardUI({super.key});

  @override
  State<BusinessCardUI> createState() => _BusinessCardUIState();
}

class _BusinessCardUIState extends State<BusinessCardUI> {
  List<Widget> btnList(BuildContext context) => [
        CircleButton(
          onPressed: () {},
          child: const Icon(
            Icons.facebook_outlined,
          ),
        ),
        CircleButton(
          onPressed: () {},
          child: SvgPicture.asset(
            "assets/icons/twitter.svg",
            width: 25,
            height: 25,
            color: const Color(0XFF1DA1F2),
          ),
        ),
        CircleButton(
          onPressed: () {},
          child: Image.asset(
            "assets/images/linkedIn.png",
            width: 25,
            height: 25,
          ),
        ),
        CircleButton(
          onPressed: () {},
          child: SvgPicture.asset(
            "assets/icons/instagram.svg",
            width: 25,
            height: 25,
          ),
        ),
        // CircleButton(
        //   onPressed: () {},
        //   child: SvgPicture.asset(
        //     "assets/images/git.png",
        //     width: 25,
        //     height: 25,
        //   ),
        // )
      ];

  @override
  Widget build(BuildContext context) {
    final orientation = MediaQuery.of(context).orientation;
    return Scaffold(
      body: Stack(
        children: [
          CustomPaint(
            painter: CurvePainter(),
            child: Column(
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.25,
                ),
                Container(
                  padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                  child: CircleAvatar(
                    radius: MediaQuery.of(context).size.width * 0.09,
                    backgroundColor: Colors.white,
                    child: CircleAvatar(
                      radius: MediaQuery.of(context).size.width * 0.08,
                      backgroundImage:
                          const AssetImage('assets/avaters/Avatar 4.jpg'),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                const Text(
                  'Abby Williams',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                    letterSpacing: 1.15,
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                Text(
                  'Flutter developer',
                  style: TextStyle(
                    color: Colors.grey.shade400,
                  ),
                ),
                const SizedBox(
                  height: 3,
                ),
                Text(
                  'Location',
                  style: TextStyle(
                    color: Colors.grey.shade400,
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircleButton(
                      onPressed: () {},
                      child: const Icon(
                        Icons.phone,
                        // color: Colors.white,
                        size: 25,
                      ),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.05,
                    ),
                    CircleButton(
                      onPressed: () {},
                      child: const Icon(
                        Icons.email_outlined,
                        // color: Colors.white,
                        size: 25,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 15,
                ),
                Divider(
                  thickness: 1.15,
                  indent: MediaQuery.of(context).size.width * 0.1,
                  endIndent: MediaQuery.of(context).size.width * 0.1,
                  color: Colors.grey.shade400,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.12,
                      height: 20,
                    ),
                    const Text(
                      'OVERVIEW',
                      style: TextStyle(
                        fontSize: 14,
                        letterSpacing: 1.15,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Container(
                  width: MediaQuery.of(context).size.width * 0.8,
                  padding: const EdgeInsets.fromLTRB(20, 3, 1, 3),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade100,
                    border: Border.all(color: Colors.grey.shade200),
                    borderRadius: const BorderRadius.all(
                      Radius.circular(20),
                    ),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: const [
                            Text(
                              'PHONE',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 12,
                                letterSpacing: 1.15,
                              ),
                            ),
                            SizedBox(
                              height: 3,
                            ),
                            Text(
                              '(123) 456 7890',
                              style: TextStyle(
                                color: Colors.grey,
                                fontSize: 12,
                                letterSpacing: 1.1,
                              ),
                            )
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 5),
                        child: Container(
                          width: MediaQuery.of(context).size.width * 0.07,
                          height: MediaQuery.of(context).size.width * 0.07,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.greenAccent.shade400,
                          ),
                          child: const Icon(
                            CupertinoIcons.phone,
                            color: Colors.white,
                            size: 18,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                GestureDetector(
                  onTap: () {},
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.8,
                    padding: const EdgeInsets.fromLTRB(20, 3, 1, 3),
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(
                        Radius.circular(20),
                      ),
                      color: Colors.grey.shade100,
                      border: Border.all(
                        color: Colors.grey.shade200,
                        width: 1,
                      ),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: const [
                              Text(
                                'EMAIL',
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: 1.15,
                                ),
                              ),
                              SizedBox(
                                height: 3,
                              ),
                              Text(
                                'abbywill@example.com',
                                style: TextStyle(
                                  color: Colors.grey,
                                  letterSpacing: 1.0,
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 5),
                          child: Container(
                            width: MediaQuery.of(context).size.width * 0.07,
                            height: MediaQuery.of(context).size.width * 0.07,
                            decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.redAccent),
                            child: const Icon(
                              CupertinoIcons.mail,
                              color: Colors.white,
                              size: 16,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                GestureDetector(
                  onTap: () {},
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.8,
                    padding: const EdgeInsets.fromLTRB(20, 3, 1, 3),
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(
                        Radius.circular(20),
                      ),
                      color: Colors.grey.shade100,
                      border: Border.all(
                        color: Colors.grey.shade200,
                        width: 1,
                      ),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: const [
                              Text(
                                'WEBSITE',
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: 1.15,
                                ),
                              ),
                              SizedBox(
                                height: 3,
                              ),
                              Text(
                                'www.abbywill.com',
                                style: TextStyle(
                                  color: Colors.grey,
                                  letterSpacing: 1.0,
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 5),
                          child: Container(
                            width: MediaQuery.of(context).size.width * 0.07,
                            height: MediaQuery.of(context).size.width * 0.07,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.deepPurple.shade300,
                            ),
                            child: const Icon(
                              CupertinoIcons.globe,
                              color: Colors.white,
                              size: 16,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Divider(
                  indent: MediaQuery.of(context).size.width * 0.1,
                  endIndent: MediaQuery.of(context).size.width * 0.1,
                  color: Colors.grey.shade400,
                  thickness: 1,
                ),

                ///
                // SizedBox(
                //   height: 0,
                //   child: GridView.builder(
                //       physics: const NeverScrollableScrollPhysics(),
                //       gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                //         crossAxisCount:
                //             (orientation == Orientation.portrait) ? 3 : 4,
                //         // maxCrossAxisExtent: 100,
                //         childAspectRatio: 3 / 2,
                //         crossAxisSpacing: 0,
                //         mainAxisSpacing: 0,
                //       ),
                //       itemCount: btnList(context).length,
                //       padding: const EdgeInsets.symmetric(
                //           horizontal: 10, vertical: 10),
                //       itemBuilder: (BuildContext ctx, index) {
                //         return btnList(context)[index];
                //       }),
                // ),
                ///
              ],
            ),
          ),
          Positioned(
            bottom: 15,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 40, vertical: 10),
                  child: Text(
                    'SOCIAL',
                    style: TextStyle(
                      fontSize: 14,
                      letterSpacing: 1.15,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: btnList(context).map((e) => e).toList(),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

class CurvePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint();
    paint.style = PaintingStyle.fill;
    paint.shader = const LinearGradient(
            colors: [Color(0xff8160c7), Color(0xff8f77dc), Color(0xff8f67bc)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight)
        .createShader(
      Rect.fromLTRB(
        size.width * 0.15,
        size.height * 0.15,
        size.width,
        size.height * 0.1,
      ),
    );
    var path = Path();
    path.moveTo(0, size.height * 0.15);
    path.quadraticBezierTo(
        size.width * 0.48, size.height * 0.38, size.width, size.height * 0.25);
    path.quadraticBezierTo(
        size.width * 0.9, size.height * 0.38, size.width, size.height * 0.25);
    path.lineTo(size.width, 0);
    path.lineTo(0, 0);
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    // TODO: implement shouldRepaint
    return true;
  }
}
