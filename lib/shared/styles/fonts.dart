import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'colors.dart';

class SoftareoTextStyles {
  static softareoRegularMontserrat({color, fw, fs}) {
    return GoogleFonts.montserrat(
      color: color ?? SoftareoColors.softareoCelestialBlue,
      fontWeight: fw ?? FontWeight.w500,
      fontSize: fs ?? 20,
    );
  }

  static softareoHintMontserrat({color, fw, fs}) {
    return GoogleFonts.montserrat(
      color: color ?? SoftareoColors.softareoGrey,
      fontWeight: fw ?? FontWeight.w600,
      fontSize: fs ?? 15,
    );
  }

  static softareoHeadlines({color, fw, fs}) {
    return GoogleFonts.montserrat(
      color: color ?? SoftareoColors.softareoOrange,
      fontWeight: fw ?? FontWeight.w700,
      fontSize: fs ?? 25,
    );
  }
}
