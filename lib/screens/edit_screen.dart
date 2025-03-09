import 'package:flutter/material.dart';

class EditScreen extends StatelessWidget {
  final String reportName;

  const EditScreen({Key? key, required this.reportName}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final TextEditingController _controller = TextEditingController(text: reportName);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Report'),
        backgroundColor: Colors.blue,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _controller,
              decoration: const InputDecoration(
                labelText: 'Report Name',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Save the edited report name (You can add more logic here)
                final updatedReportName = _controller.text;
                Navigator.pop(context, updatedReportName);
              },
              child: const Text('Save'),
            ),
          ],
        ),
      ),
    );
  }
}
