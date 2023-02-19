import 'package:flutter/cupertino.dart';


class Backgrounds {
  static Widget authBackground() {
    return const Image(
      image: AssetImage('assets/images/background.jpg'),
      fit: BoxFit.cover,
      height: double.infinity,
      width: double.infinity,
    );
  }
}
