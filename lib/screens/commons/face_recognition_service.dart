// face_recognition_service.dart
import 'package:http/http.dart' as http;
import 'dart:convert';

class FaceRecognitionService {
  final String serverUrl;

  FaceRecognitionService(this.serverUrl);

  Future<String?> checkFaceRecognition(String imagePath) async {
    try {
      final url = Uri.parse("$serverUrl/recognize");
      var request = http.MultipartRequest('POST', url);
      request.files.add(await http.MultipartFile.fromPath('image', imagePath));

      var response = await request.send();
      var responseData = await response.stream.bytesToString();
      var result = json.decode(responseData);

      if (result['status'] == 'success' && result['recognized']) {
        return result['person'];
      } else {
        return null;  // No face recognized
      }
    } catch (e) {
      print("Error in face recognition request: $e");
      return null;
    }
  }
}
