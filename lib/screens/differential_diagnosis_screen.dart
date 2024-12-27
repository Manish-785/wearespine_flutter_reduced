import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/patient_provider.dart';

class DifferentialDiagnosisScreen extends StatefulWidget {
  const DifferentialDiagnosisScreen({Key? key}) : super(key: key);

  @override
  _DifferentialDiagnosisScreenState createState() =>
      _DifferentialDiagnosisScreenState();
}

class _DifferentialDiagnosisScreenState
    extends State<DifferentialDiagnosisScreen> {
  final Map<String, Map<String, String?>> _answers = {};

  final Map<String, List<String>> _sections = {
    "RSD / CRPS": ["Do you feel excess redness/heat/swelling or sweating?"],
    "OA Knee": [
      "Is there pain while walking up the stairs?",
      "Is there a cracking sound while bending the knees?"
    ],
    "OA Hip": [
      "Is there a pain while sitting cross-legged?",
      "Is there a pain while walking on heels?"
    ],
    "Vascular Claudication": [
      "Is there blackening of skin of toes or foot?",
      "Does the pain relieve on standing for some time after walking?",
      "Does the pain take a lot of time to relieve even after resting?",
      "Pain does not relieve on bending forward",
      "Cramp in the legs"
    ],
    "Meralgia Paresthetica": [
      "Pain in front and side of thigh?",
      "History of weight Gain?",
      "History of wearing tight belts/pants or shorts"
    ],
    "Cheralgia Paresthetica": [
      "Pain in wrist and hand?",
      "History of weight Gain?",
      "History of wearing tight watches or wrist bands or hand cuffs"
    ],
    "Varicose Veins": [
      "Inflated Veins or prominent veins on the legs",
      "Ulcers on the foot or legs"
    ],
    "Frozen Shoulders": [
      "Limited movement of the Shoulder",
      "Pain or difficulty while combing the hairs",
      "History of uncontrolled diabetes"
    ],
    "Rotator Cuff tear": [
      "Inability to lift heavy things",
      "Inability to do overhead activities",
      "Empty Can and full can test positive"
    ],
    "Carpal tunnel Syndrome": [
      "Hand and finger numbness",
      "Pain in the hand at night",
      "Pain on joining the hands"
    ],
    "Tennis Elbow": [
      "Pain on screwing and unscrewing motion of the hand",
      "History of playing racket sports",
      "Pain on pressing elbow on outer side and one inch distal to it"
    ],
    "Thoracic Outlet Syndrome": [
      "Arm and Hand pain",
      "More Pain on standing in military position",
      "History of cervical ribs",
      "Loss of pulse of hand on raising the hand"
    ],
    "Knee Ligament Injuries": [
      "Locking of the knee",
      "Springy feeling in the knee",
      "Give way while standing",
      "Kneecap dislocation"
    ],
    "IT Band Syndrome": [
      "Pain on the outer side of the thigh",
      "Pain aggravated on cycling movement of the leg",
      "Snapping sound while cycling movement of the knee"
    ],
    "Inflammatory Conditions": [
      "Multiple joint pain",
      "Whole body pain",
      "Stiffness of the body in the morning",
      "History of viral infection"
    ],
    "Planter Fasciitis": [
      "Pain on the inner side of the heel",
      "Pain aggravated by walking",
      "History of weight gain",
      "History of injury to the heel"
    ],
    "Superior center problem": [
      "Double Vision / Blurring of vision",
      "Altered speech",
      "Incoordination of movements",
      "History of multiple headaches",
      "History of multiple fall downs"
    ],
    "Myocardial Infarction/ Heart attack": [
      "Pain in the left arm and hand",
      "Pain in the left side of the jaw",
      "Tightness or constricting pain in the chest",
      "Palpitation (Feeling the heartbeats)",
      "Feeling of Doom"
    ],
    "Renounds syndrome": [
      "Discoloration of fingers",
      "Pain in fingers with change in temperatures",
      "Female patients"
    ],
    "Thromboangitis Obliteranse": [
      "Blackening of fingers/toes",
      "Pain in hands/foot",
      "History of smoking/tobacco chewing"
    ],
    "First CMC Joint Art": [
      "Pain in the base of the thumbs",
      "Grind Test Positive",
      "Female Patients"
    ],
  };

  @override
  void initState() {
    super.initState();
    // Initialize answers
    for (var condition in _sections.keys) {
      _answers[condition] = {};
      for (var question in _sections[condition] ?? []) {
        _answers[condition]![question] = null;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Differential Diagnosis')),
      body: Column(
        children: [
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(16.0),
              children: [
                for (var condition in _sections.keys) ...[
                  _buildSectionTitle(condition),
                  for (var question in _sections[condition] ?? []) ...[
                    _buildQuestion(question, condition),
                  ],
                ],
                const SizedBox(height: 20),
              ],
            ),
          ),
          _buildNavigationButtons(),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12.0),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 22,
          fontWeight: FontWeight.bold,
          color: Colors.black87,
        ),
      ),
    );
  }

  Widget _buildQuestion(String question, String condition) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            question,
            style: const TextStyle(
              fontSize: 16,
              color: Colors.black87,
            ),
            softWrap: true,
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildRadioButton(condition, question, "Yes"),
              const SizedBox(width: 20),
              _buildRadioButton(condition, question, "No"),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildRadioButton(String condition, String question, String value) {
    bool isSelected = _answers[condition]?[question] == value;
    return GestureDetector(
      onTap: () {
        setState(() {
          _answers[condition] ??= {};
          _answers[condition]![question] = value;
        });
      },
      child: Container(
        width: 120,
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        decoration: BoxDecoration(
          color: isSelected ? Colors.blue : Colors.grey[200],
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: isSelected ? Colors.blue : Colors.grey,
            width: 2,
          ),
        ),
        child: Center(
          child: Text(
            value,
            style: TextStyle(
              color: isSelected ? Colors.white : Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildNavigationButtons() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
            },
            style: ElevatedButton.styleFrom(
              minimumSize: const Size(120, 50),
            ),
            child: const Text("Previous"),
          ),
          ElevatedButton(
            onPressed: () {
              Provider.of<PatientProvider>(context, listen: false)
                  .saveDifferentialDiagnosis(_answers);
              Navigator.pushNamed(context, '/compensation');
            },
            style: ElevatedButton.styleFrom(
              minimumSize: const Size(120, 50),
            ),
            child: const Text("Continue"),
          ),
        ],
      ),
    );
  }
}
