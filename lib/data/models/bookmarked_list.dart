import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:x/data/models/posts_list.dart';
import 'package:x/data/models/user.dart';

class Bookmarkedlist {
  final int id;
  final User author;
  final int score;
  final int? vote;
  final String detail_url;
  final String content;
  final String? image;
  final String created_at;
  final String updated_at;
  final int depth;
  final Postslist? parent;
  final List<dynamic> hastags;
  Bookmarkedlist({
    required this.id,
    required this.author,
    required this.score,
     this.vote,
    required this.detail_url,
    required this.content,
 this.image,
    required this.created_at,
    required this.updated_at,
    required this.depth,
     this.parent,
    required this.hastags,
  });

  Bookmarkedlist copyWith({
    int? id,
    User? author,
    int? score,
    int? vote,
    String? detail_url,
    String? content,
    String? image,
    String? created_at,
    String? updated_at,
    int? depth,
    Postslist? parent,
    List<dynamic>? hastags,
  }) {
    return Bookmarkedlist(
      id: id ?? this.id,
      author: author ?? this.author,
      score: score ?? this.score,
      vote: vote ?? this.vote,
      detail_url: detail_url ?? this.detail_url,
      content: content ?? this.content,
      image: image ?? this.image,
      created_at: created_at ?? this.created_at,
      updated_at: updated_at ?? this.updated_at,
      depth: depth ?? this.depth,
      parent: parent ?? this.parent,
      hastags: hastags ?? this.hastags,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'author': author.toMap(),
      'score': score,
      'vote': vote,
      'detail_url': detail_url,
      'content': content,
      'image': image,
      'created_at': created_at,
      'updated_at': updated_at,
      'depth': depth,
      'parent': parent!.toMap(),
      'hastags': hastags,
    };
  }

  factory Bookmarkedlist.fromMap(Map<String, dynamic> map) {
    return Bookmarkedlist(
      id: map['id'].toInt() as int,
      author: User.fromMap(map['author'] as Map<String,dynamic>),
      score: map['score'].toInt() as int,
      vote: map['vote'].toInt() as int,
      detail_url: map['detail_url'] as String,
      content: map['content'] as String,
      image:map['image'] as String,
      created_at: map['created_at'] as String,
      updated_at: map['updated_at'] as String,
      depth: map['depth'].toInt() as int,
      parent: Postslist.fromMap(map['parent'] as Map<String,dynamic>),
      hastags: List<dynamic>.from((map['hastags'] as List<dynamic>),
    ));
  }

  String toJson() => json.encode(toMap());

  factory Bookmarkedlist.fromJson(String source) => Bookmarkedlist.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Bookmarkedlist(id: $id, author: $author, score: $score, vote: $vote, detail_url: $detail_url, content: $content, image: $image, created_at: $created_at, updated_at: $updated_at, depth: $depth, parent: $parent, hastags: $hastags)';
  }

  @override
  bool operator ==(covariant Bookmarkedlist other) {
    if (identical(this, other)) return true;
  
    return 
      other.id == id &&
      other.author == author &&
      other.score == score &&
      other.vote == vote &&
      other.detail_url == detail_url &&
      other.content == content &&
      other.image == image &&
      other.created_at == created_at &&
      other.updated_at == updated_at &&
      other.depth == depth &&
      other.parent == parent &&
      listEquals(other.hastags, hastags);
  }

  @override
  int get hashCode {
    return id.hashCode ^
      author.hashCode ^
      score.hashCode ^
      vote.hashCode ^
      detail_url.hashCode ^
      content.hashCode ^
      image.hashCode ^
      created_at.hashCode ^
      updated_at.hashCode ^
      depth.hashCode ^
      parent.hashCode ^
      hastags.hashCode;
  }
}
