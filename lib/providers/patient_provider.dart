import 'package:flutter/foundation.dart';

class PatientProvider extends ChangeNotifier {
  final Map<String, dynamic> _patientData = {
    'personal_info': [],  // Changed to List
    'conditions': [],     // Changed to List
    'symptoms': [],       // Changed to List
    'trauma': [],        // Changed to List
    'medications': [],    // Changed to List
    'red_flags': [],     // Changed to List
    'pain': [],          // Changed to List
    'examination': [],    // Changed to List
    'questionnaire_responses': [], // Changed to List
    'general_condition': [],      // Changed to List
    'history': [],               // Changed to List
    'differential_diagnosis': [], // Changed to List
    'compensation': []           // Changed to List
  };

  Map<String, dynamic> get patientData => _patientData;

  void updatePersonalInfo(Map<String, dynamic> personalInfo) {
    (_patientData['personal_info'] as List).add(personalInfo);
    notifyListeners();
  }

  void updateMedicalHistory(Map<String, dynamic> medicalHistory) {
    (_patientData['conditions'] as List).add(medicalHistory['conditions']);
    (_patientData['medications'] as List).add(medicalHistory['medications'] ?? {});
    (_patientData['trauma'] as List).add(medicalHistory['trauma'] ?? {});
    notifyListeners();
  }

  void updateSymptoms(Map<String, dynamic> symptoms) {
    (_patientData['symptoms'] as List).add(symptoms['symptoms']);
    (_patientData['red_flags'] as List).add(symptoms['red_flags']);
    (_patientData['pain'] as List).add(symptoms['pain']);
    (_patientData['examination'] as List).add(symptoms['examination']);
    notifyListeners();
  }

  void updateQuestionnaireResponses(Map<String, dynamic> responses) {
    (_patientData['questionnaire_responses'] as List).add(responses);
    notifyListeners();
  }

  void updateHistory(Map<String, dynamic> history) {
    (_patientData['history'] as List).add(history);
    notifyListeners();
  }

  void updateGeneralCondition(Map<String, dynamic> generalCondition) {
    (_patientData['general_condition'] as List).add(generalCondition);
    notifyListeners();
  }

  void saveMedicalExamination(Map<String, dynamic> medicalExamination) {
    (_patientData['examination'] as List).add(medicalExamination);
    notifyListeners();
  }

  void saveDifferentialDiagnosis(Map<String, dynamic> differentialDiagnosis) {
    (_patientData['differential_diagnosis'] as List).add(differentialDiagnosis);
    notifyListeners();
  }

  void saveCompensationData(Map<String, dynamic> compensationData) {
    (_patientData['compensation'] as List).add(compensationData);
    notifyListeners();
  }

  void clearPatientData() {
    _patientData.updateAll((key, value) => []);  // Clear to empty List
    notifyListeners();
  }

  // Optional: Add method to get the latest entry for each category
  Map<String, dynamic> getLatestData() {
    return {
      'personal_info': _getLastItem('personal_info'),
      'conditions': _getLastItem('conditions'),
      'symptoms': _getLastItem('symptoms'),
      'trauma': _getLastItem('trauma'),
      'medications': _getLastItem('medications'),
      'red_flags': _getLastItem('red_flags'),
      'pain': _getLastItem('pain'),
      'examination': _getLastItem('examination'),
      'questionnaire_responses': _getLastItem('questionnaire_responses'),
      'general_condition': _getLastItem('general_condition'),
      'history': _getLastItem('history'),
      'differential_diagnosis': _getLastItem('differential_diagnosis'),
      'compensation': _getLastItem('compensation')
    };
  }

  dynamic _getLastItem(String key) {
    final list = _patientData[key] as List;
    return list.isEmpty ? {} : list.last;
  }
}