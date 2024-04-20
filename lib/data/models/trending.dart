import 'dart:convert';

class Trending {
  final int id;
  final String name;
  Trending({
    required this.id,
    required this.name,
  });

  Trending copyWith({
    int? id,
    String? name,
  }) {
    return Trending(
      id: id ?? this.id,
      name: name ?? this.name,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
    };
  }

  factory Trending.fromMap(Map<String, dynamic> map) {
    return Trending(
      id: map['id'].toInt() as int,
      name: map['name'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Trending.fromJson(String source) => Trending.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'Trending(id: $id, name: $name)';

  @override
  bool operator ==(covariant Trending other) {
    if (identical(this, other)) return true;
  
    return 
      other.id == id &&
      other.name == name;
  }

  @override
  int get hashCode => id.hashCode ^ name.hashCode;
}