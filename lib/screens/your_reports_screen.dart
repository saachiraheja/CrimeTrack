import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'edit_screen.dart';
import 'create_report_page.dart';

class YourReportsScreen extends StatefulWidget {
  const YourReportsScreen({Key? key}) : super(key: key);

  @override
  _YourReportsScreenState createState() => _YourReportsScreenState();
}

class _YourReportsScreenState extends State<YourReportsScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('reports')
            .where('userId', isEqualTo: _auth.currentUser?.uid) // Fetch only user's reports
            .orderBy('createdAt', descending: true) // Ensure index is created for this
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator()); // Show loading spinner
          }

          if (snapshot.hasError) {
            return Center(child: Text("Error: ${snapshot.error}")); // Show error message
          }

          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return const Center(child: Text("No reports found")); // Show message if no reports
          }

          final reports = snapshot.data!.docs;

          return ListView.builder(
            itemCount: reports.length,
            itemBuilder: (context, index) {
              final report = reports[index];
              final reportId = report.id;
              final title = report['title'] ?? 'No Title';
              final crimeType = report['crimeType'] ?? 'Unknown';
              final location = report['location'] ?? 'No Location';

              return Card(
                margin: const EdgeInsets.all(8.0),
                elevation: 4,
                child: ListTile(
                  contentPadding: const EdgeInsets.all(16.0),
                  title: Text(title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  subtitle: Text('$crimeType - $location'),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // Edit Button
                      IconButton(
                        icon: const Icon(Icons.edit),
                        color: Colors.yellow,
                        onPressed: () {
                          // Navigate to Edit Screen (pass report data)
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => EditScreen(reportId: reportId, reportData: report),
                            ),
                          );
                        },
                      ),
                      // Delete Button
                      IconButton(
                        icon: const Icon(Icons.delete),
                        color: Colors.red,
                        onPressed: () => _confirmDelete(context, reportId),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Navigate to Create Report Page
          Navigator.push(context, MaterialPageRoute(builder: (context) => CreateReportPage()));
        },
        backgroundColor: Colors.blue,
        child: const Icon(Icons.add),
      ),
    );
  }

  // Delete confirmation dialog
  void _confirmDelete(BuildContext context, String reportId) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Report'),
        content: const Text('Are you sure you want to delete this report?'),
        actions: [
          TextButton(
            onPressed: () async {
              await FirebaseFirestore.instance.collection('reports').doc(reportId).delete();
              Navigator.of(context).pop(); // Close dialog
            },
            child: const Text('Yes'),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(), // Close dialog
            child: const Text('No'),
          ),
        ],
      ),
    );
  }
}
