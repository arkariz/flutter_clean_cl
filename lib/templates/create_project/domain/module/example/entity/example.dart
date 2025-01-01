import 'package:equatable/equatable.dart';

class Example extends Equatable {
  final String name;

  Example({required this.name});

  @override
  List<Object> get props => [name];
}
