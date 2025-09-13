import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart'; // 1. Import the package

import 'app/router.dart';
import 'app/theme.dart';

Future<void> main() async {
	WidgetsFlutterBinding.ensureInitialized();
	
	// 2. Load the .env file
	await dotenv.load(fileName: ".env");

	// 3. Initialize Supabase with the loaded variables
	await Supabase.initialize(
		url: dotenv.env['SUPABASE_URL']!,
		anonKey: dotenv.env['SUPABASE_ANON_KEY']!,
	);
	
	runApp(const ProviderScope(child: ChristStudentApp()));
}

class ChristStudentApp extends ConsumerWidget {
	const ChristStudentApp({super.key});

	@override
	Widget build(BuildContext context, WidgetRef ref) {
		final theme = buildAppTheme();
		return MaterialApp.router(
			title: 'Christ Student',
			theme: theme,
			darkTheme: buildAppTheme(brightness: Brightness.dark),
			themeMode: ThemeMode.system,
			routerConfig: router,
			builder: (context, child) {
				final textTheme = GoogleFonts.poppinsTextTheme(Theme.of(context).textTheme);
				return Theme(
					data: Theme.of(context).copyWith(textTheme: textTheme),
					child: child ?? const SizedBox.shrink(),
				);
			},
		);
	}
}