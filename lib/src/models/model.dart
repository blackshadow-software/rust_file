import 'dart:convert';

class Response {
  final bool? success;
  final String? error;
  Response({
    this.success,
    this.error,
  });

  Response copyWith({
    bool? success,
    String? error,
  }) {
    return Response(
      success: success ?? this.success,
      error: error ?? this.error,
    );
  }

  factory Response.fromJson(Map<String, dynamic> map) {
    return Response(
      success: map['success'],
      error: map['error'],
    );
  }

  factory Response.fromRawJson(String source) => Response.fromJson(json.decode(source));

  @override
  String toString() => 'Response(success: $success, error: $error)';
}
