import 'package:flutter/material.dart';

class MarksScreen extends StatelessWidget {
	const MarksScreen({super.key});

	@override
	Widget build(BuildContext context) {
		return Scaffold(
			appBar: AppBar(title: const Text('Marks Card')),
			drawer: const Drawer(),
			body: ListView(
				padding: const EdgeInsets.all(16),
				children: const [
					Card(child: ListTile(title: Text('Compiler Design'), subtitle: Text('Grade: A'), trailing: Text('93'))),
					Card(child: ListTile(title: Text('Design Patterns'), subtitle: Text('Grade: A+'), trailing: Text('97'))),
				],
			),
		);
	}
}
