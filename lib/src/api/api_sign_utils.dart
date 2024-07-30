import 'dart:convert';
import 'package:crypto/crypto.dart';

class ApiSignUtils {
  static String sign(Map<String, dynamic> body, String key) {
    // to string
    final sorted = body.entries.toList()
      ..sort((a, b) => a.key.compareTo(b.key));
    String data = sorted.map((e) => _s(e.value)).join('');
    // encode
    Hmac hmacSha256 = Hmac(sha256, utf8.encode(key));
    Digest digest = hmacSha256.convert(utf8.encode(data));
    return digest.toString();
  }

  static String _s(dynamic v) {
    if (v == null) return '';
    if (v is String) return v;
    if (v is num) return v.toString();
    if (v is bool) return v.toString().toLowerCase();
    if (v is List) return (v.map(_s).toList()..sort()).join(',');
    throw UnsupportedError("Unsupported value type: ${v.runtimeType}");
  }
}
