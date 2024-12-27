import 'package:flutter/foundation.dart';

class PatientProvider extends ChangeNotifier {
  final Map<String, dynamic> _patientData = {
    'personal_info': {},
    'conditions': {},
    'symptoms': {},
    'trauma': {},
    'medications': {},
    'red_flags': {},
    'pain': {},
    'examination': {},
    'questionnaire_responses': {},
    'general_condition': {},
    'history': {},
    'differential_diagnosis': {},
    'compensation': {}
  };

  Map<String, dynamic> get patientData => _patientData;

  void updatePersonalInfo(Map<String, dynamic> personalInfo) {
    _patientData['personal_info'] = personalInfo;
    notifyListeners();
  }

  void updateMedicalHistory(Map<String, dynamic> medicalHistory) {
    _patientData['conditions'] = medicalHistory['conditions'];
    _patientData['medications'] = medicalHistory['medications'] ?? {};
    _patientData['trauma'] = medicalHistory['trauma'] ?? {};
    notifyListeners();
  }

  void updateSymptoms(Map<String, dynamic> symptoms) {
    _patientData['symptoms'] = symptoms['symptoms'];
    _patientData['red_flags'] = symptoms['red_flags'];
    _patientData['pain'] = symptoms['pain'];
    _patientData['examination'] = symptoms['examination'];
    notifyListeners();
  }

  void updateQuestionnaireResponses(Map<String, dynamic> responses) {
    _patientData['questionnaire_responses'] = responses;
    notifyListeners();
  }

  void updateHistory(Map<String, dynamic> history) {
    _patientData['history'] = history;
    notifyListeners();
  }

  void updateGeneralCondition(Map<String, dynamic> generalCondition) {
    _patientData['general_condition'] = generalCondition;
    notifyListeners();
  }

  void saveMedicalExamination(Map<String, dynamic> medicalExamination) {
    _patientData['examination'] = medicalExamination;
    notifyListeners();
  }

  void saveDifferentialDiagnosis(Map<String, dynamic> differentialDiagnosis) {
    _patientData['differential_diagnosis'] = differentialDiagnosis;
    notifyListeners();
  }

  void saveCompensationData(Map<String, dynamic> compensationData) {
    _patientData['compensation'] = compensationData;
    notifyListeners();
  }

  void clearPatientData() {
    _patientData.updateAll((key, value) => null);
    notifyListeners();
  }
}
