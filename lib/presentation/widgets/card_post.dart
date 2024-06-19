import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:x/business_logic/bloc/single_community_post_bloc.dart';
import 'package:x/business_logic/blocs/cubit/auth_cubit.dart';
import 'package:x/data/models/posts_list.dart';

class PostCard extends StatelessWidget {
  const PostCard({
    super.key,
    required this.posts,
    required this.index,
    required this.onTap,
  });

  final List<Postslist> posts;
  final int index;
  final void Function() onTap;

  @override
  Widget build(BuildContext context) {
    return PostTile(
      posts: posts,
      index: index,
      onTap: onTap,
    );
  }
}

class PostTile extends StatelessWidget {
  const PostTile({
    super.key,
    required this.onTap,
    required this.posts,
    required this.index,
  });

  final void Function() onTap;
  final List<Postslist> posts;
  final int index;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
     onTap: onTap,
     child: Padding(
       padding: const EdgeInsets.all(8.0),
       child: Container(
         padding: EdgeInsets.all(10),
         decoration: BoxDecoration(
           borderRadius: BorderRadius.circular(20.0),
    
           // border: Border.all(color: Colors.black, width: 0.5)
         ),
         child: Column(
           children: [
             PostHeadBar(posts: posts, index: index),
             Padding(
               padding: const EdgeInsets.only(left: 58.0),
               child: Column(
                 crossAxisAlignment: CrossAxisAlignment.start,
                 children: [
                   SizedBox(
                     height: MediaQuery.of(context).size.height * 0.02,
                   ),
                   // Text(posts[index].author.name!),
                   posts[index].content != null
                       ? Text(
                           posts[index].content!,
                           style: TextStyle(
                             fontSize: 18.0,
                           ),
                         )
                       : Container(),
                   SizedBox(
                     height: MediaQuery.of(context).size.height * 0.02,
                   ),
                   posts[index].image != null
                       ? ClipRRect(
                           borderRadius: BorderRadius.circular(16.0),
                           child: Image.network(
                             posts[index].image!,
                             fit: BoxFit.fill,
                             width: double.infinity,
                           ),
                         )
                       : Container(),
                   Row(
                     children: [
                       IconButton(
                           icon: Icon(Icons.thumb_up_sharp,
                           color: posts[index].vote == 1
                               ? Colors.blue
                               : Colors.grey,
                           ),
                           onPressed: () {
                             
                           }),
                      
                       IconButton(
                         icon: Icon(Icons.bookmark_add_outlined),
                         onPressed: () {},
                       )
                     ],
                   ),
                 ],
               ),
             ),
           ],
         ),
       ),
     ),
            );
  }
}

class PostHeadBar extends StatelessWidget {
  const PostHeadBar({
    super.key,
    required this.posts,
    required this.index,
  });

  final List<Postslist> posts;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        posts[index].author.profile_pic != null
            ? CircleAvatar(
                radius: 20,
                backgroundImage: NetworkImage(posts[index].author.profile_pic!),
              )
            : const CircleAvatar(
                radius: 20,
                child: Icon(Icons.person),
              ),
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.05,
        ),
        Text(
          posts[index].author.name!,
          style: TextStyle(
            fontWeight: FontWeight.w700,
            fontSize: 18.0,
          ),
        ),
      ],
    );
  }
}

// posts[index].author.profile_pic != null ? CircleAvatar(
//                                         backgroundImage: NetworkImage(posts[index].author.profile_pic!),
//                                       ):const CircleAvatar(
//                                         child: Icon(Icons.person),
//                                       ),