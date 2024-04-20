import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:x/business_logic/blocs/bloc/post_list_bloc.dart';
import 'package:x/business_logic/blocs/cubit/auth_cubit.dart';
import 'package:x/data/models/posts_list.dart';

class PostScreen extends StatelessWidget {
  const PostScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create:(context) => PostListBloc(authToken: context.read<AuthState>().token!,dio: Dio(),savedPosts: false,myPosts: true),
      child:  Scaffold (
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                BlocBuilder<PostListBloc,PostListState>
                (
                  builder: (context, state) {
                    if(state is PostListLoaded)
                    {
                      List<Postslist> posts = state.postsList;

                         return ListView.builder(
                          shrinkWrap: true,
                          itemCount: posts.length,
                          itemBuilder: (context, index) {
                            return ListTile(
                              title: Text(posts[index].author.name),
                              subtitle: Text(posts[index].content),
                            );
                          },);
                    }
                    else if (state is PostListError)
                    {
                      return Text(state.message);
                    }
                    else
                    {
                      return CircularProgressIndicator();
                    }
                    
                }

                )
              ],
            ),
          )
        ),
      )

    );
    
  }
}