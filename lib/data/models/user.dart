import 'dart:convert';

import 'package:flutter/foundation.dart';

class User {
  final int id;
  final String email;
  final String? name;
  final String? city;
  final String? dob;
  final String? bio;
  final String joined;
  final List<int>? followers;
  final String? profile_pic;
  User({
    required this.id,
    required this.email,
    this.name,
    this.city,
    this.dob,
    this.bio,
    required this.joined,
    this.followers,
    this.profile_pic,
  });

  User copyWith({
    int? id,
    String? email,
    String? name,
    String? city,
    String? dob,
    String? bio,
    String? joined,
    List<int>? followers,
    String? profile_pic,
  }) {
    return User(
      id: id ?? this.id,
      email: email ?? this.email,
      name: name ?? this.name,
      city: city ?? this.city,
      dob: dob ?? this.dob,
      bio: bio ?? this.bio,
      joined: joined ?? this.joined,
      followers: followers ?? this.followers,
      profile_pic: profile_pic ?? this.profile_pic,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'email': email,
      'name': name,
      'city': city,
      'dob': dob,
      'bio': bio,
      'joined': joined,
      'followers': followers,
      'profile_pic': profile_pic,
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      id: map['id'] as int,
      email: map['email'] as String,
      name: map['name'] as String?,
      city: map['city'] as String?,
      dob: map['dob'] as String?,
      bio: map['bio'] as String?,
      joined: map['joined'] as String,
      followers: (map['followers'] as List<dynamic>?)?.map((item) => item as int).toList(),
      profile_pic: map['profile_pic'] as String?,
    );
  }

  String toJson() => json.encode(toMap());

  factory User.fromJson(String source) => User.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'User(id: $id, email: $email, name: $name, city: $city, dob: $dob, bio: $bio, joined: $joined, followers: $followers, profile_pic: $profile_pic)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is User &&
      other.id == id &&
      other.email == email &&
      other.name == name &&
      other.city == city &&
      other.dob == dob &&
      other.bio == bio &&
      other.joined == joined &&
      listEquals(other.followers, followers) &&
      other.profile_pic == profile_pic;
  }

  @override
  int get hashCode {
    return id.hashCode ^
      email.hashCode ^
      (name?.hashCode ?? 0) ^
      (city?.hashCode ?? 0) ^
      (dob?.hashCode ?? 0) ^
      (bio?.hashCode ?? 0) ^
      joined.hashCode ^
      (followers?.hashCode ?? 0) ^
      (profile_pic?.hashCode ?? 0);
  }
}