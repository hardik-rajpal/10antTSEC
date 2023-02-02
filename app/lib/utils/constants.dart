import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class MainDrawer {
  static const String auth = '/auth';
  static const String flatfeed = '/flatfeed';
}

class Styles {
  static const TextStyle textStyle1 = TextStyle(
    fontSize: 20,
  );
  static const TextStyle textStyleHeading = TextStyle(
    fontSize: 25,
    fontWeight: FontWeight.bold,
  );
  static const likeIcon = FaIcon(FontAwesomeIcons.check);
  static const dislikeIcon = FaIcon(FontAwesomeIcons.xmark);
  static const questionMark = FaIcon(FontAwesomeIcons.question);
}
