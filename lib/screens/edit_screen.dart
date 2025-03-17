import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crimetrack/app_colors.dart';
import 'package:flutter/material.dart';

class EditScreen extends StatefulWidget {
  final String reportId;
  final DocumentSnapshot reportData;

  const EditScreen({Key? key, required this.reportId, required this.reportData}) : super(key: key);

  @override
  _EditScreenState createState() => _EditScreenState();
}

class _EditScreenState extends State<EditScreen> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _titleController;
  late TextEditingController _locationController;
  late TextEditingController _descriptionController;
  late TextEditingController _incidentDateController;
  String? _crimeType;
  DateTime? _incidentDate;

  final List<String> _crimeTypes = ['Theft', 'Assault', 'Vandalism', 'Robbery', 'Fraud'];

  @override
  void initState() {
    super.initState();
    // Initialize controllers with existing report data
    _titleController = TextEditingController(text: widget.reportData['title']);
    _locationController = TextEditingController(text: widget.reportData['location']);
    _descriptionController = TextEditingController(text: widget.reportData['description']);
    _incidentDateController = TextEditingController(text: widget.reportData['incidentDate']);
    _crimeType = widget.reportData['crimeType'];
  }

  @override
  void dispose() {
    _titleController.dispose();
    _locationController.dispose();
    _descriptionController.dispose();
    _incidentDateController.dispose();
    super.dispose();
  }

  Future<void> _updateReport() async {
    if (!_formKey.currentState!.validate()) return;

    try {
      await FirebaseFirestore.instance.collection('reports').doc(widget.reportId).update({
        'title': _titleController.text,
        'crimeType': _crimeType,
        'location': _locationController.text,
        'incidentDate': _incidentDateController.text,
        'description': _descriptionController.text,
        'updatedAt': FieldValue.serverTimestamp(),
      });

      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Report updated successfully")));
      Navigator.pop(context); // Go back after update
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Error updating report: $e")));
    }
  }

  // Method to show date picker
  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != _incidentDate) {
      setState(() {
        _incidentDate = picked;
        _incidentDateController.text = '${_incidentDate!.toLocal()}'.split(' ')[0]; // Format as 'yyyy-MM-dd'
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primaryColor,
        title: const Text("Edit Report"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: _titleController,
                decoration: const InputDecoration(labelText: "Incident Title"),
                validator: (value) => value!.isEmpty ? 'Please enter a title' : null,
              ),
              const SizedBox(height: 16),

              DropdownButtonFormField<String>(
                decoration: const InputDecoration(labelText: "Crime Type"),
                value: _crimeType,
                onChanged: (value) => setState(() => _crimeType = value),
                items: _crimeTypes
                    .map((crime) => DropdownMenuItem(value: crime, child: Text(crime)))
                    .toList(),
                validator: (value) => value == null ? 'Please select a crime type' : null,
              ),
              const SizedBox(height: 16),

              TextFormField(
                controller: _locationController,
                decoration: const InputDecoration(labelText: "Location"),
                validator: (value) => value!.isEmpty ? 'Please enter a location' : null,
              ),
              const SizedBox(height: 16),

              TextFormField(
                controller: _incidentDateController,
                readOnly: true,
                onTap: () {
                  FocusScope.of(context).requestFocus(FocusNode());
                  _selectDate(context);
                },
                decoration: const InputDecoration(labelText: "Incident Date"),
                validator: (value) => value!.isEmpty ? 'Please select a date' : null,
              ),
              const SizedBox(height: 16),

              TextFormField(
                controller: _descriptionController,
                maxLines: null,
                keyboardType: TextInputType.multiline,
                decoration: const InputDecoration(labelText: "Incident Description"),
                validator: (value) => value!.isEmpty ? 'Please provide a description' : null,
              ),
              const SizedBox(height: 16),

              ElevatedButton(
                onPressed: _updateReport,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primaryColor,
                  foregroundColor: AppColors.buttonTextColor,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                ),
                child: const Text("Update Report"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
