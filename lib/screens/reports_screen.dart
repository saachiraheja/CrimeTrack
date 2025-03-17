import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crimetrack/screens/report_details_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ReportsScreen extends StatelessWidget {
  const ReportsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('reports')
            .orderBy('createdAt', descending: true) // Show reports in descending order of creation
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
              final createdAt = (report['createdAt'] as Timestamp?)?.toDate() ?? DateTime.now();
              final userId = report['userId'];
              final userName = // In case you want to fetch username, adjust here if you have user data stored
                  "Anonymous";

              return Card(
                margin: const EdgeInsets.all(8.0),
                elevation: 4,
                child: ListTile(
                  contentPadding: const EdgeInsets.all(16.0),
                  title: Text(title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  subtitle: Text('$crimeType - $location'),
                  onTap: () {
                    // Navigate to detailed report screen when tapped
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ReportDetailsScreen(
                          reportId: reportId,
                          title: title,
                          crimeType: crimeType,
                          location: location,
                          createdAt: createdAt,
                          userName: userName,
                          description: report['description'] ?? 'No Description',
                        ),
                      ),
                    );
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }
}

