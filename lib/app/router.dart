import 'package:go_router/go_router.dart';

import '../features/auth/login_screen.dart';
import '../features/home/home_screen.dart';
import '../features/attendance/attendance_screen.dart';
import '../features/marks/marks_screen.dart';
import '../features/timetable/timetable_screen.dart';
import '../features/profile/profile_screen.dart';
import '../features/settings/settings_screen.dart';

final router = GoRouter(
	restorationScopeId: 'router',
	initialLocation: '/login',
	routes: <RouteBase>[
		GoRoute(path: '/login', builder: (_, __) => const LoginScreen()),
		GoRoute(path: '/home', builder: (_, __) => const HomeScreen()),
		GoRoute(path: '/attendance', builder: (_, __) => const AttendanceScreen()),
		GoRoute(path: '/marks', builder: (_, __) => const MarksScreen()),
		GoRoute(path: '/timetable', builder: (_, __) => const TimetableScreen()),
		GoRoute(path: '/profile', builder: (_, __) => const ProfileScreen()),
		GoRoute(path: '/settings', builder: (_, __) => const SettingsScreen()),
	],
);
