import 'dart:convert';

class User {
  final int id;
  final String email;
  final String name;
  final String? city;
  final String? dob;
  final String? bio;
  final String joined;
  final int followers;
  final int following;
  final String? profile_pic;
  User({
    required this.id,
    required this.email,
    required this.name,
    required this.city,
    required this.dob,
    required this.bio,
    required this.joined,
    required this.followers,
    required this.following,
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
    int? followers,
    int? following,
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
      following: following ?? this.following,
      profile_pic: profile_pic ?? this.profile_pic,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'email': email,
      'name': name,
      'city': city,
      'dob': dob,
      'bio': bio,
      'joined': joined,
      'followers': followers,
      'following': following,
      'profile_pic': profile_pic,
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      id: map['id']?.toInt() as int,
      email: map['email'] as String,
      name: map['name'] as String,
      city: map['city']?.toString() as String?,
      dob: map['dob']?.toString() as String?,
      bio: map['bio']?.toString() as String?,
      joined: map['joined'] as String,
      followers: map['followers'].toInt() as int,
      following: map['following'].toInt() as int,
      profile_pic: (map['profile_pic']?.toString() as String?),
    );
  }

  String toJson() => json.encode(toMap());

  factory User.fromJson(String source) => User.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'UserProfile(id: $id, email: $email, name: $name, city: $city, dob: $dob, bio: $bio, joined: $joined, followers: $followers, following: $following, profile_pic: $profile_pic)';
  }

  @override
  bool operator ==(covariant User other) {
    if (identical(this, other)) return true;
  
    return 
      other.id == id &&
      other.email == email &&
      other.name == name &&
      other.city == city &&
      other.dob == dob &&
      other.bio == bio &&
      other.joined == joined &&
      other.followers == followers &&
      other.following == following &&
      other.profile_pic == profile_pic;
  }

  @override
  int get hashCode {
    return id.hashCode ^
      email.hashCode ^
      name.hashCode ^
      city.hashCode ^
      dob.hashCode ^
      bio.hashCode ^
      joined.hashCode ^
      followers.hashCode ^
      following.hashCode ^
      profile_pic.hashCode;
  }
}