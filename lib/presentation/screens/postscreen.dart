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
import 'package:x/presentation/screens/create_post_screen.dart';
import 'package:x/presentation/screens/single_post_screen.dart';
import 'package:x/presentation/screens/userprofile_screen.dart';
import 'package:x/presentation/widgets/card_post.dart';
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

class DrawerX extends StatelessWidget {
  const DrawerX({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Drawer(
      shape: ShapeBorder.lerp(InputBorder.none, InputBorder.none, 0.0),
      width: MediaQuery.of(context).size.width * 0.8,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        // padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            decoration: BoxDecoration(
              // color: Colors.blue,
            ),
            child: BlocBuilder<UserBloc, UserState>(
                            builder: (context, state) {
                              if (state is LoadedUserState) {
             return Padding(
               padding: const EdgeInsets.all(8.0),
               child: Column(
                 crossAxisAlignment: CrossAxisAlignment.start,
                 children: [
                   state.user!.profile_pic != null
                       ? CircleAvatar(
                         backgroundImage:
                             NetworkImage(state.user!.profile_pic!),
                       )
                       : CircleAvatar(
                         child: Icon(Icons.person),
                       ),
                       SizedBox(height: MediaQuery.of(context).size.height*0.01),
                         Text(state.user!.name!,
                         style: TextStyle(
                           fontSize: 20,
                           fontWeight: FontWeight.bold),
                         ),
                         Text(state.user!.email,
                         style: TextStyle(
                          color: Colors.grey[600],
                         )
                         ),
                         Flexible(child: Text(state.user!.followers!.length.toString() + " Followers",
                         
                         ))
                         
                 ],
               ),
             );
                              } else if (state is ErrorUserState) {
             return Text(state.error!);
                              } else {
             print(state);
             return CircularProgressIndicator();
                              }
                            },
                          ),
          ),
          // Divider(
          //   height: 1,
          //   thickness: 1,
          
          // ),
          ListTile(
            leading: Icon(Icons.person),
            title: Text('Profile'),
            onTap: () {
              
              Navigator.push(context, MaterialPageRoute(builder: (context) => MultiBlocProvider(
                providers: [
                  BlocProvider(
                    create: (context) => UserBloc(
                      authToken: context.read<AuthCubit>().state.token!,
                      dio: Dio(),
                    )..add(GetInitialUserData()),
                  ),
                  BlocProvider(
                    create: (context) => PostListBloc(authToken: context.read<AuthCubit>().state.token!, dio: Dio())..add(GetUserPostsEvent()) 
                    ),
                ],
                child: Profile(),
              )));
            },
          ),
          ListTile(
            leading: Icon(Icons.bookmark),
            title: Text('Bookmarks'),
            onTap: () {
              // Handle navigation to Settings
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: Icon(Icons.list),
            title: Text('Followers'),
            onTap: () {
              // Handle navigation to Contacts
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }
}

  
