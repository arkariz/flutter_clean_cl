class ExampleModel {
  ExampleModel({
    this.name,
  });
  
  final String? name;

  ExampleModel copyWith({
    String? name,
  }) {
    return ExampleModel(
      name: name ?? this.name,
    );
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'name': name,
    };
  }

  factory ExampleModel.fromJson(Map<String, dynamic> map) {
    return ExampleModel(
      name: map['name'],
    );
  }

  @override
  String toString() => 'ExampleModel(name: $name)';

  @override
  bool operator ==(covariant ExampleModel other) {
    if (identical(this, other)) return true;
  
    return 
      other.name == name;
  }

  @override
  int get hashCode => name.hashCode;
}
