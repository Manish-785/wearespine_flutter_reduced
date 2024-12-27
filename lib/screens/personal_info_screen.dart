import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/patient_provider.dart';

class PersonalInfoScreen extends StatefulWidget {
  const PersonalInfoScreen({super.key});

  @override
  _PersonalInfoScreenState createState() => _PersonalInfoScreenState();
}

class _PersonalInfoScreenState extends State<PersonalInfoScreen> {
  final _formKey = GlobalKey<FormState>();

  // Controllers for text fields
  final nameController = TextEditingController();
  final ageController = TextEditingController();
  final occupationController = TextEditingController();
  final mobileController = TextEditingController();

  String? gender;
  bool isSelf = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Personal Information')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              // Form Type Selection
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const Text('Are you filling this form for:'),
                    Radio(
                      value: true,
                      groupValue: isSelf,
                      onChanged: (value) => setState(() => isSelf = true),
                    ),
                    const Text('Yourself'),
                    Radio(
                      value: false,
                      groupValue: isSelf,
                      onChanged: (value) => setState(() => isSelf = false),
                    ),
                    const Text('Someone Else'),
                  ],
                ),
              ),

              // Personal Details Section
              const Text('Personal Details',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              TextFormField(
                controller: nameController,
                decoration: const InputDecoration(labelText: "Full Name"),
                validator: (value) =>
                    value!.isEmpty ? 'Please enter name' : null,
              ),

              // Age
              TextFormField(
                controller: ageController,
                decoration: const InputDecoration(labelText: 'Age'),
                keyboardType: TextInputType.number,
                validator: (value) =>
                    value!.isEmpty ? 'Please enter age' : null,
              ),

              // Gender Selection
              DropdownButtonFormField<String>(
                decoration: const InputDecoration(labelText: 'Gender'),
                value: gender,
                items: [
                  'Select',
                  'Male',
                  'Female',
                ]
                    .map((label) => DropdownMenuItem(
                          child: Text(label),
                          value: label,
                        ))
                    .toList(),
                onChanged: (value) => setState(() => gender = value),
                validator: (value) =>
                    value == 'Select' ? 'Please select gender' : null,
              ),

              // Contact Details
              TextFormField(
                controller: mobileController,
                decoration: const InputDecoration(labelText: 'Mobile Number'),
                keyboardType: TextInputType.phone,
                validator: (value) =>
                    value!.isEmpty ? 'Please enter a mobile number' : null,
              ),

              // Occupation
              TextFormField(
                controller: occupationController,
                decoration: const InputDecoration(labelText: 'Occupation'),
              ),

              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _submitForm,
                child: const Text('Next: General Condition'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      final personalInfo = {
        'name': nameController.text,
        'age': int.tryParse(ageController.text) ?? 0,
        'gender': gender,
        'occupation': occupationController.text,
        'is_self': isSelf,
        'mobile': mobileController.text,
      };

      // Update state in provider
      Provider.of<PatientProvider>(context, listen: false)
          .updatePersonalInfo(personalInfo);

      // Navigate to next screen
      Navigator.pushNamed(context, '/general_condition');
    }
  }
}
