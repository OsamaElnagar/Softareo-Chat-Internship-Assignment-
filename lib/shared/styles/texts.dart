// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'fonts.dart';

class SoftareoHeadlines extends StatelessWidget {
  SoftareoHeadlines({
    Key? key,
    required this.headline,
    this.color,
    this.textAlign,
    this.fs,
    this.fw,
  }) : super(key: key);

  final String headline;
  final TextAlign? textAlign;
  Color? color;
  double? fs;
  FontWeight? fw;

  @override
  Widget build(BuildContext context) {
    return Text(
      headline,
      textAlign: textAlign ?? TextAlign.center,
      style: SoftareoTextStyles.softareoHeadlines(color: color, fs: fs, fw: fw),
    );
  }
}

class SoftareoNormalTexts extends StatelessWidget {
  SoftareoNormalTexts({
    Key? key,
    required this.norText,
    this.color,
    this.textAlign,
    this.fs,
    this.fw,
  }) : super(key: key);

  final String norText;
  final TextAlign? textAlign;
  Color? color;
  double? fs;
  FontWeight? fw;

  @override
  Widget build(BuildContext context) {
    return Text(
      norText,
      textAlign: textAlign ?? TextAlign.center,
      style: SoftareoTextStyles.softareoRegularMontserrat(
          fs: fs, fw: fw, color: color),
    );
  }
}

class SoftareoHints extends StatelessWidget {
  SoftareoHints({
    Key? key,
    required this.hint,
    this.textAlign,
    this.color,
    this.fs,
    this.fw,
  }) : super(key: key);

  final String hint;
  final TextAlign? textAlign;
  Color? color;
  int? fs;
  FontWeight? fw;

  @override
  Widget build(BuildContext context) {
    return Text(
      hint,
      style: SoftareoTextStyles.softareoHintMontserrat(color: color, fs: fs,fw: fw),
      textAlign: textAlign ?? TextAlign.center,
    );
  }
}

class SoftareoSpacer extends StatelessWidget {
  const SoftareoSpacer({Key? key, this.width, this.height}) : super(key: key);

  final double? width;
  final double? height;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width ?? double.infinity,
      height: height ?? 25.0,
    );
  }
}

