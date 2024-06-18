import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:x/business_logic/bloc/comment_bloc.dart';
import 'package:x/business_logic/bloc/single_community_post_bloc.dart';
import 'package:x/business_logic/blocs/bloc/post_list_bloc.dart';
import 'package:x/business_logic/blocs/cubit/auth_cubit.dart';
import 'package:x/business_logic/blocs/user/bloc/user_bloc.dart';
import 'package:x/data/models/post.dart';
import 'package:x/data/models/posts_list.dart';
import 'package:x/data/models/single_post.dart';
import 'package:x/presentation/screens/postscreen.dart';
import 'package:x/presentation/widgets/card_post.dart';
import 'package:intl/intl.dart';
import 'package:x/presentation/widgets/post_list_widget.dart';

class SinglePostScreen extends StatelessWidget {
  const SinglePostScreen({super.key,required this.postId});

  final int postId;

  List<String> TimeSplit(String iso){
    DateTime dateTime = DateTime.parse(iso);
    // Formatting the date
    String formattedDate = DateFormat('yyyy-MM-dd').format(dateTime);
    // Formatting the time
    String formattedTime = DateFormat('HH:mm:ss').format(dateTime);
    return [formattedDate,formattedTime];
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
                  appBar: AppBar(
    title: Text('Post'),
    actions: [],
                  ),
                  body: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        BlocBuilder<UserBloc, UserState>(
                                        builder: (context, state) {
                                          if (state is LoadedUserState) {
                                            return state.user!.profile_pic != null
                          ? Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              CircleAvatar(
                                backgroundImage:
                                    NetworkImage(state.user!.profile_pic!),
                              ),
                              SizedBox(width: MediaQuery.of(context).size.width * 0.05,),
                              Text(state.user!.name!,
                              style: TextStyle(
                                fontWeight: FontWeight.w300,
                                fontSize: 18.0,),
                              ),
                            ],
                          )
                          : CircleAvatar(
                            child: Icon(Icons.person),
                          );
                                          } else if (state is ErrorUserState) {
                                            return Text(state.error!);
                                          } else {
                                            print(state);
                                            return CircularProgressIndicator();
                                          }
                                        },
                                      ),
                                      SizedBox(
                                        height: MediaQuery.of(context).size.height * 0.02,
                                      ),
                      BlocBuilder<SingleCommunityPostBloc, SingleCommunityPostState>(
                            builder: (context, state) {
                          if (state is SingleCommunityPostLoaded) {
                            SinglePost post = state.post;
                            List<String> dateTime = TimeSplit(post.created_at);
                            return PostDetailWidget(post: post, dateTime: dateTime);
                            
                                
                      
                             
                              
                          } else if (state is SingleCommunityPostError) {
                            return Text(state.message);
                          } else {
                            return CircularProgressIndicator();
                          }
                        }
                        ) ,
                          //Comment Section
                          BlocBuilder<CommentBloc, CommentState>(
                              builder: (context, state) {
                            if (state is CommentLoaded) {
                              List<Postslist> posts = state.comments;
                              print(posts.length);
                              return Expanded(
                                child: PostsListWidget(posts: posts),
                              );
                            } else if (state is CommentError) {
                              return Text(state.message);
                            } else {
                              return CircularProgressIndicator();
                            }
                          }),
                                        
                                               
                      ],
                      ),
                  ),);
  }
}

class PostDetailWidget extends StatelessWidget {
  const PostDetailWidget({
    super.key,
    required this.post,
    required this.dateTime,
  });

  final SinglePost post;
  final List<String> dateTime;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
              Text(post.content!,
              style: TextStyle(
                fontWeight: FontWeight.w300,
                fontSize: 18.0,
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.02,),
               post.image != null ?  Padding(
                 padding: const EdgeInsets.all(8.0),
                 child: ClipRRect(
                               borderRadius: BorderRadius.circular(16.0),
                               child: Image.network(
                  post.image!,
                  fit: BoxFit.fill,
                  width: double.infinity,
                               ),
                             ),
               )
                            : Container(
                            ),
                //             SizedBox(
                // height: MediaQuery.of(context).size.height * 0.02,),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start  ,
                              children: [
                                
                                Padding(
      padding: const EdgeInsets.only(right: 8.0),
      child: Text(dateTime[0]),
                                ),
                                // Text("."),
                                Padding(
      padding: const EdgeInsets.only(right: 8.0),
      child: Text(dateTime[1]),
                                ),
                              ],
              
                            ),
                            Divider(
                              thickness: 1,
                            ),
                            Row(children: [
                              Text("${post.score} Votes"),
                            ],),
                              Divider(
                              thickness: 1,
                            ),
                            Row(
                              children: [
                                IconButton(
        icon: const Icon(Icons.arrow_upward), onPressed: () {}),
                                IconButton(
        icon: const Icon(Icons.comment), onPressed: () {}),
        //                         IconButton(
        // icon: const Icon(Icons.share), onPressed: () {}),
                              ],
                            ),
                              ],
      ),
    );
  }
}