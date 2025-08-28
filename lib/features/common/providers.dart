import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../repo/auth_repository.dart';
import '../../repo/data_repository.dart';
import '../../data/api/client.dart';

final authRepositoryProvider = Provider<AuthRepository>((ref) => AuthRepository());
final dataRepositoryProvider = Provider<DataRepository>((ref) => DataRepository());

final sessionProvider = Provider<Session?>((ref) => supabase.auth.currentSession);

final sessionStreamProvider = StreamProvider<Session?>((ref) {
	return supabase.auth.onAuthStateChange.map((event) => event.session);
});
