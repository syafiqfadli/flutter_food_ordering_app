import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:order_me/src/core/errors/failures.dart';
import 'package:order_me/src/features/data/models/models.dart';
import 'package:http/http.dart' as http;

abstract class ApiDataSource {
  Future<Either<Failure, ResponseModel>> get(
    Uri url, {
    Map<String, String>? headers,
  });
  Future<Either<Failure, ResponseModel>> post(
    Uri url, {
    Map<String, String>? headers,
    Map<String, dynamic>? body,
  });
  Future<Either<Failure, ResponseModel>> patch(
    Uri url, {
    Map<String, String>? headers,
    Map<String, dynamic>? body,
  });
  Future<Either<Failure, ResponseModel>> delete(
    Uri url, {
    Map<String, String>? headers,
    Map<String, dynamic>? body,
  });
}

class ApiDataSourceImpl implements ApiDataSource {
  @override
  Future<Either<Failure, ResponseModel>> get(
    Uri url, {
    Map<String, String>? headers,
  }) async {
    try {
      final rawResponse = await http
          .get(
            url,
            headers: headers,
          )
          .timeout(
            const Duration(seconds: 10),
          );

      final response = ResponseModel.fromJson(jsonDecode(rawResponse.body));

      if (!response.isSuccess) {
        return Left(ServerFailure(message: response.message));
      }

      return Right(response);
    } on SocketException catch (error) {
      String message = "";

      if (error.toString() == "Connection refused") {
        message = "Server offline.";
      } else {
        message = "Please check your internet connection.";
      }

      return Left(ServerFailure(message: message));
    } on TimeoutException catch (timeout) {
      return Left(ServerFailure(message: timeout.toString()));
    } on FormatException catch (_) {
      return const Left(ServerFailure(message: "Server offline."));
    } on HandshakeException catch (_) {
      return const Left(ServerFailure(message: "Server offline."));
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, ResponseModel>> post(
    Uri url, {
    Map<String, String>? headers,
    Map<String, dynamic>? body,
  }) async {
    try {
      final rawResponse = await http.post(
        url,
        headers: headers,
        body: jsonEncode(body),
      );

      final response = ResponseModel.fromJson(jsonDecode(rawResponse.body));

      if (!response.isSuccess) {
        return Left(ServerFailure(message: response.message));
      }

      return Right(response);
    } catch (error) {
      return Left(ServerFailure(message: error.toString()));
    }
  }

  @override
  Future<Either<Failure, ResponseModel>> patch(
    Uri url, {
    Map<String, String>? headers,
    Map<String, dynamic>? body,
  }) async {
    try {
      final rawResponse = await http.patch(
        url,
        headers: headers,
        body: jsonEncode(body),
      );

      final response = ResponseModel.fromJson(jsonDecode(rawResponse.body));

      if (!response.isSuccess) {
        return Left(ServerFailure(message: response.message));
      }

      return Right(response);
    } catch (error) {
      return Left(ServerFailure(message: error.toString()));
    }
  }

  @override
  Future<Either<Failure, ResponseModel>> delete(
    Uri url, {
    Map<String, String>? headers,
    Map<String, dynamic>? body,
  }) async {
    try {
      final rawResponse = await http.delete(
        url,
        headers: headers,
        body: jsonEncode(body),
      );

      final response = ResponseModel.fromJson(jsonDecode(rawResponse.body));

      if (!response.isSuccess) {
        return Left(ServerFailure(message: response.message));
      }

      return Right(response);
    } catch (error) {
      return Left(ServerFailure(message: error.toString()));
    }
  }
}
