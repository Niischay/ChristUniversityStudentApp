import 'package:supabase_flutter/supabase_flutter.dart';

final supabase = Supabase.instance.client;

String regNoToEmail(String regNo) => '$regNo@christ.in';
