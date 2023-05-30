import 'package:order_me/src/features/domain/entities/entities.dart';

class ResponseModel extends ResponseEntity {
  const ResponseModel({
    required bool isSuccess,
    required data,
    required String message,
  }) : super(
          isSuccess: isSuccess,
          data: data,
          message: message,
        );

  factory ResponseModel.fromJson(Map<String, dynamic> parseJson) {
    return ResponseModel(
      isSuccess: parseJson['isSuccess'],
      data: parseJson['data'] ?? {},
      message: parseJson['message'] ?? '',
    );
  }
}
