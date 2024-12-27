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
  final heightController = TextEditingController();
  final weightController = TextEditingController();
  final mobileController = TextEditingController();
  final emailController = TextEditingController();
  final addressController = TextEditingController();

  String? gender;
  bool isSelf = true;
  bool isAthlete = false;
  DateTime? dob;

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

              // Date of Birth or Age
              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: ageController,
                      decoration: const InputDecoration(labelText: 'Age'),
                      keyboardType: TextInputType.number,
                      validator: (value) =>
                          value!.isEmpty ? 'Please enter age' : null,
                    ),
                  ),
                  const SizedBox(width: 16),
                  ElevatedButton(
                    onPressed: () async {
                      final pickedDate = await showDatePicker(
                        context: context,
                        initialDate: dob ?? DateTime.now(),
                        firstDate: DateTime(1900),
                        lastDate: DateTime.now(),
                      );
                      if (pickedDate != null && pickedDate != dob) {
                        setState(() {
                          dob = pickedDate;
                          ageController.text =
                              ((DateTime.now().difference(dob!).inDays) ~/ 365)
                                  .toString();
                        });
                      }
                    },
                    child: const Text('Select Date of Birth'),
                  ),
                ],
              ),

              // Gender Selection
              DropdownButtonFormField<String>(
                decoration: const InputDecoration(labelText: 'Gender'),
                value: gender,
                items: [
                  'Select',
                  'Male',
                  'Female',
                  'Non-Binary',
                  'Prefer Not to Say'
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
              TextFormField(
                controller: emailController,
                decoration: const InputDecoration(labelText: 'Email Address'),
                keyboardType: TextInputType.emailAddress,
                validator: (value) =>
                    value!.isEmpty ? 'Please enter an email address' : null,
              ),
              TextFormField(
                controller: addressController,
                decoration: const InputDecoration(labelText: 'Address'),
                keyboardType: TextInputType.streetAddress,
              ),

              // Height and Weight
              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: heightController,
                      decoration:
                          const InputDecoration(labelText: 'Height (cm)'),
                      keyboardType: TextInputType.number,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: TextFormField(
                      controller: weightController,
                      decoration:
                          const InputDecoration(labelText: 'Weight (kg)'),
                      keyboardType: TextInputType.number,
                    ),
                  ),
                ],
              ),

              // Occupation
              TextFormField(
                controller: occupationController,
                decoration: const InputDecoration(labelText: 'Occupation'),
              ),

              // Athlete Status
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    const Text(
                        'Are you an athlete or involved in professional sports?'),
                    Checkbox(
                      value: isAthlete,
                      onChanged: (value) => setState(() => isAthlete = value!),
                    ),
                  ],
                ),
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
        'dob': dob,
        'gender': gender,
        'occupation': occupationController.text,
        'is_self': isSelf,
        'is_athlete': isAthlete,
        'mobile': mobileController.text,
        'email': emailController.text,
        'address': addressController.text,
        'height': double.tryParse(heightController.text) ?? 0.0,
        'weight': double.tryParse(weightController.text) ?? 0.0,
      };

      // Update state in provider
      Provider.of<PatientProvider>(context, listen: false)
          .updatePersonalInfo(personalInfo);

      // Navigate to next screen
      Navigator.pushNamed(context, '/general_condition');
    }
  }
}
