import 'package:equatable/equatable.dart';
import 'package:flutter_food_ordering_app/src/features/domain/entities/entities.dart';

class HistoryEntity extends Equatable {
  final String historyId;
  final String orderId;
  final String restaurantName;
  final DateTime completedAt;
  final List<MenuEntity> orderList;

  const HistoryEntity({
    required this.historyId,
    required this.orderId,
    required this.restaurantName,
    required this.completedAt,
    required this.orderList,
  });

  @override
  List<Object?> get props => [historyId];
}
