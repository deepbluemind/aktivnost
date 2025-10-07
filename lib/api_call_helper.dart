import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

class ApiCallHelper {
  static Future<void> simulateApiCall({
    required BuildContext context,
    required int apiCallStep,
    required Function(bool isLoading) setLoading,
    required Function() incrementStep,
  }) async {
    setLoading(true);
    final urls = [
      'https://httpstat.us/400',
      'https://httpstat.us/401',
      'https://httpstat.us/500',
      'https://httpstat.us/200',
    ];
    final url = urls[apiCallStep % 4];
    String? errorType;
    try {
      await http.get(Uri.parse(url));
    } catch (e) {
      if (e.toString().contains('400')) {
        errorType = 'Bad Request (400)';
      } else if (e.toString().contains('401')) {
        errorType = 'Unauthorized (401)';
      } else if (e.toString().contains('500')) {
        errorType = 'Internal Server Error (500)';
      } else if (e.toString().contains('200')) {
        errorType = 'Uspesno!';
      } else {
        errorType = null; // Network error or other issues
      }
      setLoading(false);
      incrementStep();
      if (errorType == 'Success!') {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Success!')),
        );
        
      } else if (errorType != null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(errorType),
            action: SnackBarAction(
              label: 'Retry',
              onPressed: () => simulateApiCall(
                context: context,
                apiCallStep: apiCallStep + 1,
                setLoading: setLoading,
                incrementStep: incrementStep,
              ),
            ),
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Success!')),
        );
      }
      return;
    }
  }
}
