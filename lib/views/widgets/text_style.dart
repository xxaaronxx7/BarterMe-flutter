import 'package:emart_app/consts/consts.dart';
import 'package:flutter/material.dart';

Widget normalText({text, color = Colors.white}) {
  return "$text".text.color(color).make();
}

Widget boldText({text, color = Colors.white, size = 14}) {
  return "$text".text.semiBold.color(color).size(size).make();
}
