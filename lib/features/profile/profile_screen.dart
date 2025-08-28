import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
	const ProfileScreen({super.key});

	@override
	Widget build(BuildContext context) {
		return Scaffold(
			appBar: AppBar(title: const Text('Profile')),
			drawer: const Drawer(),
			body: Padding(
				padding: const EdgeInsets.all(24),
				child: Column(
					crossAxisAlignment: CrossAxisAlignment.start,
					children: const [
						CircleAvatar(radius: 36, child: Text('CU')),
						SizedBox(height: 16),
						Text('Register No: 1234567'),
						Text('Program: B.Tech CSE'),
						Text('Semester: 5'),
					],
				),
			),
		);
	}
}
