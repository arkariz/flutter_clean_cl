/*
import '../../../../domain/module/{{fileName}}/entity/{{fileName}}.dart';

class {{name}}Model {
  {{name}}Model({
    this.name,
  });
  
  final String? name;

  {{name}}Model copyWith({
    String? name,
  }) {
    return {{name}}Model(
      name: name ?? this.name,
    );
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'name': name,
    };
  }

  {{name}} toEntity() => {{name}}(
    name: name ?? "",
  );

  factory {{name}}Model.fromJson(Map<String, dynamic> map) {
    return {{name}}Model(
      name: map['name'],
    );
  }

  @override
  String toString() => '{{name}}Model(name: $name)';

  @override
  bool operator ==(covariant {{name}}Model other) {
    if (identical(this, other)) return true;
  
    return 
      other.name == name;
  }

  @override
  int get hashCode => name.hashCode;
}
*/
