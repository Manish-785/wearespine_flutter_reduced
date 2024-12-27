import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/patient_provider.dart';

class SymptomsScreen extends StatefulWidget {
  @override
  _SymptomsScreenState createState() => _SymptomsScreenState();
}

class _SymptomsScreenState extends State<SymptomsScreen> {
  Map<String, bool> symptoms = {
    "Significant Weight Loss": false,
    "Anorexia": false,
    "Unexplained Fever": false,
    "Generalized Weakness": false,
    "Night Pain": false,
    "Imbalance": false,
    "Giddiness": false,
    "Vertigo": false,
  };

  Map<String, bool> redFlags = {
    "Bowel/Bladder Incontinence": false,
    "Anxiety": false,
    "Depression": false,
    "Insomnia": false,
    "Inability to Move Limbs": false,
    "Severe Pain": false,
    "Episodes of Falls due to Imbalance": false,
  };

  String? painLocation;
  String? painDuration;
  String? painProgression;
  String? painOnset;
  String? reliefFactor;
  bool limitedRangeOfMotion = false;

  Map<String, bool> aggravatingFactors = {
    "Sitting for long time": false,
    "Transition movements": false,
    "Coughing/Sneezing": false,
    "All the time": false,
    "More at night": false,
    "Twisting movement": false,
    "More at rest": false,
    "During intercourse": false,
    "Lifting heavy objects": false,
    "Bending forward": false,
    "Bending backward": false,
    "Sudden jerks": false,
    "Walking": false,
    "Morning pain": false,
    "Driving": false,
  };

  String? gaitType;
  Map<String, bool> heelToeWalk = {
    "Walk on right toe": false,
    "Walk on left toe": false,
    "Walk on right heel": false,
    "Walk on left heel": false,
  };
  String? tandemWalk;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Symptoms and Examination')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            _buildSectionTitle('General Symptoms'),
            ...symptoms.keys.map((symptom) => _buildCheckbox(symptom, symptoms,
                (value) => setState(() => symptoms[symptom] = value!))),
            _buildSectionTitle('Red Flags'),
            ...redFlags.keys.map((flag) => _buildCheckbox(flag, redFlags,
                (value) => setState(() => redFlags[flag] = value!))),
            _buildSectionTitle('Pain Assessment'),
            DropdownButtonFormField<String>(
              decoration: const InputDecoration(labelText: 'Pain Location'),
              value: painLocation,
              items: [
                "Neck",
                "Back",
                "Shoulder",
                "Hip",
                "Knee",
                "Ankle",
                "Wrist",
                "Elbow",
              ]
                  .map((location) =>
                      DropdownMenuItem(value: location, child: Text(location)))
                  .toList(),
              onChanged: (value) => setState(() => painLocation = value),
            ),
            DropdownButtonFormField<String>(
              decoration: const InputDecoration(labelText: 'Duration of Pain'),
              value: painDuration,
              items: [
                "Acute (few days)",
                "Sub-Acute (<6 months)",
                "Chronic (>6 months)",
                "Episodic",
              ]
                  .map((duration) =>
                      DropdownMenuItem(value: duration, child: Text(duration)))
                  .toList(),
              onChanged: (value) => setState(() => painDuration = value),
            ),
            DropdownButtonFormField<String>(
              decoration: const InputDecoration(labelText: 'Pain Progression'),
              value: painProgression,
              items: ["Worsened", "Improved", "Status Quo", "On/Off"]
                  .map((progression) => DropdownMenuItem(
                      value: progression, child: Text(progression)))
                  .toList(),
              onChanged: (value) => setState(() => painProgression = value),
            ),
            DropdownButtonFormField<String>(
              decoration: const InputDecoration(labelText: 'Pain Onset'),
              value: painOnset,
              items: [
                "Suddenly",
                "Gradually",
                "After specific event",
                "Randomly"
              ]
                  .map((onset) =>
                      DropdownMenuItem(value: onset, child: Text(onset)))
                  .toList(),
              onChanged: (value) => setState(() => painOnset = value),
            ),
            _buildSectionTitle('Pain Aggravating Factors'),
            ...aggravatingFactors.keys.map((factor) => _buildCheckbox(
                factor,
                aggravatingFactors,
                (value) =>
                    setState(() => aggravatingFactors[factor] = value!))),
            _buildSectionTitle('Pain Relief Factors'),
            DropdownButtonFormField<String>(
              decoration: const InputDecoration(labelText: 'Relief Factor'),
              value: reliefFactor,
              items: [
                "Rest",
                "Exercise",
                "Walking few steps in morning",
                "Not relieved by anything"
              ]
                  .map((relief) =>
                      DropdownMenuItem(value: relief, child: Text(relief)))
                  .toList(),
              onChanged: (value) => setState(() => reliefFactor = value),
            ),
            _buildSectionTitle('Physical Examination'),
            DropdownButtonFormField<String>(
              decoration: const InputDecoration(labelText: 'Gait Type'),
              value: gaitType,
              items: [
                "Normal",
                "Antalgic",
                "Lurching",
                "Crouched",
                "Listed on one side",
                "High steppage",
                "Assisted",
              ]
                  .map((gait) =>
                      DropdownMenuItem(value: gait, child: Text(gait)))
                  .toList(),
              onChanged: (value) => setState(() => gaitType = value),
            ),
            _buildSectionTitle('Heel-Toe Walk'),
            ...heelToeWalk.keys.map((walk) => _buildCheckbox(walk, heelToeWalk,
                (value) => setState(() => heelToeWalk[walk] = value!))),
            DropdownButtonFormField<String>(
              decoration: const InputDecoration(labelText: 'Tandem Walk'),
              value: tandemWalk,
              items: ["Not performed yet", "Yes", "No"]
                  .map((tandem) =>
                      DropdownMenuItem(value: tandem, child: Text(tandem)))
                  .toList(),
              onChanged: (value) => setState(() => tandemWalk = value),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _submitForm,
              child: const Text('Next'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Text(
        title,
        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget _buildCheckbox(
      String title, Map<String, bool> group, void Function(bool?)? onChanged) {
    return CheckboxListTile(
      title: Text(title),
      value: group[title],
      onChanged: onChanged,
    );
  }

  void _submitForm() {
    final symptomsData = {
      'symptoms': symptoms,
      'red_flags': redFlags,
      'pain': {
        'location': painLocation,
        'duration': painDuration,
        'progression': painProgression,
        'onset': painOnset,
        'aggravatingFactors': aggravatingFactors,
        'reliefFactor': reliefFactor,
      },
      'examination': {
        'gaitType': gaitType,
        'heelToeWalk': heelToeWalk,
        'tandemWalk': tandemWalk,
      },
    };

    Provider.of<PatientProvider>(context, listen: false)
        .updateSymptoms(symptomsData);

    Navigator.pushNamed(context, '/questionnaires');
  }
}
