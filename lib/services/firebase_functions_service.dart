import 'package:cloud_functions/cloud_functions.dart';

class FirebaseFunctionsService {
  Future<void> deleteDriverAccountByEmail(String email) async {
    try {
      final HttpsCallable callable =
          FirebaseFunctions.instance.httpsCallable('deleteDriverAccount');
      final result = await callable.call({'email': email});

      print(result.data['message']);
    } catch (e) {
      print('Error deleting driver account: $e');
      rethrow;
    }
  }
}
