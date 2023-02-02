import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:ten_ant/utils/constants.dart';
import 'package:flutter/material.dart';

ImageProvider getCachedNetworkImage(String coverLink) {
  return CachedNetworkImageProvider(coverLink);
}

ImageProvider getCommonImageProvider(String imagePath) {
  if (imagePath.startsWith('http')) {
    return getCachedNetworkImage(imagePath);
  }
  if (imagePath.startsWith('/data/')) {
    File f;
    try {
      f = File(imagePath);
      f.readAsBytesSync();
    } catch (e) {
      return getCachedNetworkImage(Values.imagePlaceholder);
    }
    return FileImage(f);
  }
  if (imagePath.startsWith('assets/')) {
    return AssetImage(imagePath);
  }
  return getCachedNetworkImage(Values.imagePlaceholder);
}
//TD:asset image and pic image from device option.;