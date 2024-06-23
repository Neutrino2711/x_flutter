import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:x/business_logic/bloc/comment_bloc.dart';
import 'package:x/business_logic/bloc/single_community_post_bloc.dart';
import 'package:x/business_logic/blocs/bloc/post_list_bloc.dart';
import 'package:x/business_logic/blocs/cubit/auth_cubit.dart';
import 'package:x/business_logic/blocs/user/bloc/user_bloc.dart';
import 'package:x/data/models/posts_list.dart';
import 'package:x/presentation/screens/single_post_screen.dart';
import 'package:x/presentation/widgets/card_post.dart';

class PostsListWidget extends StatelessWidget {
  const PostsListWidget({
    super.key,
    required this.posts,
  });

  final List<Postslist> posts;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      separatorBuilder: (context, index) => Divider(
        height: MediaQuery.of(context).size.height * 0.01,
        color: Colors.grey,
      ),
      shrinkWrap: true,
      itemCount: posts.length,
      itemBuilder: (context, index) {
        return PostCard(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => MultiBlocProvider(
                  providers: [
                    BlocProvider<SingleCommunityPostBloc>(
                      create: (context) => SingleCommunityPostBloc(
                          postId: posts[index].id,
                          dio: Dio(),
                          authToken:
                              context.read<AuthCubit>().state.authToken!)
                        ..add(GetSingleCommunityPostEvent()),
                    ),
                    BlocProvider(
                      create: (context) => UserBloc(
                          authToken:
                              context.read<AuthCubit>().state.authToken!,
                          dio: Dio())
                        ..add(GetInitialUserData()),
                    ),
                    BlocProvider(
                      create: (context) => PostListBloc(
                          authToken:
                              context.read<AuthCubit>().state.authToken!,
                          dio: Dio())
                        ..add(GetPostListEvent()),
                    ),
                    BlocProvider(
                      create: (context) => CommentBloc(
                          authToken: context.read<AuthCubit>().state.token!,
                          dio: Dio())
                        ..add(
                          GetCommentListEvent(posts[index].id),
                        ),
                    ),
                  ],
                  child: SinglePostScreen(
                    postId: posts[index].id,
                  ),
                ),
              ),
            );
          },
          posts: posts,
          index: index,
        );
      },
    );
  }
}
