import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/patient_provider.dart';
import '../providers/dropbox.dart';

class CompensationScreen extends StatefulWidget {
  const CompensationScreen({Key? key}) : super(key: key);

  @override
  _CompensationScreenState createState() => _CompensationScreenState();
}

class _CompensationScreenState extends State<CompensationScreen> {
  String? dayToDayActivities;
  String? currentStatus;
  String? socialEvents;
  List<String> treatmentExpectations = [];
  String? diagnosis;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Compensation')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            _buildSectionTitle("1. Ability to Manage Activities"),
            _buildRadio(
                "Are you able to manage your day-to-day activities properly?",
                ["Yes", "No"],
                dayToDayActivities, (value) {
              setState(() {
                dayToDayActivities = value;
              });
            }),
            _buildSectionTitle("2. Acceptability of Current Status"),
            _buildRadio("Is the status currently present acceptable to you?",
                ["Yes", "No"], currentStatus, (value) {
              setState(() {
                currentStatus = value;
              });
            }),
            _buildSectionTitle("3. Social Event Participation"),
            _buildRadio(
                "Can you attend all the social events that you want to attend?",
                ["Yes", "No"],
                socialEvents, (value) {
              setState(() {
                socialEvents = value;
              });
            }),
            _buildSectionTitle("4. Expectations from Treatment"),
            _buildMultiSelect(
                "What are the expectations of the treatment?",
                [
                  "To play sports",
                  "To be able enough to travel",
                  "To be able enough to carry on day-to-day life",
                  "To be pain-free"
                ],
                treatmentExpectations, (value) {
              setState(() {
                treatmentExpectations = value;
              });
            }),
            _buildSectionTitle("Correct Diagnosis"),
            TextField(
              decoration: const InputDecoration(
                labelText: "Please enter expected Diagnosis",
                border: OutlineInputBorder(),
              ),
              onChanged: (value) {
                diagnosis = value;
              },
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(
                  onPressed: () {
                    // Navigate to the previous page
                    Navigator.pop(context);
                  },
                  child: const Text("Previous: Differential Diagnosis"),
                ),
                ElevatedButton(
                  onPressed: () async {
                    // Save the compensation data
                    final patientProvider = Provider.of<PatientProvider>(context, listen: false);
                    patientProvider.saveCompensationData({
                      'day_to_day_activities': dayToDayActivities,
                      'current_status': currentStatus,
                      'social_events': socialEvents,
                      'treatment_expectations': treatmentExpectations,
                      'diagnosis': diagnosis,
                    });

                    // Upload data to Dropbox
                    await uploadToApi(patientProvider.patientData);

                    // Clear patient data
                    patientProvider.clearPatientData();

                    // Show success message and navigate back to patient profile
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                          content: Text(
                              "All patient details successfully saved! You can find the details in 'patient_data.json'.")),
                    );
                    Navigator.pushNamedAndRemoveUntil(context, '/personal_info', (route) => false);
                  },
                  child: const Text("Save"),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Text(title,
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
    );
  }

  Widget _buildRadio(String title, List<String> options, String? groupValue,
      Function(String?) onChanged) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title),
        ...options.map((option) {
          return RadioListTile<String>(
            title: Text(option),
            value: option,
            groupValue: groupValue,
            onChanged: onChanged,
          );
        }).toList(),
      ],
    );
  }

  Widget _buildMultiSelect(String title, List<String> options,
      List<String> selectedValues, Function(List<String>) onChanged) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: const TextStyle(fontSize: 16)),
        Wrap(
          spacing: 8.0,
          children: options.map((option) {
            return FilterChip(
              label: Text(option),
              selected: selectedValues.contains(option),
              onSelected: (selected) {
                setState(() {
                  if (selected) {
                    selectedValues.add(option);
                  } else {
                    selectedValues.remove(option);
                  }
                  onChanged(selectedValues);
                });
              },
            );
          }).toList(),
        ),
      ],
    );
  }
}
