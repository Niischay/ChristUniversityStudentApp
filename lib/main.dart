import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'app/router.dart';
import 'app/theme.dart';

Future<void> main() async {
	WidgetsFlutterBinding.ensureInitialized();
	await Supabase.initialize(
		url: const String.fromEnvironment('SUPABASE_URL', defaultValue: ''),
		anonKey: const String.fromEnvironment('SUPABASE_ANON_KEY', defaultValue: ''),
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
