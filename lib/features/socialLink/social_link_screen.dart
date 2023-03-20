import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../core/helpers/auth_enum.dart';
import '../components/contact_card.dart';
import '../model/recommend_model.dart';
import 'add_link_card_screen.dart';

class SocialLinkScreen extends StatefulWidget {
  const SocialLinkScreen({Key? key}) : super(key: key);

  @override
  State<SocialLinkScreen> createState() => _SocialLinkScreenState();
}

class _SocialLinkScreenState extends State<SocialLinkScreen> {
  // final ScrollController scrollController = ScrollController();
  final List<RecommendedLink> recommended = [
    RecommendedLink(
        title: "Number",
        leadingIcon: FontAwesomeIcons.phone,
        linkType: SocialLinkTypes.Number,
        hintText: "Phone Number"),
    RecommendedLink(
        title: "Email",
        leadingIcon: FontAwesomeIcons.envelope,
        linkType: SocialLinkTypes.Email,
        hintText: "Email Address"),
    RecommendedLink(
        title: "Instagram",
        leadingIcon: FontAwesomeIcons.instagram,
        linkType: SocialLinkTypes.Instagram,
        hintText: "Instagram username"),
    RecommendedLink(
        title: "Website",
        leadingIcon: Icons.web_sharp,
        linkType: SocialLinkTypes.Website,
        hintText: "Website Link"),
    RecommendedLink(
        title: "LinkedIn",
        leadingIcon: FontAwesomeIcons.linkedin,
        linkType: SocialLinkTypes.LinkedIn,
        hintText: "LinkedIn profile link"),
    RecommendedLink(
        title: "Contact Card",
        leadingIcon: Icons.confirmation_number_outlined,
        linkType: SocialLinkTypes.ContactCard,
        hintText: "contact Card"),
  ];

  final List<RecommendedLink> contactInfo = [
    RecommendedLink(title: "Number", leadingIcon: FontAwesomeIcons.phone),
    RecommendedLink(title: "Email", leadingIcon: FontAwesomeIcons.envelope),
    RecommendedLink(
        title: "Contact Card", leadingIcon: Icons.confirmation_number_outlined),
    RecommendedLink(title: "WhatsApp", leadingIcon: FontAwesomeIcons.whatsapp),
    RecommendedLink(title: "Call", leadingIcon: Icons.call),
    RecommendedLink(title: "WeChat", leadingIcon: FontAwesomeIcons.weixin),
  ];

  /// social media list
  final List<RecommendedLink> socialMediaList = [
    RecommendedLink(
        title: "Instagram", leadingIcon: FontAwesomeIcons.instagram),
    RecommendedLink(title: "LinkedIn", leadingIcon: FontAwesomeIcons.linkedin),
    RecommendedLink(title: "Facebook", leadingIcon: FontAwesomeIcons.facebook),
    RecommendedLink(title: "YouTube", leadingIcon: FontAwesomeIcons.youtube),
    RecommendedLink(title: "Clubhouse", leadingIcon: Icons.waving_hand),
    RecommendedLink(title: "Twitch", leadingIcon: FontAwesomeIcons.twitch),
  ];

  /// social media list
  final List<RecommendedLink> business = [
    RecommendedLink(title: "Website", leadingIcon: FontAwesomeIcons.compass),
    RecommendedLink(title: "Calendly", leadingIcon: FontAwesomeIcons.linkedin),
    RecommendedLink(title: "Reviews", leadingIcon: FontAwesomeIcons.google),
    RecommendedLink(title: "Etsy", leadingIcon: FontAwesomeIcons.etsy),
    RecommendedLink(title: "App Link", leadingIcon: Icons.apple_outlined),
    RecommendedLink(title: "Booksy", leadingIcon: FontAwesomeIcons.bookSkull),
  ];

