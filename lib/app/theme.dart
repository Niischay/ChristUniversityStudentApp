import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

ThemeData buildAppTheme({Brightness brightness = Brightness.light}) {
	final colorScheme = ColorScheme.fromSeed(
		seedColor: const Color(0xFF5B4B8A),
		brightness: brightness,
	);
	final base = ThemeData(
		useMaterial3: true,
		colorScheme: colorScheme,
		textTheme: GoogleFonts.poppinsTextTheme(),
		scaffoldBackgroundColor: const Color(0xFFF6F6FA),
	);
	return base.copyWith(
		appBarTheme: AppBarTheme(
			backgroundColor: colorScheme.primary,
			foregroundColor: colorScheme.onPrimary,
			elevation: 0,
		),
		cardTheme: CardThemeData(
			margin: const EdgeInsets.all(12),
			shape: const RoundedRectangleBorder(
				borderRadius: BorderRadius.all(Radius.circular(24)),
			),
			elevation: 2,
		),
		inputDecorationTheme: const InputDecorationTheme(
			border: OutlineInputBorder(
				borderRadius: BorderRadius.all(Radius.circular(12)),
			),
		),
	);
}
