import 'package:flutter/material.dart';

void main() {
  runApp(const StudyPlannerApp());
}

class StudyPlannerApp extends StatelessWidget {
  const StudyPlannerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Study Planner',
      theme: ThemeData(
        primarySwatch: Colors.indigo,
        useMaterial3: true,
      ),
      home: const StudyPlannerHome(),
    );
  }
}

class StudyPlannerHome extends StatefulWidget {
  const StudyPlannerHome({super.key});

  @override
  State<StudyPlannerHome> createState() => _StudyPlannerHomeState();
}

class _StudyPlannerHomeState extends State<StudyPlannerHome> {
  final List<Map<String, dynamic>> subjects = [
    {'name': 'Computer Networks', 'done': false},
    {'name': 'Database Management', 'done': false},
    {'name': 'Flutter Development', 'done': false},
    {'name': 'Data Structures', 'done': false},
  ];

  void addSubject() {
    final controller = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Add Subject'),
          content: TextField(
            controller: controller,
            decoration: const InputDecoration(
              hintText: 'Enter subject name',
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                if (controller.text.trim().isNotEmpty) {
                  setState(() {
                    subjects.add({
                      'name': controller.text.trim(),
                      'done': false,
                    });
                  });
                }
                Navigator.pop(context);
              },
              child: const Text('Add'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    int completed = subjects.where((subject) => subject['done']).length;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Study Planner'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'My Study Plan',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 8),

            Text(
              '$completed of ${subjects.length} subjects completed',
              style: const TextStyle(fontSize: 16),
            ),

            const SizedBox(height: 20),

            Expanded(
              child: ListView.builder(
                itemCount: subjects.length,
                itemBuilder: (context, index) {
                  return Card(
                    child: CheckboxListTile(
                      title: Text(subjects[index]['name']),
                      value: subjects[index]['done'],
                      onChanged: (value) {
                        setState(() {
                          subjects[index]['done'] = value;
                        });
                      },
                      secondary: const Icon(Icons.book),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: addSubject,
        child: const Icon(Icons.add),
      ),
    );
  }
}