import 'package:flutter/material.dart';
import '../common/main_drawer.dart';

class SettingsScreen extends StatefulWidget {
	const SettingsScreen({super.key});

	@override
	State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
	ThemeMode _mode = ThemeMode.system;

	@override
	Widget build(BuildContext context) {
		return Scaffold(
			appBar: AppBar(title: const Text('Settings')),
			drawer: const MainDrawer(),
			body: ListView(
				children: [
					const ListTile(title: Text('Theme')),
					RadioListTile(value: ThemeMode.light, groupValue: _mode, onChanged: (v){setState(()=>_mode = v!);}, title: const Text('Light')),
					RadioListTile(value: ThemeMode.dark, groupValue: _mode, onChanged: (v){setState(()=>_mode = v!);}, title: const Text('Dark')),
					RadioListTile(value: ThemeMode.system, groupValue: _mode, onChanged: (v){setState(()=>_mode = v!);}, title: const Text('System')),
					const Divider(),
					ListTile(
						leading: const Icon(Icons.logout),
						title: const Text('Sign out'),
						onTap: (){},
					),
				],
			),
		);
	}
}
