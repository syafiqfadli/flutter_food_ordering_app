import 'package:order_me/src/features/data/models/models.dart';
import 'package:order_me/src/features/domain/entities/user/user.dart';

class HistoryModel extends HistoryEntity {
  const HistoryModel({
    required super.historyId,
    required super.orderId,
    required super.restaurantName,
    required super.status,
    required super.completedAt,
    required super.orderList,
  });

  factory HistoryModel.fromJson(Map<String, dynamic> parseJson) {
    return HistoryModel(
      historyId: parseJson["historyId"],
      orderId: parseJson["orderId"],
      restaurantName: parseJson["restaurantName"],
      status: parseJson["status"],
      completedAt: DateTime.parse(parseJson["completedAt"]),
      orderList: parseJson["orderList"] != null
          ? MenuModel.fromList(parseJson["orderList"])
          : <MenuModel>[],
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