  /// social media list
  final List<RecommendedLink> more = [
    RecommendedLink(title: "Custom link", leadingIcon: FontAwesomeIcons.link),
    RecommendedLink(title: "Linktree", leadingIcon: FontAwesomeIcons.tree),
    RecommendedLink(title: "Telegram", leadingIcon: FontAwesomeIcons.telegram),
    // RecommendedLink(title: "OnlyFans", leadingIcon: FontAwesomeIcons.lock),
    RecommendedLink(
        title: "Poshmark", leadingIcon: Icons.published_with_changes_sharp),
    RecommendedLink(title: "Podcasts", leadingIcon: FontAwesomeIcons.podcast),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        scrollDirection: Axis.vertical,
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        shrinkWrap: true,
        slivers: <Widget>[
          SliverAppBar(
            pinned: true,
            floating: true,
            snap: false,
            title: const Text('Link Store'),
            backgroundColor: Colors.white,
            expandedHeight: 80.0,
            elevation: 0,
            scrolledUnderElevation: 0,
            flexibleSpace: FlexibleSpaceBar(
              background: Container(
                color: Colors.white,
              ),
            ),
          ),

          ///
          const SliverPadding(
            padding: EdgeInsets.symmetric(horizontal: 12),
            sliver: SliverToBoxAdapter(
              child: Text(
                "Recommended",
                style: TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 22,
                ),
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              childCount: recommended.length,
              (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SocialContactCard(
                    title: recommended[index].title,
                    leadingIcon: recommended[index].leadingIcon,
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => AddLinkCardScreen(
                            data: recommended[index],
                          ),
                        ),
                      );
                    },
                  ),
                );
              },
            ),
          ),

          /// contact Info
          const SliverPadding(
            padding: EdgeInsets.symmetric(horizontal: 12),
            sliver: SliverToBoxAdapter(
              child: Text(
                "Contact Info",
                style: TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 22,
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: SizedBox(
              // width: double.infinity,
              height: 240,
              child: GridView.builder(
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                physics: const BouncingScrollPhysics(),
                padding: const EdgeInsets.all(4.0),
                itemCount: contactInfo.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  mainAxisExtent: 250,
                  // maxCrossAxisExtent: 200,
                  // childAspectRatio: 1.5 / 2,
                  // crossAxisSpacing: 20,
                  // mainAxisSpacing: 20,
                ),
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: SocialContactCard(
                      title: contactInfo[index].title,
                      leadingIcon: contactInfo[index].leadingIcon,
                      onPressed: () {},
                    ),
                  );
                },
              ),
            ),
          ),

          /// social media
          const SliverPadding(
            padding: EdgeInsets.symmetric(horizontal: 12),
            sliver: SliverToBoxAdapter(
              child: Text(
                "Social Media",
                style: TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 22,
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: SizedBox(
              // width: double.infinity,
              height: 240,
              child: GridView.builder(
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                physics: const BouncingScrollPhysics(),
                padding: const EdgeInsets.all(4.0),
                itemCount: socialMediaList.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  mainAxisExtent: 250,
                  // maxCrossAxisExtent: 200,
                  // childAspectRatio: 1.5 / 2,
                  // crossAxisSpacing: 20,
                  // mainAxisSpacing: 20,
                ),
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: SocialContactCard(
                      title: socialMediaList[index].title,
                      leadingIcon: socialMediaList[index].leadingIcon,
                      onPressed: () {},
                    ),
                  );
                },
              ),
            ),
          ),

          /// For Business
          const SliverPadding(
            padding: EdgeInsets.symmetric(horizontal: 12),
            sliver: SliverToBoxAdapter(
              child: Text(
                "For Business",
                style: TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 22,
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: SizedBox(
              // width: double.infinity,
              height: 240,
              child: GridView.builder(
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                physics: const BouncingScrollPhysics(),
                padding: const EdgeInsets.all(4.0),
                itemCount: business.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  mainAxisExtent: 250,
                  // maxCrossAxisExtent: 200,
                  // childAspectRatio: 1.5 / 2,
                  // crossAxisSpacing: 20,
                  // mainAxisSpacing: 20,
                ),
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: SocialContactCard(
                      title: business[index].title,
                      leadingIcon: business[index].leadingIcon,
                      onPressed: () {},
                    ),
                  );
                },
              ),
            ),
          ),

          /// More
          const SliverPadding(
            padding: EdgeInsets.symmetric(horizontal: 12),
            sliver: SliverToBoxAdapter(
              child: Text(
                "More",
                style: TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 22,
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: SizedBox(
              // width: double.infinity,
              height: 240,
              child: GridView.builder(
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                physics: const BouncingScrollPhysics(),
                padding: const EdgeInsets.all(4.0),
                itemCount: more.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  mainAxisExtent: 250,
                  // maxCrossAxisExtent: 200,
                  // childAspectRatio: 1.5 / 2,
                  // crossAxisSpacing: 20,
                  // mainAxisSpacing: 20,
                ),
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: SocialContactCard(
                      title: more[index].title,
                      leadingIcon: more[index].leadingIcon,
                      onPressed: () {},
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
