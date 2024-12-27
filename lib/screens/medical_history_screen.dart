import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/patient_provider.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({Key? key}) : super(key: key);

  @override
  _HistoryScreenState createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  String? site;
  String? duration;
  String? episodicFrequency;
  String? progression;
  String? onsetType;
  String? event;
  String? customEvent;
  List<String> aggravatingFactors = [];
  List<String> reliefFactors = [];
  bool legPain = false;
  Map<String, dynamic> legPainDetails = {};
  bool armPain = false;
  Map<String, dynamic> armPainDetails = {};
  String? walkingAbility;
  String? dailyActivities;
  List<String> additionalSymptoms = [];
  bool fallsDueToImbalance = false;
  bool walkWithSupport = false;
  String? handSkillsChange;
  List<String> bowelBladderSymptoms = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Detailed Patient History')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            _buildSectionTitle("1. Site"),
            _buildDropdown(
                "Select Site",
                [
                  "Select",
                  "Cervical Spine",
                  "Thoracic Spine",
                  "Lumbar Spine",
                  "Sacral Spine",
                  "Shoulder",
                  "Elbow",
                  "Wrist",
                  "Hip",
                  "Knee",
                  "Ankle"
                ],
                site, (value) {
              setState(() {
                site = value;
              });
            }),
            _buildSectionTitle("2. Duration"),
            _buildRadio(
                "Pain Duration",
                [
                  "Acute (a few days)",
                  "Sub Acute (< 6 months)",
                  "Chronic (> 6 months)",
                  "Episodic"
                ],
                duration, (value) {
              setState(() {
                duration = value;
              });
            }),
            if (duration == "Episodic")
              _buildTextField("Frequency of Episodes", (value) {
                episodicFrequency = value;
              }),
            _buildSectionTitle("3. Progression"),
            _buildRadio(
                "Pain Progression",
                ["Worsened", "Improved", "Status Quo", "On/Off"],
                progression, (value) {
              setState(() {
                progression = value;
              });
            }),
            _buildSectionTitle("4. How Did It Start?"),
            _buildRadio(
                "Onset",
                [
                  "Suddenly",
                  "Gradually over time",
                  "After some event",
                  "Randomly"
                ],
                onsetType, (value) {
              setState(() {
                onsetType = value;
                if (value != "After some event") {
                  event = null;
                  customEvent = null;
                }
              });
            }),
            if (onsetType == "After some event")
              _buildDropdown(
                  "Specific Event",
                  ["Lifting something heavy", "Fall", "Travelling", "Other"],
                  event, (value) {
                setState(() {
                  event = value;
                  if (value != "Other") customEvent = null;
                });
              }),
            if (event == "Other")
              _buildTextField("Describe the Event", (value) {
                customEvent = value;
              }),
            _buildSectionTitle("5. How Does It Aggravate?"),
            _buildMultiSelect(
                "Select Aggravating Factors",
                [
                  "Sitting for a long time",
                  "Transition movements (getting up/down)",
                  "Coughing or sneezing",
                  "All the time",
                  "More at night",
                  "Twisting movement",
                  "More at rest",
                  "During intercourse",
                  "Lifting something heavy",
                  "Bending forward",
                  "Walking up stairs/uphill",
                  "Pushing a grocery cart",
                  "Bending backward",
                  "Going down stairs/downhill",
                  "Sudden jerk",
                  "Walking for some distance",
                  "When waking up in the morning",
                  "Driving for long"
                ],
                aggravatingFactors, (values) {
              setState(() {
                aggravatingFactors = values;
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
                  child: const Text("Previous"),
                ),
                ElevatedButton(
                  onPressed: _saveHistory,
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

  Widget _buildDropdown(String label, List<String> options,
      String? currentValue, ValueChanged<String?> onChanged) {
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

  Widget _buildRadio(String label, List<String> options, String? currentValue,
      ValueChanged<String?> onChanged) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontSize: 16)),
        ...options.map((option) {
          return RadioListTile<String>(
            title: Text(option),
            value: option,
            groupValue: currentValue,
            onChanged: onChanged,
          );
        }).toList(),
      ],
    );
  }

  Widget _buildMultiSelect(String label, List<String> options,
      List<String> currentValues, ValueChanged<List<String>> onChanged) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontSize: 16)),
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

  Widget _buildTextField(String label, ValueChanged<String?> onChanged) {
    return TextFormField(
      decoration: InputDecoration(labelText: label),
      onChanged: onChanged,
    );
  }

  void _saveHistory() {
    final historyData = {
      "Site": site,
      "Duration": {
        "Type": duration,
        "Episodic Frequency": episodicFrequency,
      },
      "Progression": progression,
      "Onset": {
        "Type": onsetType,
        "Event": {"Type": event, "Custom Event": customEvent},
      },
      "Aggravating Factors": aggravatingFactors,
      // Additional fields...
    };

    Provider.of<PatientProvider>(context, listen: false)
        .updateHistory(historyData);

    // ScaffoldMessenger.of(context).showSnackBar(
    //   const SnackBar(content: Text("History Information Saved Successfully!")),
    // );

    Navigator.pushNamed(context, '/examination');
  }
}
