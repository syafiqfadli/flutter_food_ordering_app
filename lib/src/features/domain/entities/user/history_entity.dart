import 'package:equatable/equatable.dart';
import 'package:order_me/src/features/domain/entities/entities.dart';

class HistoryEntity extends Equatable {
  final String historyId;
  final String orderId;
  final String restaurantName;
  final String status;
  final DateTime completedAt;
  final List<MenuEntity> orderList;

  const HistoryEntity({
    required this.historyId,
    required this.orderId,
    required this.restaurantName,
    required this.status,
    required this.completedAt,
    required this.orderList,
  });

  @override
  List<Object?> get props => [historyId];
}
