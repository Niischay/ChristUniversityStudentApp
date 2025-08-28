import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../repo/auth_repository.dart';
import '../../data/api/client.dart';
import '../common/providers.dart';

class LoginScreen extends ConsumerStatefulWidget {
	const LoginScreen({super.key});

	@override
	ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
	final _formKey = GlobalKey<FormState>();
	final _regCtrl = TextEditingController();
	final _pwdCtrl = TextEditingController();
	bool _loading = false;
	String? _error;

	@override
	void dispose() {
		_regCtrl.dispose();
		_pwdCtrl.dispose();
		super.dispose();
	}

	Future<void> _submit() async {
		if (!_formKey.currentState!.validate()) return;
		
		setState(() {
			_loading = true;
			_error = null;
		});

		try {
			final authRepo = ref.read(authRepositoryProvider);
			await authRepo.signInWithRegNo(_regCtrl.text.trim(), _pwdCtrl.text);
			
			if (!mounted) return;
			context.go('/home');
		} catch (e) {
			if (!mounted) return;
			setState(() {
				_error = e.toString().contains('Invalid login credentials') 
					? 'Invalid Register No or Password' 
					: 'Login failed. Please try again.';
			});
		} finally {
			if (mounted) {
				setState(() => _loading = false);
			}
		}
	}

	@override
	Widget build(BuildContext context) {
		final color = Theme.of(context).colorScheme;
		return Scaffold(
			backgroundColor: Theme.of(context).scaffoldBackgroundColor,
			appBar: AppBar(title: const Text('Login')),
			body: Center(
				child: ConstrainedBox(
					constraints: const BoxConstraints(maxWidth: 420),
					child: Padding(
						padding: const EdgeInsets.all(24),
						child: Form(
							key: _formKey,
							child: Column(
								mainAxisSize: MainAxisSize.min,
								crossAxisAlignment: CrossAxisAlignment.stretch,
								children: [
									TextFormField(
										controller: _regCtrl,
										decoration: const InputDecoration(
											labelText: 'Register No',
											hintText: 'e.g., 1234567',
										),
										validator: (v) => (v == null || v.isEmpty) ? 'Enter Register No' : null,
									),
									const SizedBox(height: 16),
									TextFormField(
										controller: _pwdCtrl,
										obscureText: true,
										decoration: const InputDecoration(
											labelText: 'Password',
											hintText: 'Enter your password',
										),
										validator: (v) => (v == null || v.isEmpty) ? 'Enter password' : null,
									),
									if (_error != null) ...[
										const SizedBox(height: 8),
										Text(
											_error!,
											style: TextStyle(color: color.error),
											textAlign: TextAlign.center,
										),
									],
									const SizedBox(height: 24),
									FilledButton(
										onPressed: _loading ? null : _submit,
										child: _loading
											? const SizedBox(
												height: 20,
												width: 20,
												child: CircularProgressIndicator(strokeWidth: 2),
											)
											: const Text('Login'),
									),
									TextButton(
										onPressed: () {},
										child: const Text('Forgot password?'),
									),
								],
							),
						),
					),
				),
			),
		);
	}
}
