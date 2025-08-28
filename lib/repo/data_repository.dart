import 'package:supabase_flutter/supabase_flutter.dart';

import '../data/api/client.dart';

class DataRepository {
	Future<List<Map<String, dynamic>>> fetchAnnouncements() async {
		final res = await supabase.from('announcements').select().order('date', ascending: false);
		return (res as List).cast<Map<String, dynamic>>();
	}

	Future<List<Map<String, dynamic>>> fetchAttendance() async {
		final uid = supabase.auth.currentUser!.id;
		final res = await supabase.from('attendance').select('*').eq('user_id', uid);
		return (res as List).cast<Map<String, dynamic>>();
	}

	Future<List<Map<String, dynamic>>> fetchMarks(int semester) async {
		final uid = supabase.auth.currentUser!.id;
		final res = await supabase.from('marks').select('*').eq('user_id', uid).eq('semester', semester);
		return (res as List).cast<Map<String, dynamic>>();
	}

	Future<List<Map<String, dynamic>>> fetchTimetable() async {
		final uid = supabase.auth.currentUser!.id;
		final res = await supabase.from('timetable').select('*').eq('user_id', uid);
		return (res as List).cast<Map<String, dynamic>>();
	}
}
