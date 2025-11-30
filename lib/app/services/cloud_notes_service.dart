import 'package:mobileapp/core/app_supabase.dart';
import 'package:mobileapp/models/note.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class CloudNotesService {
  final SupabaseClient _client = AppSupabase.client;

  Future<List<Note>> fetchNotes() async {
    final res = await _client
        .from('notes')
        .select()
        .order('created_at', ascending: false);

    final list = (res as List)
        .map((e) => Note.fromMap(e as Map<String, dynamic>))
        .toList();

    return list;
  }

  Future<Note?> addNote(Note note) async {
    final payload = note.toMapForSupabase();

    final res = await _client
        .from('notes')
        .insert(payload)
        .select()
        .maybeSingle();

    if (res == null) {
      return null;
    }

    return Note.fromMap(res as Map<String, dynamic>);
  }
}
