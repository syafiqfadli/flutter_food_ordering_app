import 'package:flutter_food_ordering_app/src/features/domain/entities/user/user.dart';

class HistoryModel extends HistoryEntity {
  const HistoryModel({required super.historyId});

  factory HistoryModel.fromJson(Map<String, dynamic> parseJson) {
    return HistoryModel(
      historyId: parseJson["historyId"],
    );
  }

  static List<HistoryModel> fromList(List<dynamic> parseJson) {
    List<HistoryModel> result = [];

    for (var data in parseJson) {
      result.add(HistoryModel.fromJson(data));
    }

    return result;
  }
}
