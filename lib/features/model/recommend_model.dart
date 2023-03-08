import 'package:flutter/cupertino.dart';

import '../../core/helpers/auth_enum.dart';

class RecommendedLink {
  final String title;
  final IconData leadingIcon;
  final SocialLinkTypes? linkType;
  final String? hintText;
  RecommendedLink(
      {required this.title,
      required this.leadingIcon,
      this.linkType,
      this.hintText});
}
