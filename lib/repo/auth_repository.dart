import 'package:supabase_flutter/supabase_flutter.dart';

import '../data/api/client.dart';

class AuthRepository {
	Future<AuthResponse> signInWithRegNo(String regNo, String password) async {
		return await supabase.auth.signInWithPassword(
			email: regNoToEmail(regNo),
			password: password,
		);
	}

	Future<void> signOut() async {
		await supabase.auth.signOut();
	}
}
