import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:x/business_logic/bloc/create_post_bloc.dart';
import 'package:x/business_logic/bloc/single_community_post_bloc.dart';
import 'package:x/business_logic/blocs/cubit/auth_cubit.dart';
import 'package:x/business_logic/blocs/user/bloc/user_bloc.dart';
import 'package:x/data/models/posts_list.dart';
import 'package:x/presentation/screens/create_post_screen.dart';

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
    String content = posts[index].content!;
    return GestureDetector(
     onTap: onTap,
     child: Padding(
       padding: const EdgeInsets.all(8.0),
       child: Column(
         children: [
           PostHeadBar(posts: posts, index: index),
           Padding(
             padding: const EdgeInsets.only(left: 58.0),
             child: Column(
               crossAxisAlignment: CrossAxisAlignment.start,
               children: [
                //  SizedBox(
                //    height: MediaQuery.of(context).size.height * 0.01,
                //  ),
                 // Text(posts[index].author.name!),
                 
                 posts[index].content != null
                     ? Text(
                   content.length>100?content.substring(0,100):content,
                         style: TextStyle(
                           fontSize: 18.0,
                         ),
                       )
                     : Container(),
                 SizedBox(
                   height: MediaQuery.of(context).size.height * 0.01,
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
                  // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                   children: [
                     IconButton(
                         icon: Icon(Icons.thumb_up_sharp,
                         color: posts[index].vote == 1
                             ? Colors.blue
                             : Colors.grey,
                         ),
                         onPressed: () {
                           print(posts[index]);
                         }),
                    
                     IconButton(
                       icon: Icon(Icons.chat_bubble_outline,
                       
                       ),
                       onPressed: () {
                          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => MultiBlocProvider(
                      providers: [
                        BlocProvider(
               create: (context) => UserBloc(
          authToken: context.read<AuthCubit>().state.token!, dio: Dio())..add(GetInitialUserData()),
             ),
             BlocProvider(
               create: (context) => CreatePostBloc(
          authToken: context.read<AuthCubit>().state.token!, dio: Dio()),
             ),
            
           
                      ],
                      child: CreatePostScreen(parentId: posts[index].parent,),
                    )));
                       },
                     ),
                    Text(posts[index].created_at.toString().substring(11,19),
                     style: Theme.of(context).textTheme.bodyMedium?.copyWith(
            color: Colors.grey,)
                    ),
                   ],
                 ),
               ],
             ),
           ),
         ],
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
    final date = DateTime.parse( posts[index].created_at);
    DateTime now = DateTime.now().toUtc();

    print(now.difference(date).inDays);
    print(date);
    if(posts[index].author.name==null)
    {
      print(posts[index]);
    }
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        posts[index].author.profile_pic != null
            ? CircleAvatar(
                radius: MediaQuery.of(context).size.width * 0.06,
                backgroundImage: NetworkImage(posts[index].author.profile_pic!),
              )
            :  CircleAvatar(
                radius: MediaQuery.of(context).size.width * 0.06,
                child: Icon(Icons.person),
              ),
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.02,
        ),
        Text(
          
          posts[index].author.name!,
          style: TextStyle(
            fontWeight: FontWeight.w700,
            fontSize: 18.0,
          ),
        ),
         SizedBox(
          width: MediaQuery.of(context).size.width * 0.025,
        ),
        Text(
          posts[index].author.email,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
            color: Colors.grey,
          ),
        ),
         SizedBox(
          width: MediaQuery.of(context).size.width * 0.025,
        ),
        Text(now.difference(date).inDays>0?now.difference(date).inDays.toString()+'d':now.difference(date).inHours.toString()+'h',
         style: Theme.of(context).textTheme.bodyMedium?.copyWith(
            color: Colors.grey,
        ),),
        // Text(DateTime.now() > Duration(days: 1)?posts[index].created_at.toString().substring(0,10):posts[index].created_at.toString().substring(11,16)),
      ],
    );
  }
}

// posts[index].author.profile_pic != null ? CircleAvatar(
//                                         backgroundImage: NetworkImage(posts[index].author.profile_pic!),
//                                       ):const CircleAvatar(
//                                         child: Icon(Icons.person),
//                                       ),