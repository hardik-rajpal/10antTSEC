import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class MainDrawer {
  static const String auth = '/auth';
  static const String flatfeed = '/flatfeed';
  static const String roomiefeed = '/roomiefeed';
  static const String profile = '/profile';
}

class Values {
  static const String imagePlaceholder = 'https://i.imgur.com/vxP6SFl.png';
  static const double opacitySelected = 1;
  static const double opacityUnselected = 0.2;
}

class Styles {
  static const TextStyle textStyle1 = TextStyle(
    fontSize: 20,
  );
  static const TextStyle textStyleHeading = TextStyle(
    fontSize: 25,
    fontWeight: FontWeight.bold,
  );
  static FaIcon likeIcon = FaIcon(
    FontAwesomeIcons.check,
    color: Colors.green[900],
  );
  static const dislikeIcon = FaIcon(FontAwesomeIcons.xmark, color: Colors.red);
  static const questionMark = FaIcon(
    FontAwesomeIcons.question,
    color: Colors.blue,
  );
}
