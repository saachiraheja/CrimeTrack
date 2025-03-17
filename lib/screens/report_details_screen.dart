import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crimetrack/app_colors.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';


class ReportDetailsScreen extends StatelessWidget {
  final String reportId;
  final String title;
  final String crimeType;
  final String location;
  final DateTime createdAt;
  final String userName;
  final String description;

  const ReportDetailsScreen({
    Key? key,
    required this.reportId,
    required this.title,
    required this.crimeType,
    required this.location,
    required this.createdAt,
    required this.userName,
    required this.description,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Report Details'),
        backgroundColor: AppColors.primaryColor,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Report Title
            Text(
              title,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8.0),

            // Crime Type and Location
            Text(
              '$crimeType - $location',
              style: const TextStyle(fontSize: 18, fontStyle: FontStyle.italic),
            ),
            const SizedBox(height: 16.0),

            // Report Created At
            Text(
              'Created at: ${createdAt.toLocal().toString().split(' ')[0]}',
              style: const TextStyle(fontSize: 16, color: Colors.grey),
            ),
            const SizedBox(height: 8.0),

            // User Name
            Text(
              'Reported by: $userName',
              style: const TextStyle(fontSize: 16, fontStyle: FontStyle.italic),
            ),
            const SizedBox(height: 16.0),

            // Description
            Text(
              'Description:',
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8.0),
            Text(description),
          ],
        ),
      ),
    );
  }
}
