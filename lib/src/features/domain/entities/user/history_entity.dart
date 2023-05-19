import 'package:equatable/equatable.dart';

class HistoryEntity extends Equatable {
  final String historyId;

  const HistoryEntity({required this.historyId});

  @override
  List<Object?> get props => [historyId];
}
