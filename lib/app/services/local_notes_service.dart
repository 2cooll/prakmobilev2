import 'package:hive_flutter/hive_flutter.dart';
import 'package:mobileapp/models/note.dart';

class LocalNotesService {
  Box<Note> get _box => Hive.box<Note>('local_notes');

  List<Note> getAll() {
    return _box.values.toList();
  }

  Future<void> add(Note note) async {
    await _box.add(note);
  }

  Future<void> clear() async {
    await _box.clear();
  }
}
