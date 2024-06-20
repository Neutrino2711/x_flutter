import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:x/business_logic/bloc/comment_bloc.dart';
import 'package:x/business_logic/bloc/create_post_bloc.dart';
import 'package:x/business_logic/bloc/single_community_post_bloc.dart';
import 'package:x/business_logic/blocs/bloc/post_list_bloc.dart';
import 'package:x/business_logic/blocs/cubit/auth_cubit.dart';
import 'package:x/business_logic/blocs/user/bloc/user_bloc.dart';
import 'package:x/data/models/post.dart';
import 'package:x/data/models/posts_list.dart';
import 'package:x/presentation/screens/bookmark_post_screen.dart';
import 'package:x/presentation/screens/create_post_screen.dart';
import 'package:x/presentation/screens/single_post_screen.dart';
import 'package:x/presentation/screens/userprofile_screen.dart';
import 'package:x/presentation/widgets/card_post.dart';
import 'package:x/presentation/widgets/drawer.dart';
import 'package:x/presentation/widgets/post_list_widget.dart';

// class PostScreen extends StatelessWidget {
//   const PostScreen({super.key,});

class PostScreen extends StatefulWidget {
  const PostScreen({Key? key}) : super(key: key);

  @override
  _PostScreenState createState() => _PostScreenState();
}

class _PostScreenState extends State<PostScreen> {
  bool isFollowing = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        shape: CircleBorder(),
        child: Icon(Icons.edit),
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => MultiBlocProvider(
                        providers: [
                          BlocProvider(
                            create: (context) => UserBloc(
                              authToken:
                                  context.read<AuthCubit>().state.token!,
                              dio: Dio(),
                            )..add(GetInitialUserData()),
                          ),
                          BlocProvider(
                            create: (context) => CreatePostBloc(
                              authToken:
                                  context.read<AuthCubit>().state.token!,
                              dio: Dio(),
                            ),
                          ),
                        ],
                        child: CreatePostScreen(),
                      )));
        },
      ),
      drawer:  DrawerX(),
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'X',
          style: TextStyle(
            color: Colors.black,
            fontSize: 30.0,
            fontWeight: FontWeight.bold,
            fontStyle: FontStyle.normal,
            fontFamily: 'Pacifico',
          ),
        ),
        
        actions: [
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: () {
              context.read<PostListBloc>().add(isFollowing?GetFollowingPostListEvent(): GetPostListEvent());
            },
          ),
        ],
        
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(50.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              TextButton(
                child: const Text(
                  'All Posts',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                onPressed: () {
                  setState(() {
                    isFollowing = false;
                  });
                  context.read<PostListBloc>().add(GetPostListEvent());
                },
              ),
              TextButton(
                child: const Text(
                  'Following',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                onPressed: () {
                  setState(() {
                    isFollowing = true;
                  });
                  context.read<PostListBloc>().add(GetFollowingPostListEvent());
                },
              ),
            ],
          ),
        ),
      ),
      body: SafeArea(
        child: BlocBuilder<PostListBloc, PostListState>(
          builder: (context, state) {
            if (state is PostListLoaded) {
              List<Postslist> posts = state.postsList;
              return PostsListWidget(posts: posts);
            } else if (state is PostListError) {
              return Text(state.message);
            } else {
              return Center(child: CircularProgressIndicator());
            }
          },
        ),
      ),
    );
  }
}
