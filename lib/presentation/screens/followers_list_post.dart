import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:x/business_logic/blocs/bloc/post_list_bloc.dart';
import 'package:x/business_logic/user_list/bloc/userlist_bloc.dart';
import 'package:x/data/models/post.dart';
import 'package:x/data/models/posts_list.dart';
import 'package:x/presentation/widgets/post_list_widget.dart';

class FollowersListPosts extends StatelessWidget {
  const FollowersListPosts({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Followers and Posts'),
      ),
      body: Column(
        children: [
          Container(
            height: 120, // Adjust the height as needed
            child: BlocBuilder<UserlistBloc, UserlistState>(
              builder: (context, state) {
                ;
                if (state is UserlistLoaded) {
                  bool empty = state.users.isEmpty;
                  return empty
                      ? Center(child: Text("Please Follow Someone"))
                      : ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: state.users.length,
                          itemBuilder: (context, index) {
                            return Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: CircleAvatar(
                                    radius: 30,
                                    child: state.users[index].profile_pic==null?Icon(Icons.person):null,
                                    backgroundImage: state.users[index].profile_pic==null? null: NetworkImage(state.users[index].profile_pic!), // Uncomment and replace with actual image
                                  ),
                                ),
                                Text(state.users[index].name!),
                              ],
                            );
                          },
                        );
                } else if (state is UserlistError) {
                  return Text(state.message);
                } else if (state is UserlistLoading) {
                  return Center(child: CircularProgressIndicator());
                } else {
                  return Center(child: CircularProgressIndicator());
                }
              },
            ),
          ),
          Expanded(
            child: BlocBuilder<PostListBloc, PostListState>(
              builder: (context, state) {
                if (state is PostListError) {
                  return Text(state.message);
                } else if (state is PostListLoading) {
                  return Center(child: CircularProgressIndicator());
                }
                else if (state is PostListLoaded)
                {
                  List<Postslist> posts = state.postsList;
                  return posts.isEmpty?Center(child: Text("Please Follow Someone")): PostsListWidget(posts: posts);
                }
                else
                {
                  return Center(child: CircularProgressIndicator());
                }
                
              },
            ),
          ),
        ],
      ),
    );
  }
}
