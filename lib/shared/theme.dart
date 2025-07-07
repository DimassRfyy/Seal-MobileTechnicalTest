import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// Warna utama
const Color kYellow = Color(0xFFFFD600);
const Color kBlack = Color(0xFF000000);
const Color kWhite = Color(0xFFFFFFFF);

// TextStyle
final TextStyle kTitleStyle = GoogleFonts.montserrat(
  color: kYellow,
  fontWeight: FontWeight.bold,
  fontSize: 22,
);

final TextStyle kSubtitleStyle = GoogleFonts.montserrat(
  color: kWhite,
  fontWeight: FontWeight.w500,
  fontSize: 16,
);

final TextStyle kBodyStyle = GoogleFonts.montserrat(
  color: kWhite,
  fontWeight: FontWeight.normal,
  fontSize: 14,
);

// FontWeight
const FontWeight kFontWeightBold = FontWeight.bold;
const FontWeight kFontWeightMedium = FontWeight.w500;
const FontWeight kFontWeightRegular = FontWeight.normal;
