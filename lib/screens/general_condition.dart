import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/patient_provider.dart';

class GeneralConditionScreen extends StatefulWidget {
  const GeneralConditionScreen({Key? key}) : super(key: key);

  @override
  _GeneralConditionScreenState createState() => _GeneralConditionScreenState();
}

class _GeneralConditionScreenState extends State<GeneralConditionScreen> {
  // Co-Morbid Conditions
  final Map<String, bool> coMorbidConditions = {
    "Diabetes": false,
    "Stroke": false,
    "Ischemic Heart Disease": false,
    "Thyroid": false,
    "Arthritis": false,
    "Seronegative Spondyloarthropathy": false,
    "Ankylosing Spondylitis": false,
    "Osteoporosis": false,
    "Chronic Obstructive Pulmonary Disease": false,
    "Carpal Tunnel Syndrome": false,
  };

  // Others in Co-Morbid Conditions
  String smoking = "No";
  String alcohol = "No";
  String addictions = "";

  // Constitutional Symptoms
  final Map<String, bool> constitutionalSymptoms = {
    "Significant Weight Loss": false,
    "Anorexia": false,
    "Fever": false,
    "Generalized Weakness": false,
    "Night Pain": false,
  };

  // Trauma History
  final Map<String, bool> traumaHistory = {
    "Sports Injury": false,
    "Fight/Weapon Injuries": false,
    "Whiplash": false,
    "Accident": false,
    "Fall": false,
  };

  // History of Medications
  final Map<String, bool> medicationHistory = {
    "Cancer": false,
    "Osteoporosis": false,
    "Steroids": false,
    "Arthritis": false,
  };

  // Past History
  final Map<String, bool> procedures = {
    "SNRB": false,
    "RFA": false,
    "Facet Cyst Ruptures": false,
  };

  final Map<String, bool> spineSurgeries = {
    "C-Spine": false,
    "L-Spine": false,
  };
  String otherSpineSurgeries = "";

  // Red Flag Questions
  bool bowelBladderIncontinence = false;
  final Map<String, bool> psychologicalStatus = {
    "Anxiety": false,
    "Depression": false,
    "Insomnia": false,
  };

  final Map<String, String> redFlags = {
    "Limb Movement": "No",
    "Severe Pain": "No",
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Patient General Condition Assessment')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            _buildSectionTitle("1. Co-Morbid Conditions"),
            ..._buildCheckboxList(coMorbidConditions),
            _buildSubheader("Others"),
            _buildDropdown("Smoking", ["No", "Occasional", "Regular"], smoking,
                (value) {
              setState(() {
                smoking = value!;
              });
            }),
            _buildDropdown("Alcohol", ["No", "Occasional", "Regular"], alcohol,
                (value) {
              setState(() {
                alcohol = value!;
              });
            }),
            _buildTextField("Other Addictions", (value) {
              setState(() {
                addictions = value!;
              });
            }),
            _buildSectionTitle("2. Constitutional Symptoms"),
            ..._buildCheckboxList(constitutionalSymptoms),
            _buildSectionTitle("3. Trauma"),
            ..._buildCheckboxList(traumaHistory),
            _buildSectionTitle("4. History of Medications"),
            ..._buildCheckboxList(medicationHistory),
            _buildSectionTitle("5. Past History"),
            _buildSubheader("a. Procedures"),
            ..._buildCheckboxList(procedures),
            _buildSubheader("b. Surgeries"),
            ..._buildCheckboxList(spineSurgeries),
            _buildTextField("Other Spine Surgeries", (value) {
              setState(() {
                otherSpineSurgeries = value!;
              });
            }),
            _buildSectionTitle("6. Red Flag Questions"),
            _buildCheckbox(
                "Bowel and Bladder Incontinence", bowelBladderIncontinence,
                (value) {
              setState(() {
                bowelBladderIncontinence = value!;
              });
            }),
            _buildSectionTitle("a. Psychological Status"),
            ..._buildCheckboxList(psychologicalStatus),
            _buildSectionTitle("b. Additional Red Flags"),
            _buildDropdown(
                "Limb Movement", ["No", "Yes"], redFlags["Limb Movement"]!,
                (value) {
              setState(() {
                redFlags["Limb Movement"] = value!;
              });
            }),
            _buildDropdown("Severe Pain", ["No", "Mild", "Moderate", "Severe"],
                redFlags["Severe Pain"]!, (value) {
              setState(() {
                redFlags["Severe Pain"] = value!;
              });
            }),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context); // Navigate to the previous screen
                  },
                  child: const Text("Back"),
                ),
                ElevatedButton(
                  onPressed: _saveGeneralCondition,
                  child: const Text("Continue"),
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
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
    );
  }

  Widget _buildSubheader(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Text(title,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
    );
  }

  List<Widget> _buildCheckboxList(Map<String, bool> items) {
    return items.entries.map((entry) {
      return CheckboxListTile(
        title: Text(entry.key),
        value: entry.value,
        onChanged: (value) {
          setState(() {
            items[entry.key] = value!;
          });
        },
      );
    }).toList();
  }

  Widget _buildDropdown(String label, List<String> options, String currentValue,
      ValueChanged<String?> onChanged) {
    return DropdownButtonFormField<String>(
      decoration: InputDecoration(labelText: label),
      value: currentValue,
      items: options.map((String option) {
        return DropdownMenuItem<String>(
          value: option,
          child: Text(option),
        );
      }).toList(),
      onChanged: onChanged,
    );
  }

  Widget _buildTextField(String label, ValueChanged<String?> onChanged) {
    return TextFormField(
      decoration: InputDecoration(labelText: label),
      onChanged: onChanged,
    );
  }

  void _saveGeneralCondition() {
    // Compile all collected information
    final generalConditionData = {
      "Co-Morbid Conditions": coMorbidConditions,
      "Others": {
        "Smoking": smoking,
        "Alcohol": alcohol,
        "Addictions": addictions,
      },
      "Constitutional Symptoms": constitutionalSymptoms,
      "Trauma History": traumaHistory,
      "Medication History": medicationHistory,
      "Past Procedures": procedures,
      "Spine Surgeries": {
        "C-Spine": spineSurgeries["C-Spine"],
        "L-Spine": spineSurgeries["L-Spine"],
        "Other": otherSpineSurgeries,
      },
      "Bowel/Bladder Incontinence": bowelBladderIncontinence,
      "Psychological Status": psychologicalStatus,
      "Red Flags": redFlags,
    };

    // Save the data to the provider or session state
    Provider.of<PatientProvider>(context, listen: false)
        .updateGeneralCondition(generalConditionData);

    // Navigate to the next screen
    Navigator.pushNamed(context, '/medical_history');
  }

  Widget _buildCheckbox(
      String title, bool currentValue, ValueChanged<bool?> onChanged) {
    return CheckboxListTile(
      title: Text(title),
      value: currentValue,
      onChanged: onChanged,
    );
  }
}
