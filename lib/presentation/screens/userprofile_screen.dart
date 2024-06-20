import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:x/business_logic/blocs/bloc/post_list_bloc.dart';
import 'package:x/business_logic/blocs/user/bloc/user_bloc.dart';
import 'package:x/data/models/posts_list.dart';
import 'package:x/presentation/widgets/post_list_widget.dart';  // Example of another BLoC

class Profile extends StatelessWidget {
  const Profile({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          // padding: const EdgeInsets.all(8.0),
          children: <Widget>[
            // BlocBuilder for UserBloc
            BlocBuilder<UserBloc, UserState>(
              builder: (context, userState) {
                if (userState is LoadedUserState) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      userState.user!.profile_pic != null
                          ? CircleAvatar(
                              backgroundImage: NetworkImage(userState.user!.profile_pic!),
                              radius: 40,
                            )
                          : CircleAvatar(
                              radius: 40,
                              child: Icon(Icons.person, size: 40),
                            ),
                      SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                      Text(
                        userState.user!.name!,
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        userState.user!.email,
                        style: TextStyle(
                          color: Colors.grey[600],
                        ),
                      ),
                      SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                      Text(
                        "${userState.user!.followers!.length} Followers",
                        style: TextStyle(fontSize: 16),
                      ),
                      SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                      Text(
                        "Posts",
                        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                    ],
                  );
                } else if (userState is ErrorUserState) {
                  return Center(child: Text(userState.error!));
                } else {
                  return Center(child: CircularProgressIndicator());
                }
              },
            ),
            // Divider to separate content
            Divider(thickness: 1),
            // BlocBuilder for AnotherBloc
           BlocBuilder<PostListBloc, PostListState>(
            builder: (context, state) {
              if (state is PostListLoaded) {
                List<Postslist> posts = state.postsList;
                return Expanded(child: PostsListWidget(posts: posts));
              } else if (state is PostListError) {
                return Text(state.message);
              } else {
                return Center(child: CircularProgressIndicator());
              }
            },
          ),
          ],
        ),
      ),
    );
  }
}
