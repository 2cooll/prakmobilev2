import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:mobileapp/models/note.dart';
import 'package:mobileapp/app/services/local_notes_service.dart';
import 'package:mobileapp/app/services/cloud_notes_service.dart';
import 'package:mobileapp/app/services/settings_service.dart';

class StorageDemoController extends GetxController {
  final SettingsService settingsService;
  final LocalNotesService localNotesService;
  final CloudNotesService cloudNotesService;

  StorageDemoController({
    required this.settingsService,
    required this.localNotesService,
    required this.cloudNotesService,
  });

  // Tema
  final isDark = false.obs;

  // Hive
  final localNotes = <Note>[].obs;

  // Supabase
  final cloudNotes = <Note>[].obs;

  // TextField
  final localTitleC = TextEditingController();
  final localContentC = TextEditingController();
  final cloudTitleC = TextEditingController();
  final cloudContentC = TextEditingController();

  final isLoadingCloud = false.obs;

  @override
  void onInit() {
    super.onInit();
    _loadTheme();
    _loadLocalNotes();
    _loadCloudNotes();
  }

  // ---------- shared_preferences ----------
  Future<void> _loadTheme() async {
    final t = await settingsService.getTheme();
    isDark.value = (t == 'dark');
  }

  Future<void> toggleTheme(bool value) async {
    isDark.value = value;
    await settingsService.setTheme(value ? 'dark' : 'light');
  }

  // ---------- Hive ----------
  Future<void> _loadLocalNotes() async {
    localNotes.value = localNotesService.getAll();
  }

  Future<void> addLocalNote() async {
    if (localTitleC.text.trim().isEmpty) return;

    final note = Note(
      id: '',
      title: localTitleC.text.trim(),
      content: localContentC.text.trim(),
      createdAt: DateTime.now(),
    );
    await localNotesService.add(note);
    localTitleC.clear();
    localContentC.clear();
    await _loadLocalNotes();
  }

  Future<void> clearLocalNotes() async {
    await localNotesService.clear();
    await _loadLocalNotes();
  }

  // ---------- Supabase ----------
  Future<void> _loadCloudNotes() async {
    try {
      isLoadingCloud.value = true;
      final notes = await cloudNotesService.fetchNotes();
      cloudNotes.value = notes;
    } finally {
      isLoadingCloud.value = false;
    }
  }

  Future<void> reloadCloudNotes() => _loadCloudNotes();

  Future<void> addCloudNote() async {
    if (cloudTitleC.text.trim().isEmpty) return;

    final note = Note(
      id: '',
      title: cloudTitleC.text.trim(),
      content: cloudContentC.text.trim(),
      createdAt: DateTime.now(),
    );
    await cloudNotesService.addNote(note);
    cloudTitleC.clear();
    cloudContentC.clear();
    await _loadCloudNotes();
  }

  @override
  void onClose() {
    localTitleC.dispose();
    localContentC.dispose();
    cloudTitleC.dispose();
    cloudContentC.dispose();
    super.onClose();
  }
}
