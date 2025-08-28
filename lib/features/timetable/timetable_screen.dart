import 'package:flutter/material.dart';

class TimetableScreen extends StatelessWidget {
	const TimetableScreen({super.key});

	@override
	Widget build(BuildContext context) {
		return Scaffold(
			appBar: AppBar(title: const Text('Time Table')),
			drawer: const Drawer(),
			body: ListView.builder(
				padding: const EdgeInsets.all(16),
				itemCount: 5,
				itemBuilder: (_, i) => Card(
					child: ListTile(
						title: Text('Period ${i + 1}'),
						subtitle: const Text('09:00 - 09:50 • Room 101'),
					),
				),
			),
		);
	}
}
