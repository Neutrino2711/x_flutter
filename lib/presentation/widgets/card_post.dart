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
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            PostHeadBar(posts: posts, index: index),
            Padding(
              padding: const EdgeInsets.only(left: 58.0, top: 8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (posts[index].content != null)
                    Text(
                      content.length > 100 ? '${content.substring(0, 100)}...' : content,
                      style:const TextStyle(
                        fontSize: 16.0,
                      ),
                    ),
                  const SizedBox(height: 8.0),
                  if (posts[index].image != null)
                    ClipRRect(
                      borderRadius: BorderRadius.circular(16.0),
                      child: Image.network(
                        posts[index].image!,
                        fit: BoxFit.cover,
                        width: double.infinity,
                      ),
                    ),
                  const SizedBox(height: 8.0),
                  Row(
                    children: [
                      IconButton(
                        icon: Icon(
                          Icons.thumb_up_sharp,
                          color: posts[index].vote == 1 ? Colors.blue : Colors.grey,
                        ),
                        onPressed: () {
                          // print(posts[index]);
                        },
                      ),
                      IconButton(
                        icon:const Icon(Icons.chat_bubble_outline),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => MultiBlocProvider(
                                providers: [
                                  BlocProvider(
                                    create: (context) => UserBloc(
                                      authToken: context.read<AuthCubit>().state.token!,
                                      dio: Dio(),
                                    )..add(GetInitialUserData()),
                                  ),
                                  BlocProvider(
                                    create: (context) => CreatePostBloc(
                                      authToken: context.read<AuthCubit>().state.token!,
                                      dio: Dio(),
                                    ),
                                  ),
                                ],
                                child: CreatePostScreen(parentId: posts[index].parent),
                              ),
                            ),
                          );
                        },
                      ),
                      Text(
                        posts[index].created_at.toString().substring(11, 19),
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              color: Colors.grey,
                            ),
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
    final date = DateTime.parse(posts[index].created_at);
    DateTime now = DateTime.now().toUtc();
    String timeDifference = now.difference(date).inDays > 0
        ? '${now.difference(date).inDays}d'
        : '${now.difference(date).inHours}h';

    return Row(
      children: [
        posts[index].author.profile_pic != null
            ? CircleAvatar(
                radius: 24.0,
                backgroundImage: NetworkImage(posts[index].author.profile_pic!),
              )
            :const CircleAvatar(
                radius: 24.0,
                child: Icon(Icons.person),
              ),
        const SizedBox(width: 12.0),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                posts[index].author.name ?? "Unknown",
                style:const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16.0,
                ),
                overflow: TextOverflow.ellipsis,
              ),
              Text(
                '${posts[index].author.email} • $timeDifference',
                style:const  TextStyle(
                  color: Colors.grey,
                  fontSize: 14.0,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
