import 'package:equatable/equatable.dart';

class RequestExample extends Equatable {
  final int id;

  RequestExample({
    required this.id
  });

  Map<String, dynamic> toJson() => {
    "id": id,
  };

  @override
  List<Object> get props => [id];
}