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
    "Rheumatoid Arthritis": false,
    "Ankylosing Spondylitis": false,
    "Osteoporosis": false,
  };

  // Constitutional Symptoms
  final Map<String, bool> constitutionalSymptoms = {
    "Anorexia (Loss of appetite)": false,
    "Fever": false,
    "Generalized Weakness": false,
    "Night Pain": false,
    "Significant Weight Loss": false,
  };

  // Trauma History
  final Map<String, bool> traumaHistory = {
    "Sports Injury": false,
    "Fight/Weapon Injuries": false,
    "Whiplash": false,
    "Accident": false,
    "Fall": false,
  };

  // Past History
  final Map<String, bool> procedures = {
    "SNRB (Root Block)": false,
  };

  final Map<String, bool> spineSurgeries = {
    "Spine Surgeries": false,
  };
  String otherSpineSurgeries = "";

  // Red Flag Questions
  bool bowelBladderIncontinence = false;
  bool isWeaknessInLimb = false;
  bool unbearablePain = false;

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
            _buildSectionTitle("2. Constitutional Symptoms"),
            ..._buildCheckboxList(constitutionalSymptoms),
            const Padding(
              padding: EdgeInsets.only(left: 16.0),
              child: Text(
                "Loss of 10kgs in less than equal to 3 months",
                style: TextStyle(fontSize: 14, fontStyle: FontStyle.italic),
              ),
            ),
            _buildSectionTitle("3. Trauma"),
            ..._buildCheckboxList(traumaHistory),
            _buildSectionTitle("5. Past History"),
            _buildSubheader("a. Procedures"),
            ..._buildCheckboxList(procedures),
            _buildSubheader("b. Surgeries"),
            ..._buildCheckboxList(spineSurgeries),
            _buildTextField("Other Surgeries", (value) {
              setState(() {
                otherSpineSurgeries = value!;
              });
            }),
            _buildSectionTitle("6. Red Flag Questions"),
            _buildCheckbox("Bowel and Bladder Incontinence (Loss of Control)",
                bowelBladderIncontinence, (value) {
              setState(() {
                bowelBladderIncontinence = value!;
              });
            }),
            _buildCheckbox("Is Weakness in the Limb", isWeaknessInLimb,
                (value) {
              setState(() {
                isWeaknessInLimb = value!;
              });
            }),
            _buildCheckbox("Unbearable Pain", unbearablePain, (value) {
              setState(() {
                unbearablePain = value!;
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
      "Constitutional Symptoms": constitutionalSymptoms,
      "Trauma History": traumaHistory,
      "Past Procedures": procedures,
      "Spine Surgeries": {
        "C-Spine": spineSurgeries["Spine Surgeries"],
        "Other": otherSpineSurgeries,
      },
      "Bowel/Bladder Incontinence": bowelBladderIncontinence,
      "Weakness in Limb": isWeaknessInLimb,
      "Unbearable Pain": unbearablePain,
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
