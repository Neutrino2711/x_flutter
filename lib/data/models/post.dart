import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:x/data/models/user.dart';

class Post {
  final int id;
  final User author;
  final int upvotes;
  final int downvotes;
  final int score;
  final bool is_bookmarked;
  final int? vote;
  final String content;
  final String? image;
  final String created_at;
  final String updated_at;
  final int depth;
  final Post? parent;
  final List<dynamic> hastags;
  Post({
    required this.id,
    required this.author,
    required this.upvotes,
    required this.downvotes,
    required this.score,
    required this.is_bookmarked,
     this.vote,
    required this.content,
     this.image,
    required this.created_at,
    required this.updated_at,
    required this.depth,
     this.parent,
    required this.hastags,
  });

  Post copyWith({
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
    Post? parent,
    List<dynamic>? hastags,
  }) {
    return Post(
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
      'parent': parent!.toMap(),
      'hastags': hastags,
    };
  }

  factory Post.fromMap(Map<String, dynamic> map) {
    return Post(
      id: map['id'].toInt() as int,
      author: User.fromMap(map['author'] as Map<String,dynamic>),
      upvotes: map['upvotes'].toInt() as int,
      downvotes: map['downvotes'].toInt() as int,
      score: map['score'].toInt() as int,
      is_bookmarked: map['is_bookmarked'] as bool,
      vote: map['vote'].toInt() as int,
      content: map['content'] as String,
      image: map['image'] as String,
      created_at: map['created_at'] as String,
      updated_at: map['updated_at'] as String,
      depth: map['depth'].toInt() as int,
      parent: Post.fromMap(map['parent'] as Map<String,dynamic>),
      hastags: List<dynamic>.from((map['hastags'] as List<dynamic>),
    ));
  }

  String toJson() => json.encode(toMap());

  factory Post.fromJson(String source) => Post.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Post(id: $id, author: $author, upvotes: $upvotes, downvotes: $downvotes, score: $score, is_bookmarked: $is_bookmarked, vote: $vote, content: $content, image: $image, created_at: $created_at, updated_at: $updated_at, depth: $depth, parent: $parent, hastags: $hastags)';
  }

  @override
  bool operator ==(covariant Post other) {
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