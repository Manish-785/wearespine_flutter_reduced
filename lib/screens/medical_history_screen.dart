import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/patient_provider.dart';
import 'package:flutter_image_map/flutter_image_map.dart';

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
  bool isBackView = false;
  bool walkWithSupport = false;
  String? handSkillsChange;
  List<String> bowelBladderSymptoms = [];
  List<String> additionalConditions = [];
  String? hoveredRegion;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Detailed Patient History')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            _buildSectionTitle("1. Site"),
            _buildClickableBody(),
            Text("Selected Site: ${site ?? 'None'}"),
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
            _buildSectionTitle("6. Do you have any of the following?"),
            _buildMultiSelect(
                "Select Conditions",
                [
                  "Imbalance",
                  "Vertigo",
                  "Nausea",
                  "Handwriting or signature changes"
                ],
                additionalConditions, (values) {
              setState(() {
                additionalConditions = values;
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

  Widget _buildClickableBody() {
    return Column(
      children: [
        const Text('Click on the body to select the site of pain'),
        ElevatedButton(
          onPressed: () {
            setState(() {
              isBackView = !isBackView;
            });
          },
          child: Text(isBackView ? 'Show Front View' : 'Show Back View'),
        ),
        const SizedBox(
          height: 10,
        ),
        Container(
          height: 500,
          width: 300,
          child: Stack(
            children: [
              MouseRegion(
                onHover: (event) {
                  // Get the relative position within the widget
                  final RenderBox box = context.findRenderObject() as RenderBox;
                  final localPosition = box.globalToLocal(event.position);

                  // Check which region contains this point
                  for (var region
                      in isBackView ? backBodyRegions() : frontBodyRegions()) {
                    if (region.path.contains(localPosition)) {
                      setState(() {
                        hoveredRegion = region.title;
                      });
                      break;
                    }
                  }
                },
                onExit: (_) {
                  setState(() {
                    hoveredRegion = null;
                  });
                },
                child: ImageMap(
                  image: Image.asset(
                    isBackView ? 'lib/assets/back.png' : 'lib/assets/front.png',
                    fit: BoxFit.contain,
                  ),
                  onTap: (area) {
                    setState(() {
                      site = area.title;
                    });
                  },
                  regions: isBackView ? backBodyRegions() : frontBodyRegions(),
                ),
              ),
              if (hoveredRegion != null)
                Positioned(
                  top: 10,
                  left: 10,
                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: Colors.black54,
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Text(
                      hoveredRegion!,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
            ],
          ),
        )
      ],
    );
  }

  List<ImageMapRegion> frontBodyRegions() {
    return [
      ImageMapRegion(
        title: 'Neck',
        shape: ImageMapShape.circle,
        path: Path()..addRect(Rect.fromLTWH(110, 100, 100, 50)),
        color: hoveredRegion == 'Neck'
            ? Colors.red.withOpacity(0.3)
            : Colors.transparent,
      ),
      ImageMapRegion(
        title: 'Right Shoulder',
        shape: ImageMapShape.rect,
        path: Path()..addRect(Rect.fromLTWH(25, 100, 80, 100)),
        color: hoveredRegion == 'Right Shoulder'
            ? Colors.red.withOpacity(0.3)
            : Colors.transparent,
      ),
      ImageMapRegion(
        title: 'Right Bicep',
        shape: ImageMapShape.rect,
        path: Path()..addRect(Rect.fromLTWH(20, 200, 80, 80)),
        color: hoveredRegion == 'Right Bicep'
            ? Colors.red.withOpacity(0.3)
            : Colors.transparent,
      ),
      ImageMapRegion(
        title: 'Right Forearm',
        shape: ImageMapShape.rect,
        path: Path()..addRect(Rect.fromLTWH(20, 280, 80, 80)),
        color: hoveredRegion == 'Right Forearm'
            ? Colors.red.withOpacity(0.3)
            : Colors.transparent,
      ),
      ImageMapRegion(
        title: 'Right Hand',
        shape: ImageMapShape.rect,
        path: Path()..addRect(Rect.fromLTWH(20, 360, 80, 80)),
        color: hoveredRegion == 'Right Hand'
            ? Colors.red.withOpacity(0.3)
            : Colors.transparent,
      ),
      ImageMapRegion(
        title: 'Left Shoulder',
        shape: ImageMapShape.rect,
        path: Path()..addRect(Rect.fromLTWH(200, 100, 80, 100)),
        color: hoveredRegion == 'Left Shoulder'
            ? Colors.red.withOpacity(0.3)
            : Colors.transparent,
      ),
      ImageMapRegion(
        title: 'Left Bicep',
        shape: ImageMapShape.rect,
        path: Path()..addRect(Rect.fromLTWH(220, 200, 80, 80)),
        color: hoveredRegion == 'Left Bicep'
            ? Colors.red.withOpacity(0.3)
            : Colors.transparent,
      ),
      ImageMapRegion(
        title: 'Left Forearm',
        shape: ImageMapShape.rect,
        path: Path()..addRect(Rect.fromLTWH(220, 280, 80, 80)),
        color: hoveredRegion == 'Left Forearm'
            ? Colors.red.withOpacity(0.3)
            : Colors.transparent,
      ),
      ImageMapRegion(
        title: 'Left Hand',
        shape: ImageMapShape.rect,
        path: Path()..addRect(Rect.fromLTWH(220, 360, 80, 80)),
        color: hoveredRegion == 'Left Hand'
            ? Colors.red.withOpacity(0.3)
            : Colors.transparent,
      ),
      ImageMapRegion(
        title: 'Groin',
        shape: ImageMapShape.rect,
        path: Path()..addRect(Rect.fromLTWH(120, 330, 80, 80)),
        color: hoveredRegion == 'Groin'
            ? Colors.red.withOpacity(0.3)
            : Colors.transparent,
      ),
      ImageMapRegion(
        title: 'Left Thigh',
        shape: ImageMapShape.rect,
        path: Path()..addRect(Rect.fromLTWH(160, 400, 100, 100)),
        color: hoveredRegion == 'Left Thigh'
            ? Colors.red.withOpacity(0.3)
            : Colors.transparent,
      ),
      ImageMapRegion(
        title: 'Right Thigh',
        shape: ImageMapShape.rect,
        path: Path()..addRect(Rect.fromLTWH(60, 400, 100, 100)),
        color: hoveredRegion == 'Right Thigh'
            ? Colors.red.withOpacity(0.3)
            : Colors.transparent,
      ),
      ImageMapRegion(
        title: 'Left Knee',
        shape: ImageMapShape.rect,
        path: Path()..addRect(Rect.fromLTWH(200, 500, 60, 60)),
        color: hoveredRegion == 'Left Knee'
            ? Colors.red.withOpacity(0.3)
            : Colors.transparent,
      ),
      ImageMapRegion(
        title: 'Right Knee',
        shape: ImageMapShape.rect,
        path: Path()..addRect(Rect.fromLTWH(80, 500, 60, 60)),
        color: hoveredRegion == 'Right Knee'
            ? Colors.red.withOpacity(0.3)
            : Colors.transparent,
      ),
      ImageMapRegion(
        title: 'Left Leg',
        shape: ImageMapShape.rect,
        path: Path()..addRect(Rect.fromLTWH(200, 560, 60, 130)),
        color: hoveredRegion == 'Left Leg'
            ? Colors.red.withOpacity(0.3)
            : Colors.transparent,
      ),
      ImageMapRegion(
        title: 'Right Leg',
        shape: ImageMapShape.rect,
        path: Path()..addRect(Rect.fromLTWH(80, 560, 60, 130)),
        color: hoveredRegion == 'Right Leg'
            ? Colors.red.withOpacity(0.3)
            : Colors.transparent,
      ),
      ImageMapRegion(
        title: 'Left Foot',
        shape: ImageMapShape.rect,
        path: Path()..addRect(Rect.fromLTWH(200, 690, 70, 50)),
        color: hoveredRegion == 'Left Foot'
            ? Colors.red.withOpacity(0.3)
            : Colors.transparent,
      ),
      ImageMapRegion(
        title: 'Right Foot',
        shape: ImageMapShape.rect,
        path: Path()..addRect(Rect.fromLTWH(80, 690, 70, 50)),
        color: hoveredRegion == 'Right Foot'
            ? Colors.red.withOpacity(0.3)
            : Colors.transparent,
      ),
    ];
  }

  List<ImageMapRegion> backBodyRegions() {
    return [
      ImageMapRegion(
        title: 'Upper Back',
        shape: ImageMapShape.circle,
        path: Path()..addRect(Rect.fromLTWH(100, 100, 130, 90)),
        color: hoveredRegion == 'Upper Back'
            ? Colors.red.withOpacity(0.3)
            : Colors.transparent,
      ),
      ImageMapRegion(
        title: 'Middle Back',
        shape: ImageMapShape.circle,
        path: Path()..addRect(Rect.fromLTWH(100, 190, 140, 90)),
        color: hoveredRegion == 'Middle Back'
            ? Colors.red.withOpacity(0.3)
            : Colors.transparent,
      ),
      ImageMapRegion(
        title: 'Lower Back',
        shape: ImageMapShape.circle,
        path: Path()..addRect(Rect.fromLTWH(100, 280, 140, 60)),
        color: hoveredRegion == 'Lower Back'
            ? Colors.red.withOpacity(0.3)
            : Colors.transparent,
      ),
      ImageMapRegion(
        title: 'Right Glute',
        shape: ImageMapShape.circle,
        path: Path()..addRect(Rect.fromLTWH(80, 340, 85, 80)),
        color: hoveredRegion == 'Right Glute'
            ? Colors.red.withOpacity(0.3)
            : Colors.transparent,
      ),
      ImageMapRegion(
        title: 'Left Glute',
        shape: ImageMapShape.circle,
        path: Path()..addRect(Rect.fromLTWH(175, 340, 80, 80)),
        color: hoveredRegion == 'Left Glute'
            ? Colors.red.withOpacity(0.3)
            : Colors.transparent,
      ),
      ImageMapRegion(
        title: 'Right Hamstring',
        shape: ImageMapShape.circle,
        path: Path()..addRect(Rect.fromLTWH(80, 420, 85, 100)),
        color: hoveredRegion == 'Right Hamstring'
            ? Colors.red.withOpacity(0.3)
            : Colors.transparent,
      ),
      ImageMapRegion(
        title: 'Left Hamstring',
        shape: ImageMapShape.circle,
        path: Path()..addRect(Rect.fromLTWH(175, 420, 80, 100)),
        color: hoveredRegion == 'Left Hamstring'
            ? Colors.red.withOpacity(0.3)
            : Colors.transparent,
      ),
      ImageMapRegion(
        title: 'Right Calves',
        shape: ImageMapShape.circle,
        path: Path()..addRect(Rect.fromLTWH(65, 540, 80, 125)),
        color: hoveredRegion == 'Right Calves'
            ? Colors.red.withOpacity(0.3)
            : Colors.transparent,
      ),
      ImageMapRegion(
        title: 'Left Calves',
        shape: ImageMapShape.circle,
        path: Path()..addRect(Rect.fromLTWH(175, 540, 80, 125)),
        color: hoveredRegion == 'Left Calves'
            ? Colors.red.withOpacity(0.3)
            : Colors.transparent,
      ),
      ImageMapRegion(
        title: 'Right Heel',
        shape: ImageMapShape.circle,
        path: Path()..addRect(Rect.fromLTWH(65, 665, 60, 70)),
        color: hoveredRegion == 'Right Heel'
            ? Colors.red.withOpacity(0.3)
            : Colors.transparent,
      ),
      ImageMapRegion(
        title: 'Left Heel',
        shape: ImageMapShape.circle,
        path: Path()..addRect(Rect.fromLTWH(180, 665, 60, 70)),
        color: hoveredRegion == 'Left Heel'
            ? Colors.red.withOpacity(0.3)
            : Colors.transparent,
      ),
    ];
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
      "Additional Conditions": additionalConditions,
      // Additional fields...
    };

    Provider.of<PatientProvider>(context, listen: false)
        .updateHistory(historyData);

    Navigator.pushNamed(context, '/examination');
  }
}
