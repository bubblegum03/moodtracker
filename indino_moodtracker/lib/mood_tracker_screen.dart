import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'providers/mood_provider.dart';
import 'models/mood.dart';

class MoodTrackerScreen extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final moodNotifier = ref.watch(moodProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text("Mood Tracker"),
      ),
      body: ListView.builder(
        itemCount: moodNotifier.moods.length,
        itemBuilder: (context, index) {
          final mood = moodNotifier.moods[index];
          return ListTile(
            title: Text(mood.description),
            subtitle: Text("Mood Level: ${mood.moodLevel}, Date: ${mood.date.toLocal()}"),
            trailing: IconButton(
              icon: Icon(Icons.delete),
              onPressed: () {
                ref.read(moodProvider).removeMood(mood);
              },
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _addMoodDialog(context, ref),
        child: Icon(Icons.add),
      ),
    );
  }

  void _addMoodDialog(BuildContext context, WidgetRef ref) {
    final TextEditingController descriptionController = TextEditingController();
    final TextEditingController moodLevelController = TextEditingController();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Add Mood"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: descriptionController,
                decoration: InputDecoration(labelText: "Description"),
              ),
              TextField(
                controller: moodLevelController,
                decoration: InputDecoration(labelText: "Mood Level (1-10)"),
                keyboardType: TextInputType.number,
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                final description = descriptionController.text;
                final moodLevel = int.tryParse(moodLevelController.text) ?? 0;

                if (description.isNotEmpty && moodLevel > 0) {
                  final mood = Mood(
                    date: DateTime.now(),
                    description: description,
                    moodLevel: moodLevel,
                  );
                  ref.read(moodProvider).addMood(mood);
                  Navigator.of(context).pop();
                }
              },
              child: Text("Add"),
            ),
          ],
        );
      },
    );
  }
}
