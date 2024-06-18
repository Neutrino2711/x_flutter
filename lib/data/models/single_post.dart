import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:x/data/models/user.dart';

class SinglePost {
  final int id;
  final User author;
  final int upvotes;
  final int downvotes;
  final int? score;
  final bool is_bookmarked;
  final int? vote;
  final String? content;
  final String? image;
  final String created_at;
  final String updated_at;
  final int? depth;
  final int? parent;
  final List<dynamic> hastags;
  SinglePost({
    required this.id,
    required this.author,
    required this.upvotes,
    required this.downvotes,
    required this.score,
    required this.is_bookmarked,
    required this.vote,
    required this.content,
    required this.image,
    required this.created_at,
    required this.updated_at,
    required this.depth,
    required this.parent,
    required this.hastags,
  });

  SinglePost copyWith({
    int? id,
    User? author,
    int? upvotes,
    int? downvotes,
    int? score,
    bool? is_bookmarked,
    int? vote,
    String? content,
    String? image,
    String? created_at,
    String? updated_at,
    int? depth,
    int? parent,
    List<dynamic>? hastags,
  }) {
    return SinglePost(
      id: id ?? this.id,
      author: author ?? this.author,
      upvotes: upvotes ?? this.upvotes,
      downvotes: downvotes ?? this.downvotes,
      score: score ?? this.score,
      is_bookmarked: is_bookmarked ?? this.is_bookmarked,
      vote: vote ?? this.vote,
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
      'upvotes': upvotes,
      'downvotes': downvotes,
      'score': score,
      'is_bookmarked': is_bookmarked,
      'vote': vote,
      'content': content,
      'image': image,
      'created_at': created_at,
      'updated_at': updated_at,
      'depth': depth,
      'parent': parent!,
      'hastags': hastags,
    };
  }

  factory SinglePost.fromMap(Map<String, dynamic> map) {
    return SinglePost(
      id: map['id'].toInt() as int,
      author: User.fromMap(map['author'] as Map<String,dynamic>),
      upvotes: map['upvotes'].toInt() as int,
      downvotes: map['downvotes'].toInt() as int,
      score: map['score'].toInt() as int,
      is_bookmarked: map['is_bookmarked'] as bool,
      vote: (map['vote']?.toInt()),
      content: map['content'] as String,
      image: (map['image']?.toString()),
      created_at: map['created_at'] as String,
      updated_at: map['updated_at'] as String,
      depth: map['depth'].toInt() as int,
      parent: map['parent']?.toInt() as int?,
      hastags: List<dynamic>.from((map['hastags'] as List<dynamic>),
    ));
  }

  String toJson() => json.encode(toMap());

  factory SinglePost.fromJson(String source) => SinglePost.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'SinglePost(id: $id, author: $author, upvotes: $upvotes, downvotes: $downvotes, score: $score, is_bookmarked: $is_bookmarked, vote: $vote, content: $content, image: $image, created_at: $created_at, updated_at: $updated_at, depth: $depth, parent: $parent, hastags: $hastags)';
  }

  @override
  bool operator ==(covariant SinglePost other) {
    if (identical(this, other)) return true;
  
    return 
      other.id == id &&
      other.author == author &&
      other.upvotes == upvotes &&
      other.downvotes == downvotes &&
      other.score == score &&
      other.is_bookmarked == is_bookmarked &&
      other.vote == vote &&
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
      upvotes.hashCode ^
      downvotes.hashCode ^
      score.hashCode ^
      is_bookmarked.hashCode ^
      vote.hashCode ^
      content.hashCode ^
      image.hashCode ^
      created_at.hashCode ^
      updated_at.hashCode ^
      depth.hashCode ^
      parent.hashCode ^
      hastags.hashCode;
  }
}
