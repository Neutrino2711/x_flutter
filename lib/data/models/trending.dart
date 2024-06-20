import 'dart:convert';

class Trending {
  final int id;
  final String name;
  final int count;
  Trending({
    required this.id,
    required this.name,
    required this.count,
  });

  Trending copyWith({
    int? id,
    String? name,
    int? count,
  }) {
    return Trending(
      id: id ?? this.id,
      name: name ?? this.name,
      count: count ?? this.count,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'count': count,
    };
  }

  factory Trending.fromMap(Map<String, dynamic> map) {
    return Trending(
      id: map['id'].toInt() as int,
      name: map['name'] as String,
      count: map['count'].toInt() as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory Trending.fromJson(String source) => Trending.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'Trending(id: $id, name: $name, count: $count)';

  @override
  bool operator ==(covariant Trending other) {
    if (identical(this, other)) return true;
  
    return 
      other.id == id &&
      other.name == name &&
      other.count == count;
  }

  @override
  int get hashCode => id.hashCode ^ name.hashCode ^ count.hashCode;
}