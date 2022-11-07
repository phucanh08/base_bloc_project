import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class FACodePoints {
  FACodePoints._();
  static const int rotate = 0xf2f1;
  static const int bell = 0xf0f3;
  static const int chartSimple = 0xe473;
  static const int circlePlus = 0xf055;
  static const int circleMinus = 0xf056;
  static const int wallet = 0xf555;
  static const int house = 0xf015;
  static const int grid2 = 0xe196;
  static const int clockRotateLeft = 0xf1da;
  static const int check = 0xf00c;
}

class FontAwesomeIcon extends IconData {
  const FontAwesomeIcon(super.codePoint)
      : super(fontFamily: 'FontAwesomeSolid');

  const FontAwesomeIcon.solid(super.codePoint)
      : super(fontFamily: 'FontAwesomeSolid');

  const FontAwesomeIcon.sharpSolid(super.codePoint)
      : super(fontFamily: 'FontAwesomeSharpSolid');

  const FontAwesomeIcon.duoTone(super.codePoint)
      : super(fontFamily: 'FontAwesomeDuoTone');

  const FontAwesomeIcon.brand(super.codePoint)
      : super(fontFamily: 'FontAwesomeBrand');

  const FontAwesomeIcon.regular(super.codePoint)
      : super(fontFamily: 'FontAwesomeRegular');

  const FontAwesomeIcon.light(super.codePoint)
      : super(fontFamily: 'FontAwesomeLight');

  const FontAwesomeIcon.thin(super.codePoint)
      : super(fontFamily: 'FontAwesomeThin');
}

