import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ThemeSystem {
  static ThemeData theme(BuildContext context) => ThemeData(
    disabledColor: Colors.grey,

      cardColor:        const Color(0xFFF0F0F0),
      hintColor:        const Color.fromARGB(255, 206, 207, 238),
      focusColor:       const Color(0xffA8DAB5),
      hoverColor:       const Color(0xff4285F4),
      highlightColor:   const Color(0xffFCE192),
      indicatorColor:   const Color(0xffCBDCF8),

      brightness:      Brightness.light,
      canvasColor:     Colors.grey[50],
      primaryColor:    const Color(0xFF0077B6),
      appBarTheme: const AppBarTheme(elevation: 0.0),

      textTheme: GoogleFonts.robotoTextTheme()
                            .apply(),

      buttonTheme: Theme.of(context).buttonTheme
                        .copyWith(colorScheme: const ColorScheme.light()), 
      
      colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.blue)
                              .copyWith(background: const Color(0xffF1F5FB)),
  );
  
}