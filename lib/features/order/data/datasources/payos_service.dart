import 'dart:convert';
import 'dart:io';
import 'package:crypto/crypto.dart';

class PayOSService {
  static const String clientId = '74e82913-fa42-4f44-b073-dd7da35f28aa';
  static const String apiKey = '8820b15c-1f32-443b-a3b0-993437e7df04';
  static const String checksumKey = '12af1d3b69fafe9b8d8d6e81e7ba61da53c503be5e787503142fcd4ba5748037';
  static const String baseUrl = 'https://api-merchant.payos.vn/v2/payment-requests';

  /// Sinh chữ ký HMAC-SHA256 thô theo yêu cầu của PayOS.
  /// Thứ tự trường bắt buộc sắp xếp theo Alphabet:
  /// amount, cancelUrl, description, orderCode, returnUrl
  static String generateSignature(Map<String, dynamic> data) {
    final sortedKeys = ['amount', 'cancelUrl', 'description', 'orderCode', 'returnUrl'];
    final List<String> pairs = [];
    
    for (final key in sortedKeys) {
      pairs.add('$key=${data[key]}');
    }
    
    final rawString = pairs.join('&');
    
    final keyBytes = utf8.encode(checksumKey);
    final dataBytes = utf8.encode(rawString);
    
    final hmac = Hmac(sha256, keyBytes);
    final digest = hmac.convert(dataBytes);
    
    return digest.toString();
  }

  /// Tạo link thanh toán PayOS thật. Trả về Map chứa `checkoutUrl` và `paymentLinkId`.
  static Future<Map<String, dynamic>> createPaymentLink({
    required int amount,
    required String description,
    required int orderCode,
    required String cancelUrl,
    required String returnUrl,
  }) async {
    final Map<String, dynamic> requestData = {
      'orderCode': orderCode,
      'amount': amount,
      'description': description,
      'cancelUrl': cancelUrl,
      'returnUrl': returnUrl,
    };

    // Tạo chữ ký bảo mật từ 5 trường dữ liệu trên
    final signature = generateSignature(requestData);
    requestData['signature'] = signature;

    final client = HttpClient();
    try {
      final request = await client.postUrl(Uri.parse(baseUrl));
      
      // Thiết lập Header bắt buộc của PayOS
      request.headers.set('x-client-id', clientId);
      request.headers.set('x-api-key', apiKey);
      request.headers.set('content-type', 'application/json');

      request.add(utf8.encode(jsonEncode(requestData)));
      
      final response = await request.close();
      final responseBody = await response.transform(utf8.decoder).join();
      
      final Map<String, dynamic> jsonResponse = jsonDecode(responseBody);
      
      if (jsonResponse['code'] == '00') {
        return jsonResponse['data'] as Map<String, dynamic>;
      } else {
        throw Exception(jsonResponse['desc'] ?? 'Lỗi không xác định từ PayOS');
      }
    } catch (e) {
      throw Exception('Không thể khởi tạo giao dịch PayOS: $e');
    } finally {
      client.close();
    }
  }

  /// Kiểm tra trạng thái thanh toán của mã đơn hàng.
  /// Trả về các trạng thái: "PENDING" (Chưa thanh toán), "PAID" (Đã thanh toán), "CANCELLED" (Đã huỷ)
  static Future<String> checkPaymentStatus(int orderCode) async {
    final client = HttpClient();
    try {
      final request = await client.getUrl(Uri.parse('$baseUrl/$orderCode'));
      
      request.headers.set('x-client-id', clientId);
      request.headers.set('x-api-key', apiKey);

      final response = await request.close();
      final responseBody = await response.transform(utf8.decoder).join();
      
      final Map<String, dynamic> jsonResponse = jsonDecode(responseBody);
      
      if (jsonResponse['code'] == '00') {
        final data = jsonResponse['data'] as Map<String, dynamic>;
        return data['status'] as String; // Trả về status: "PENDING", "PAID", "CANCELLED"
      } else {
        throw Exception(jsonResponse['desc'] ?? 'Lỗi kiểm tra giao dịch từ PayOS');
      }
    } catch (e) {
      throw Exception('Lỗi kết nối PayOS: $e');
    } finally {
      client.close();
    }
  }
}
