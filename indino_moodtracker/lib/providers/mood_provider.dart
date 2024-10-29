import 'package:flutter/material.dart';
import '../models/mood.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final moodProvider = ChangeNotifierProvider((ref) => MoodNotifier());



class MoodNotifier extends ChangeNotifier {
  final List<Mood> _moods = [];

  List<Mood> get moods => List.unmodifiable(_moods);

  void addMood(Mood mood) {
    _moods.add(mood);
    notifyListeners();
  }

  void removeMood(Mood mood) {
    _moods.remove(mood);
    notifyListeners();
  }
}
