import 'dart:convert'; // For JSON encoding
import 'package:http/http.dart' as http; // For HTTP requests
import 'package:intl/intl.dart'; // For date formatting
import 'dart:io'; // For SocketException

Future<void> uploadToApi(Map<String, dynamic> data) async {
  final url = Uri.parse('https://wearespine-api.onrender.com/store-json');

  // Generate a unique file name based on the current date and time
  final timestamp = DateFormat('yyyyMMdd_HHmmss').format(DateTime.now());
  final fileName = 'patient_data_$timestamp.json';

  // Define headers for the API
  final headers = {
    'Content-Type': 'application/json',
    'File-Name': fileName, // Custom header to send the file name
  };

  // Convert data to JSON string
  final body = jsonEncode(data);

  try {
    // Send the POST request
    final response = await http.post(url, headers: headers, body: body);

    // Check the response status
    if (response.statusCode == 200) {
      print('Data uploaded to API successfully!');
    } else {
      print('Error uploading to API: ${response.body}');
    }
  } on SocketException catch (e) {
    print('Connection refused: $e');
  } catch (e) {
    print('An error occurred: $e');
  }
}