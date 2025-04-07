import 'dart:convert';
import 'package:http/http.dart' as http;

class MidtransService {
  static const String apiUrl =
      "https://us-central1-yourproject.cloudfunctions.net/api";

  // Create Virtual Account (VA)
  static Future<Map<String, String>?> createVirtualAccount(
      String orderId, int amount, String bank, String customerName) async {
    final url = Uri.parse("$apiUrl/createVA");

    final response = await http.post(
      url,
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({
        "orderId": orderId,
        "amount": amount,
        "bank": bank,
        "customerName": customerName,
      }),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return {"va_number": data["va_number"], "bank": data["bank"]};
    } else {
      return null;
    }
  }

  // Check Payment Status
  static Future<Map<String, dynamic>?> checkPaymentStatus(
      String orderId) async {
    final url = Uri.parse("$apiUrl/checkPayment/$orderId");

    final response = await http.get(url);

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      return null;
    }
  }
}
