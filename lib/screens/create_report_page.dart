import 'package:crimetrack/screens/login_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class CreateReportPage extends StatefulWidget {
  @override
  _CreateReportPageState createState() => _CreateReportPageState();
}

class _CreateReportPageState extends State<CreateReportPage> {
  final _formKey = GlobalKey<FormState>();
  String? _crimeType;
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _locationController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _incidentDateController = TextEditingController();
  DateTime? _incidentDate;

  final List<String> _crimeTypes = ['Theft', 'Assault', 'Vandalism', 'Robbery', 'Fraud'];

  // Check if user is authenticated
  void _checkUserAuth() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => LoginScreen()),
      );
    }
  }

  @override
  void initState() {
    super.initState();
    _checkUserAuth(); // Ensure user is logged in
  }

  @override
  void dispose() {
    _titleController.dispose();
    _locationController.dispose();
    _descriptionController.dispose();
    _incidentDateController.dispose();
    super.dispose();
  }

  Future<void> _saveReport() async {
    final user = FirebaseAuth.instance.currentUser;

    if (user == null) {
      print("❌ User not logged in");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("You must be logged in to create a report")),
      );
      return;
    }

    if (_titleController.text.isEmpty ||
        _crimeType == null ||
        _locationController.text.isEmpty ||
        _incidentDateController.text.isEmpty ||
        _descriptionController.text.isEmpty) {
      print("❌ Validation failed: Missing fields");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Please fill in all fields before submitting")),
      );
      return;
    }

    final reportData = {
      'title': _titleController.text,
      'crimeType': _crimeType,
      'location': _locationController.text,
      'incidentDate': _incidentDateController.text,
      'description': _descriptionController.text,
      'userId': user.uid,
      'createdAt': FieldValue.serverTimestamp(),
    };

    try {
      DocumentReference docRef =
      await FirebaseFirestore.instance.collection('reports').add(reportData);
      print("✅ Report saved successfully! Document ID: ${docRef.id}");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Report Created Successfully")),
      );

      // Clear fields after submission
      _titleController.clear();
      _locationController.clear();
      _descriptionController.clear();
      _incidentDateController.clear();
      setState(() {
        _crimeType = null;
        _incidentDate = null;
      });
    } catch (e) {
      print("❌ Firestore Error: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error creating report: $e")),
      );
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text("Create Report"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: _titleController,
                decoration: InputDecoration(labelText: "Incident Title"),
                validator: (value) => value!.isEmpty ? 'Please enter a title' : null,
              ),
              SizedBox(height: 16),

              DropdownButtonFormField<String>(
                decoration: InputDecoration(labelText: "Crime Type"),
                value: _crimeType,
                onChanged: (value) {
                  setState(() {
                    _crimeType = value;
                  });
                },
                items: _crimeTypes
                    .map((crime) => DropdownMenuItem<String>(
                  value: crime,
                  child: Text(crime),
                ))
                    .toList(),
                validator: (value) => value == null ? 'Please select a crime type' : null,
              ),
              SizedBox(height: 16),

              TextFormField(
                controller: _locationController,
                decoration: InputDecoration(labelText: "Location"),
                validator: (value) => value!.isEmpty ? 'Please enter a location' : null,
              ),
              SizedBox(height: 16),

              TextFormField(
                controller: _incidentDateController,
                readOnly: true,
                onTap: () => _selectDate(context),
                decoration: InputDecoration(labelText: "Incident Date"),
                validator: (value) => _incidentDate == null ? 'Please select a date' : null,
              ),
              SizedBox(height: 16),

              TextFormField(
                controller: _descriptionController,
                maxLines: null,
                keyboardType: TextInputType.multiline,
                decoration: InputDecoration(labelText: "Incident Description"),
                validator: (value) => value!.isEmpty ? 'Please provide a description' : null,
              ),
              SizedBox(height: 16),

              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _saveReport();
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  foregroundColor: Colors.white,
                  padding: EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                ),
                child: Text("Submit Report"),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null) {
      setState(() {
        _incidentDate = picked;
        _incidentDateController.text = '${_incidentDate!.toLocal()}'.split(' ')[0];
      });
    }
  }
}
