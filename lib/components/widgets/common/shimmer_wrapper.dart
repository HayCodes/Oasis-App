import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

Widget shimmerWrapper({required Widget child}) {
  return Shimmer.fromColors(
    baseColor: Colors.grey.shade300,
    highlightColor: Colors.grey.shade100,
    child: child,
  );
}