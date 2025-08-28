import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../common/providers.dart';

class HomeScreen extends ConsumerWidget {
	const HomeScreen({super.key});

	@override
	Widget build(BuildContext context, WidgetRef ref) {
		final session = ref.watch(sessionStreamProvider);
		
		return Scaffold(
			appBar: AppBar(
				title: const Text('Student App'),
				actions: [
					Padding(
						padding: const EdgeInsets.only(right: 12),
						child: Chip(
							label: const Text('Att. 100%'),
							backgroundColor: Theme.of(context).colorScheme.primaryContainer,
						),
					),
				],
			),
			drawer: const _MainDrawer(),
			body: session.when(
				data: (session) => session != null ? _buildContent(context) : _buildLoginPrompt(context),
				loading: () => const Center(child: CircularProgressIndicator()),
				error: (_, __) => _buildLoginPrompt(context),
			),
		);
	}

	Widget _buildContent(BuildContext context) {
		return ListView(
			padding: const EdgeInsets.all(16),
			children: const [
				_SectionCard(
					title: 'Announcements',
					subtitle: 'Latest updates from the university',
					icon: Icons.announcement,
				),
				SizedBox(height: 16),
				_SectionCard(
					title: 'Upcoming Classes',
					subtitle: 'Next 2 classes from your timetable',
					icon: Icons.schedule,
				),
				SizedBox(height: 16),
				_SectionCard(
					title: 'Quick Links',
					subtitle: 'Access attendance, marks, and more',
					icon: Icons.link,
				),
			],
		);
	}

	Widget _buildLoginPrompt(BuildContext context) {
		return Center(
			child: Column(
				mainAxisAlignment: MainAxisAlignment.center,
				children: [
					Icon(
						Icons.school,
						size: 64,
						color: Theme.of(context).colorScheme.primary,
					),
					const SizedBox(height: 16),
					Text(
						'Welcome to Christ Student',
						style: Theme.of(context).textTheme.headlineSmall,
					),
					const SizedBox(height: 8),
					const Text('Please log in to access your student portal'),
					const SizedBox(height: 24),
					FilledButton(
						onPressed: () => context.go('/login'),
						child: const Text('Go to Login'),
					),
				],
			),
		);
	}
}

class _SectionCard extends StatelessWidget {
	final String title;
	final String subtitle;
	final IconData icon;
	
	const _SectionCard({
		required this.title,
		required this.subtitle,
		required this.icon,
	});
	
	@override
	Widget build(BuildContext context) {
		return Card(
			child: Padding(
				padding: const EdgeInsets.all(24),
				child: Column(
					crossAxisAlignment: CrossAxisAlignment.start,
					children: [
						Row(
							children: [
								Icon(icon, color: Theme.of(context).colorScheme.primary),
								const SizedBox(width: 12),
								Expanded(
									child: Text(
										title,
										style: Theme.of(context).textTheme.titleMedium?.copyWith(
											fontWeight: FontWeight.w600,
										),
									),
								),
							],
						),
						const SizedBox(height: 8),
						Text(
							subtitle,
							style: Theme.of(context).textTheme.bodyMedium?.copyWith(
								color: Theme.of(context).colorScheme.onSurfaceVariant,
							),
						),
					],
				),
			),
		);
	}
}

class _MainDrawer extends ConsumerWidget {
	const _MainDrawer();

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
											color: Theme.of(context).colorScheme.onPrimary.withOpacity(0.8),
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
