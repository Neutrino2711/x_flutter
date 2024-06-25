import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:x/business_logic/blocs/bloc/post_list_bloc.dart';
import 'package:x/business_logic/blocs/cubit/auth_cubit.dart';
import 'package:x/business_logic/blocs/user/bloc/user_bloc.dart';
import 'package:x/business_logic/user_list/bloc/userlist_bloc.dart';
import 'package:x/presentation/screens/bookmark_post_screen.dart';
import 'package:x/presentation/screens/followers_list_post.dart';
import 'package:x/presentation/screens/userprofile_screen.dart';

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
  child: SingleChildScrollView( // Wrap with SingleChildScrollView
    child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          BlocBuilder<UserBloc, UserState>(
            builder: (context, state) {
              if (state is LoadedUserState) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    state.user!.profile_pic != null
                        ? CircleAvatar(
                            backgroundImage: NetworkImage(state.user!.profile_pic!),
                          )
                        : CircleAvatar(
                            child: Icon(Icons.person),
                          ),
                    SizedBox(height: MediaQuery.of(context).size.height * 0.01),
                    Text(
                      state.user!.name!,
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    Text(state.user!.email, style: TextStyle(color: Colors.grey[600],)),
                    Text(
                      state.user!.followers!.length.toString() + " Followers",
                    )
                  ],
                );
              } else if (state is ErrorUserState) {
                return Text(state.error!);
              } else {
                return CircularProgressIndicator();
              }
            },
          ),
        ],
      ),
    ),
  ),
),
          // Divider(
          //   height: 1,
          //   thickness: 1,

          // ),
          ListTile(
            leading: Icon(Icons.person_outlined,
            size: Theme.of(context).iconTheme.copyWith(
              size: 30
            ).size,
            ),
            title: Text('Profile',
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
              // color: Colors.red
              fontSize: 20,
              fontWeight: FontWeight.bold
            
            ),
            ),
            onTap: () {
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
                                  create: (context) => PostListBloc(
                                      authToken: context
                                          .read<AuthCubit>()
                                          .state
                                          .token!,
                                      dio: Dio())
                                    ..add(GetUserPostsEvent())),
                            ],
                            child: Profile(),
                          )));
            },
          ),
          ListTile(
            leading: Icon(Icons.bookmark_border,
            size: Theme.of(context).iconTheme.copyWith(
              size: 30
            ).size,
            ),
            title: Text('Bookmarks',
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
              // color: Colors.red
              fontSize: 20,
              fontWeight: FontWeight.bold
            
            ),
            ),
            onTap: () {
              // Handle navigation to Settings
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => BlocProvider(
                      create: (context) => PostListBloc(
                          authToken: context.read<AuthCubit>().state.token!,
                          dio: Dio())
                        ..add(GetSavedPostsEvent()),
                      child: BookmarkPostScreen(),
                    ),
                  ));
            },
          ),
          ListTile(
            leading: Icon(Icons.list,
            size: Theme.of(context).iconTheme.copyWith(
              size: 30
            ).size,
            ),
            title: Text('Followers',
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
              // color: Colors.red
              fontSize: 20,
              fontWeight: FontWeight.bold
            
            ),
            ),
            onTap: () {
              // Handle navigation to Contacts
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => MultiBlocProvider(
                            providers: [
                              BlocProvider(
                                create: (context) => UserlistBloc(
                                    authToken:
                                        context.read<AuthCubit>().state.token!,
                                    dio: Dio())
                                  ..add(FollowingUserList()),
                              ),
                              BlocProvider(
                                create: (context) => PostListBloc(
                                    authToken:
                                        context.read<AuthCubit>().state.token!,
                                    dio: Dio())
                                  ..add(GetFollowingPostListEvent()),
                                ),
                              
                            ],
                            child: FollowersListPosts(),
                          )));
              // Navigator.pop(context);
            },
          ),
          ListTile(
            leading: Icon(Icons.logout,
            size: Theme.of(context).iconTheme.copyWith(
              size: 30
            ).size,
            ),
            title: Text("Log Out",
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
              // color: Colors.red
              fontSize: 20,
              fontWeight: FontWeight.bold
            
            ),),
            onTap: () {
              context.read<AuthCubit>().logout();
            },
          )
        ],
      ),
    );
  }
}
