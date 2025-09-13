import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'providers.dart';
import '../../repo/auth_repository.dart';

class MainDrawer extends ConsumerWidget {
  const MainDrawer({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final session = ref.watch(sessionStreamProvider);

    return Drawer(
      child: SafeArea(
        child: Column(
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primary,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CircleAvatar(
                    radius: 30,
                    backgroundColor: Theme.of(context).colorScheme.onPrimary,
                    child: Text(
                      'CU',
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.primary,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    session.valueOrNull?.user.email?.split('@').first ?? 'Guest',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      color: Theme.of(context).colorScheme.onPrimary,
                    ),
                  ),
                  Text(
                    'Christ University',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color:
                          Theme.of(context).colorScheme.onPrimary.withOpacity(0.8),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: ListView(
                children: [
                  _ListTile(
                    icon: Icons.home,
                    title: 'Home',
                    onTap: () => context.go('/home'),
                  ),
                  _ListTile(
                    icon: Icons.how_to_reg,
                    title: 'Attendance',
                    onTap: () => context.go('/attendance'),
                  ),
                  _ListTile(
                    icon: Icons.receipt_long,
                    title: 'Marks Card',
                    onTap: () => context.go('/marks'),
                  ),
                  _ListTile(
                    icon: Icons.calendar_month,
                    title: 'Time Table',
                    onTap: () => context.go('/timetable'),
                  ),
                  _ListTile(
                    icon: Icons.person,
                    title: 'Profile',
                    onTap: () => context.go('/profile'),
                  ),
                  _ListTile(
                    icon: Icons.settings,
                    title: 'Settings',
                    onTap: () => context.go('/settings'),
                  ),
                ],
              ),
            ),
            if (session.valueOrNull != null)
              ListTile(
                leading: const Icon(Icons.logout),
                title: const Text('Sign Out'),
                onTap: () async {
                  await ref.read(authRepositoryProvider).signOut();
                  if (context.mounted) context.go('/login');
                },
              ),
          ],
        ),
      ),
    );
  }
}

class _ListTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final VoidCallback onTap;

  const _ListTile({
    required this.icon,
    required this.title,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon),
      title: Text(title),
      onTap: onTap,
    );
  }
}