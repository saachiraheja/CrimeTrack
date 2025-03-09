import 'package:flutter/material.dart';
import 'edit_screen.dart'; // Import your edit screen.

class YourReportsScreen extends StatelessWidget {
  const YourReportsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Sample list of report names
    final List<String> reports = [
      'Crime 1',
      'Crime 2',
      'Crime 3',
    ];

    return Scaffold(
      // appBar: AppBar(
      //   title: const Text('Reports',style: TextStyle(
      //     fontSize: 24,
      //     fontWeight: FontWeight.bold,
      //       color: Colors.white
      //   )),
      //   backgroundColor: Colors.blue,
      //   leading: IconButton(
      //     icon: const Icon(Icons.arrow_back, color: Colors.white),
      //     onPressed: () {
      //       // Handle back button press
      //       Navigator.of(context).pop();
      //     },
      //   ),
      // ),
      body: ListView.builder(
        itemCount: reports.length,
        itemBuilder: (context, index) {
          return Card(
            margin: const EdgeInsets.all(8.0),
            elevation: 4,
            child: ListTile(
              contentPadding: const EdgeInsets.all(16.0),
              title: Text(
                reports[index],
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold, // Bold text
                ),
              ),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Edit Button
                  IconButton(
                    icon: const Icon(Icons.edit),
                    color: Colors.yellow, // Edit button color
                    onPressed: () {
                      // Navigate to the Edit Screen
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => EditScreen(reportName: reports[index])),
                      );
                    },
                  ),
                  // Delete Button
                  IconButton(
                    icon: const Icon(Icons.delete),
                    color: Colors.red, // Delete button color
                    onPressed: () {
                      // Handle delete action here
                      showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          title: const Text('Delete Report'),
                          content: Text('Are you sure you want to delete ${reports[index]}?'),
                          actions: [
                            TextButton(
                              onPressed: () {
                                // Delete logic (remove from list, etc.)
                                Navigator.of(context).pop();
                              },
                              child: const Text('Yes'),
                            ),
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: const Text('No'),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
