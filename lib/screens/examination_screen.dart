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
    'hip': <String>[],
    'shoulder': <String>[],
    'squat': {'can_squat': null as String?, 'pain': null as String?},
    'trendelenberg': null as String?,
  };

  // Provocative Test Section
  Map<String, dynamic> provocativeTest = {
    'straight_leg_raising': {
      'active': {'right': null as String?, 'left': null as String?},
      'passive': {'right': null as String?, 'left': null as String?},
    },
    'additional_tests': {
      'spurlings': null as String?,
      'fnst': null as String?,
    },
  };

  // Power Section
  Map<String, dynamic> power = {
    'lower_limbs': {
      'assessed_areas': <String>[],
      'foot_weakness': {'status': null as String?, 'picture': null as String?},
    },
    'upper_limbs': {
      'assessed_areas': <String>[],
      'hand_weakness': {'status': null as String?, 'picture': null as String?},
    },
  };

  // Sensory Section
  Map<String, dynamic> sensory = {
    'lower_limbs': {
      'assessed_areas': <String>[],
      'foot_sensation': {
        'status': null as String?,
        'sensation_pic': null as String?,
        'no_sensation_pic': null as String?
      },
    },
    'upper_limbs': {
      'assessed_areas': <String>[],
      'hand_sensation': {
        'status': null as String?,
        'sensation_pic': null as String?,
        'no_sensation_pic': null as String?
      },
    },
  };

  // Reflexes Section
  Map<String, String?> reflexes = {
    "Knee Reflex": null as String?,
    "Ankle Reflex": null as String?,
    "Plantar": null as String?,
    "Biceps": null as String?,
    "Triceps": null as String?,
    "Supinator": null as String?,
    "Hoffman": null as String?,
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
                "Select back movements you can perform",
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
                "Select neck movements you can perform",
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

            _buildSubheader("2. Hip Joint Movement"),
            Image.asset('lib/assets/hip_movement.png',
                fit: BoxFit.cover, width: double.infinity),
            _buildMultiSelect(
                "Select hip movements",
                [
                  "Flexion extension test",
                  "Adduction abduction",
                  "Sitting cross-legged",
                  "Internal rotation",
                  "External rotation",
                  "Faber Test"
                ],
                rangeOfMotion['hip'], (value) {
              setState(() {
                rangeOfMotion['hip'] = value;
              });
            }),

            _buildSubheader("3. Shoulder Test"),
            Image.asset('lib/assets/shoulder_test.png',
                fit: BoxFit.cover, width: double.infinity),
            _buildMultiSelect(
                "Select shoulder tests",
                ["Empty can test", "Full can test", "Horn Blowers test"],
                rangeOfMotion['shoulder'], (value) {
              setState(() {
                rangeOfMotion['shoulder'] = value;
              });
            }),

            _buildSubheader("4. Partial Squat"),
            _buildRadio("Can you do a partial squat?", ["Yes", "No"],
                rangeOfMotion['squat']['can_squat'], (value) {
              setState(() {
                rangeOfMotion['squat']['can_squat'] = value;
              });
            }),
            if (rangeOfMotion['squat']['can_squat'] == "Yes")
              _buildRadio("Is there pain?", ["Yes", "No"],
                  rangeOfMotion['squat']['pain'], (value) {
                setState(() {
                  rangeOfMotion['squat']['pain'] = value;
                });
              }),

            _buildSubheader("5. Trendelenberg Test"),
            Image.asset('lib/assets/trendlenburg.jpeg',
                fit: BoxFit.cover, width: double.infinity),
            _buildRadio(
                "Which leg standing is difficult?",
                [
                  "Standing on right leg difficult/not possible",
                  "Standing on left leg difficult/not possible",
                  "Neither side possible",
                  "Can do easily"
                ],
                rangeOfMotion['trendelenberg'], (value) {
              setState(() {
                rangeOfMotion['trendelenberg'] = value;
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
            Image.asset('lib/assets/spurling_test.webp',
                fit: BoxFit.cover, width: double.infinity),
            _buildRadio("Spurlings Test", ["Positive", "Negative"],
                provocativeTest['additional_tests']['spurlings'], (value) {
              setState(() {
                provocativeTest['additional_tests']['spurlings'] = value;
              });
            }),
            Image.asset('lib/assets/fnst_test.jpg',
                fit: BoxFit.cover, width: double.infinity),
            _buildRadio("Femoral Nerve Stretch Test", ["Positive", "Negative"],
                provocativeTest['additional_tests']['fnst'], (value) {
              setState(() {
                provocativeTest['additional_tests']['fnst'] = value;
              });
            }),

            // Power Section
            _buildSectionTitle("Power Test"),
            _buildSubheader("1. Lower Limbs Power"),
            _buildMultiSelect(
                "Select areas with power assessment",
                ["Hip", "Knee", "Ankle", "Foot"],
                power['lower_limbs']['assessed_areas'], (value) {
              setState(() {
                power['lower_limbs']['assessed_areas'] = value;
              });
            }),
            if (power['lower_limbs']['assessed_areas'].contains("Foot"))
              _buildRadio("Foot Weakness", ["All okay", "Weakness Present"],
                  power['lower_limbs']['foot_weakness']['status'], (value) {
                setState(() {
                  power['lower_limbs']['foot_weakness']['status'] = value;
                });
              }),
            if (power['lower_limbs']['foot_weakness']['status'] ==
                "Weakness Present")
              _buildRadio("Which Picture", ["I", "II", "III", "IV"],
                  power['lower_limbs']['foot_weakness']['picture'], (value) {
                setState(() {
                  power['lower_limbs']['foot_weakness']['picture'] = value;
                });
              }),

            _buildSubheader("2. Upper Limbs Power"),
            _buildMultiSelect(
                "Select areas with power assessment",
                ["Shoulder", "Elbow", "Wrist", "Hand/Fingers"],
                power['upper_limbs']['assessed_areas'], (value) {
              setState(() {
                power['upper_limbs']['assessed_areas'] = value;
              });
            }),
            if (power['upper_limbs']['assessed_areas'].contains("Hand/Fingers"))
              _buildRadio(
                  "Hand/Fingers Weakness",
                  ["All okay", "Weakness Present"],
                  power['upper_limbs']['hand_weakness']['status'], (value) {
                setState(() {
                  power['upper_limbs']['hand_weakness']['status'] = value;
                });
              }),
            if (power['upper_limbs']['hand_weakness']['status'] ==
                "Weakness Present")
              _buildRadio("Which Picture", ["I", "II", "III", "IV"],
                  power['upper_limbs']['hand_weakness']['picture'], (value) {
                setState(() {
                  power['upper_limbs']['hand_weakness']['picture'] = value;
                });
              }),

            // Sensory Section
            _buildSectionTitle("Sensory Examination"),
            _buildSubheader("1. Lower Limbs Sensory"),
            _buildMultiSelect(
                "Select areas for sensory assessment",
                ["Hip", "Knee", "Ankle", "Foot"],
                sensory['lower_limbs']['assessed_areas'], (value) {
              setState(() {
                sensory['lower_limbs']['assessed_areas'] = value;
              });
            }),
            _buildRadio(
                "Foot Sensation",
                ["All okay", "Different sensation Present", "No sensation"],
                sensory['lower_limbs']['foot_sensation']['status'], (value) {
              setState(() {
                sensory['lower_limbs']['foot_sensation']['status'] = value;
              });
            }),
            if (sensory['lower_limbs']['foot_sensation']['status'] ==
                "Different sensation Present")
              _buildRadio("Which Picture", ["I", "II", "III", "IV"],
                  sensory['lower_limbs']['foot_sensation']['sensation_pic'],
                  (value) {
                setState(() {
                  sensory['lower_limbs']['foot_sensation']['sensation_pic'] =
                      value;
                });
              }),
            if (sensory['lower_limbs']['foot_sensation']['status'] ==
                "No sensation")
              _buildRadio("Which Picture", ["I", "II", "III", "IV"],
                  sensory['lower_limbs']['foot_sensation']['no_sensation_pic'],
                  (value) {
                setState(() {
                  sensory['lower_limbs']['foot_sensation']['no_sensation_pic'] =
                      value;
                });
              }),

            _buildSubheader("2. Upper Limbs Sensory"),
            _buildMultiSelect(
                "Select areas for sensory assessment",
                ["Shoulder", "Elbow", "Wrist", "Hand/Fingers"],
                sensory['upper_limbs']['assessed_areas'], (value) {
              setState(() {
                sensory['upper_limbs']['assessed_areas'] = value;
              });
            }),
            _buildRadio(
                "Hand/Fingers Sensation",
                ["All okay", "Different sensation Present", "No sensation"],
                sensory['upper_limbs']['hand_sensation']['status'], (value) {
              setState(() {
                sensory['upper_limbs']['hand_sensation']['status'] = value;
              });
            }),
            if (sensory['upper_limbs']['hand_sensation']['status'] ==
                "Different sensation Present")
              _buildRadio("Which Picture", ["I", "II", "III", "IV"],
                  sensory['upper_limbs']['hand_sensation']['sensation_pic'],
                  (value) {
                setState(() {
                  sensory['upper_limbs']['hand_sensation']['sensation_pic'] =
                      value;
                });
              }),
            if (sensory['upper_limbs']['hand_sensation']['status'] ==
                "No sensation")
              _buildRadio("Which Picture", ["I", "II", "III", "IV"],
                  sensory['upper_limbs']['hand_sensation']['no_sensation_pic'],
                  (value) {
                setState(() {
                  sensory['upper_limbs']['hand_sensation']['no_sensation_pic'] =
                      value;
                });
              }),

            // Reflexes Section
            _buildSectionTitle("Reflexes Examination"),
            ...reflexes.keys.map((test) {
              return _buildRadio(
                  "$test Reflex",
                  ["Normal", "Hyperactive", "Hypoactive", "Absent"],
                  reflexes[test], (value) {
                setState(() {
                  reflexes[test] = value;
                });
              });
            }).toList(),

            // Navigation Buttons
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(
                  onPressed: () {
                    // Navigate to the previous page
                    Navigator.pop(context);
                  },
                  child: const Text("Previous"),
                ),
                ElevatedButton(
                  onPressed: () {
                    // Save the medical examination data
                    Provider.of<PatientProvider>(context, listen: false)
                        .saveMedicalExamination({
                      'gait': {
                        'walking_pattern': gaitPattern,
                        'heel_toe': heelToeWalking,
                        'tandem_walk': tandemWalk,
                      },
                      'range_of_motion': rangeOfMotion,
                      'provocative_test': provocativeTest,
                      'power': power,
                      'sensory': sensory,
                      'reflexes': reflexes,
                    });
                    // Navigate to the differential diagnosis page
                    Navigator.pushNamed(context, '/differential_diagnosis');
                  },
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
}
