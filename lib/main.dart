import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wearespine/screens/compensation_screen.dart';
import 'package:wearespine/screens/examination_screen.dart';
import 'package:wearespine/screens/general_condition.dart';
import 'providers/patient_provider.dart';
import 'screens/personal_info_screen.dart';
import 'screens/medical_history_screen.dart';
import 'screens/symptoms_screen.dart';
import 'screens/differential_diagnosis_screen.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => PatientProvider()),
      ],
      child: MedicalDiagnosisApp(),
    ),
  );
}

class MedicalDiagnosisApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Medical Diagnosis Assistant',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      initialRoute: '/personal_info',
      routes: {
        '/personal_info': (context) => PersonalInfoScreen(),
        '/medical_history': (context) => HistoryScreen(),
        '/symptoms': (context) => SymptomsScreen(),
        '/general_condition': (context) => GeneralConditionScreen(),
        '/differential_diagnosis': (context) => DifferentialDiagnosisScreen(),
        '/examination': (context) => MedicalExaminationScreen(),
        '/compensation': (context) => CompensationScreen(),
      },
    );
  }
}
