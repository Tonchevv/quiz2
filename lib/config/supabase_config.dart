import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseConfig {
  static const String supabaseUrl = 'https://okslohsyzjxikqbnvkqw.supabase.co';
  static const String supabaseAnonKey =
      'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Im9rc2xvaHN5emp4aWtxYm52a3F3Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3NTg0NTg1ODgsImV4cCI6MjA3NDAzNDU4OH0.FF2O-rBIlpFaW4ojllObetZVK4Kn8KzcAf_2BlsLCGc';

  static SupabaseClient get client => Supabase.instance.client;

  static Future<void> initialize() async {
    await Supabase.initialize(
      url: supabaseUrl,
      anonKey: supabaseAnonKey,
    );
  }
}
