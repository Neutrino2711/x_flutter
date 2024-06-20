import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:x/business_logic/blocs/bloc/post_list_bloc.dart';
import 'package:x/data/models/posts_list.dart';
import 'package:x/presentation/widgets/post_list_widget.dart';

class BookmarkPostScreen extends StatelessWidget {
  const BookmarkPostScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Bookmarks"),
        
        ),
      body: BlocBuilder<PostListBloc, PostListState>(
            builder: (context, state) {
              if (state is PostListLoaded) {
                List<Postslist> posts = state.postsList;
                print(posts);
                return PostsListWidget(posts: posts);
              } else if (state is PostListError) {
                return Text(state.message);
              } else {
                return Center(child: CircularProgressIndicator());
              }
            },
          ),
      );
  }
}