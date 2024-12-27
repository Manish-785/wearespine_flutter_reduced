import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/patient_provider.dart';

class MedicalExaminationScreen extends StatefulWidget {
  const MedicalExaminationScreen({Key? key}) : super(key: key);

  @override
  _MedicalExaminationScreenState createState() =>
      _MedicalExaminationScreenState();
}

class _MedicalExaminationScreenState extends State<MedicalExaminationScreen> {
  // Gait Section
  String? gaitPattern;
  Map<String, String?> heelToeWalking = {
    'right_toe': null as String?,
    'left_toe': null as String?,
    'right_heel': null as String?,
    'left_heel': null as String?,
  };
  String? tandemWalk;

  // Range of Motion Section
  Map<String, dynamic> rangeOfMotion = {
    'back': {'movements': <String>[], 'pain': null as String?},
    'neck': {'movements': <String>[], 'pain': null as String?},
  };

  // Provocative Test Section
  Map<String, dynamic> provocativeTest = {
    'straight_leg_raising': {
      'active': {'right': null as String?, 'left': null as String?},
      'passive': {'right': null as String?, 'left': null as String?},
    },
    'additional_tests': {
      'spurlings': null as String?,
    },
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Medical Examination Form')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            // Gait Section
            _buildSectionTitle("Gait (Walking Pattern)"),
            Image.asset('lib/assets/Gait.png',
                fit: BoxFit.cover, width: double.infinity),
            _buildRadio(
                "What is your walking pattern?",
                [
                  "Normal",
                  "Antalgic",
                  "Lurching",
                  "Crouched",
                  "Listed on one side",
                  "High steppage gait",
                  "Assisted gait (With a walker or with a stick)"
                ],
                gaitPattern, (value) {
              setState(() {
                gaitPattern = value;
              });
            }),

            // Heel Toe Walking
            _buildSectionTitle("Heel Toe Walking"),
            Image.asset('lib/assets/walking-technique-hip-1.jpeg',
                fit: BoxFit.cover, width: double.infinity),
            _buildRadio("Can you walk on right toe?", ["Yes", "No"],
                heelToeWalking['right_toe'], (value) {
              setState(() {
                heelToeWalking['right_toe'] = value;
              });
            }),
            _buildRadio("Can you walk on left toe?", ["Yes", "No"],
                heelToeWalking['left_toe'], (value) {
              setState(() {
                heelToeWalking['left_toe'] = value;
              });
            }),
            _buildRadio("Can you walk on right heel?", ["Yes", "No"],
                heelToeWalking['right_heel'], (value) {
              setState(() {
                heelToeWalking['right_heel'] = value;
              });
            }),
            _buildRadio("Can you walk on left heel?", ["Yes", "No"],
                heelToeWalking['left_heel'], (value) {
              setState(() {
                heelToeWalking['left_heel'] = value;
              });
            }),

            // Tandem Walk
            _buildSectionTitle("Tandem Walk (Walking in one line)"),
            Image.asset('lib/assets/tandom_walking.png',
                fit: BoxFit.cover, width: double.infinity),
            _buildRadio(
                "Can you walk in one line?",
                ["I haven't performed it Yet", "Yes", "No"],
                tandemWalk, (value) {
              setState(() {
                tandemWalk = value;
              });
            }),
            const Text(
                "*Note: Should have someone by your side or something to hold*"),

            // Range of Motion Section
            _buildSectionTitle("Range of Motion"),
            _buildSubheader("1. Neck and Back Movements"),
            Image.asset('lib/assets/back_movement.jpg',
                fit: BoxFit.cover, width: double.infinity),
            _buildMultiSelect(
                "Select back movements you are unable to perform",
                [
                  "Bending forward",
                  "Bending backwards",
                  "Bending on the side",
                  "Left twisting",
                  "Right twisting"
                ],
                rangeOfMotion['back']['movements'], (value) {
              setState(() {
                rangeOfMotion['back']['movements'] = value;
              });
            }),
            _buildRadio("Do you experience pain?", ["No Pain", "Pain Present"],
                rangeOfMotion['back']['pain'], (value) {
              setState(() {
                rangeOfMotion['back']['pain'] = value;
              });
            }),

            _buildSubheader("Neck Movements"),
            Image.asset('lib/assets/neck.webp',
                fit: BoxFit.cover, width: double.infinity),
            _buildMultiSelect(
                "Select neck movements you are unable to perform",
                [
                  "Bending forward",
                  "Bending backwards",
                  "Bending on the side",
                  "Left twisting",
                  "Right twisting"
                ],
                rangeOfMotion['neck']['movements'], (value) {
              setState(() {
                rangeOfMotion['neck']['movements'] = value;
              });
            }),
            _buildRadio("Do you experience pain?", ["No Pain", "Pain Present"],
                rangeOfMotion['neck']['pain'], (value) {
              setState(() {
                rangeOfMotion['neck']['pain'] = value;
              });
            }),

            // Provocative Test Section
            _buildSectionTitle("Provocative Test"),
            _buildSubheader("1. Straight Leg Raising Test"),
            Image.asset('lib/assets/leg_raising_test.png',
                fit: BoxFit.cover, width: double.infinity),
            _buildRadio(
                "Right Leg - Active Test",
                ["Can do without pain", "Can do with pain", "Cannot do"],
                provocativeTest['straight_leg_raising']['active']['right'],
                (value) {
              setState(() {
                provocativeTest['straight_leg_raising']['active']['right'] =
                    value;
              });
            }),
            _buildRadio(
                "Left Leg - Active Test",
                ["Can do without pain", "Can do with pain", "Cannot do"],
                provocativeTest['straight_leg_raising']['active']['left'],
                (value) {
              setState(() {
                provocativeTest['straight_leg_raising']['active']['left'] =
                    value;
              });
            }),
            _buildRadio(
                "Right Leg - Passive Test",
                ["Can be done without pain", "Limited due to pain"],
                provocativeTest['straight_leg_raising']['passive']['right'],
                (value) {
              setState(() {
                provocativeTest['straight_leg_raising']['passive']['right'] =
                    value;
              });
            }),
            _buildRadio(
                "Left Leg - Passive Test",
                ["Can be done without pain", "Limited due to pain"],
                provocativeTest['straight_leg_raising']['passive']['left'],
                (value) {
              setState(() {
                provocativeTest['straight_leg_raising']['passive']['left'] =
                    value;
              });
            }),

            _buildSubheader("2. Additional Tests"),
            Row(
              children: [
                Expanded(
                  child: Image.asset('lib/assets/spurling_test.webp',
                      fit: BoxFit.cover),
                ),
                const Expanded(
                  child: Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      "Look at one side then look up and hold there for 5 sec",
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                ),
              ],
            ),
            _buildRadio(
                "Spurlings Test",
                [
                  "Right side painful",
                  "Left side painful",
                  "No pain",
                  "Both sides painful"
                ],
                provocativeTest['additional_tests']['spurlings'], (value) {
              setState(() {
                provocativeTest['additional_tests']['spurlings'] = value;
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
                  onPressed: _saveExamination,
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
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
    );
  }

  Widget _buildSubheader(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Text(title,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
    );
  }

  Widget _buildRadio(String title, List<String> options, String? groupValue,
      ValueChanged<String?> onChanged) {
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
      List<String> currentValues, ValueChanged<List<String>> onChanged) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title),
        Wrap(
          spacing: 8.0,
          children: options.map((option) {
            return FilterChip(
              label: Text(option),
              selected: currentValues.contains(option),
              onSelected: (selected) {
                setState(() {
                  if (selected) {
                    currentValues.add(option);
                  } else {
                    currentValues.remove(option);
                  }
                  onChanged(currentValues);
                });
              },
            );
          }).toList(),
        ),
      ],
    );
  }

  void _saveExamination() {
    // Compile all collected information
    final examinationData = {
      "Gait Pattern": gaitPattern,
      "Heel Toe Walking": heelToeWalking,
      "Tandem Walk": tandemWalk,
      "Range of Motion": rangeOfMotion,
      "Provocative Test": provocativeTest,
    };

    // Save the data to the provider or session state
    Provider.of<PatientProvider>(context, listen: false)
        .saveMedicalExamination(examinationData);

    // Navigate to the next screen
    Navigator.pushNamed(context, '/compensation');
  }
}
