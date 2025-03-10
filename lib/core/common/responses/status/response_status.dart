import 'package:equatable/equatable.dart';

class ResponseStatus extends Equatable {
  final int code;
  final String message;

  const ResponseStatus({required this.code, required this.message});

  @override
  List<Object?> get props => [code, message];

  factory ResponseStatus.fromMap(dynamic res) {
    try {
      if (res is Map<String, dynamic>) {
        return ResponseStatus(
            code: res['code'] ?? res['codigo'] ?? 400,
            message: res['message'] ?? res['mensagem'] ?? 'Não foi possível completar a solicitação.');
      }
      throw res;
    } catch (e) {
      return ResponseStatus(code: 500, message: 'error: ${e.toString()}');
    }
  }
}
