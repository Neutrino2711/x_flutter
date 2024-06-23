import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:x/business_logic/bloc/comment_bloc.dart';
import 'package:x/business_logic/bloc/create_post_bloc.dart';
import 'package:x/business_logic/bloc/single_community_post_bloc.dart';
import 'package:x/business_logic/blocs/bloc/post_list_bloc.dart';
import 'package:x/business_logic/blocs/cubit/auth_cubit.dart';
import 'package:x/business_logic/blocs/user/bloc/user_bloc.dart';
import 'package:x/data/models/post.dart';
import 'package:x/data/models/posts_list.dart';
import 'package:x/data/models/single_post.dart';
import 'package:x/presentation/screens/create_post_screen.dart';
import 'package:x/presentation/screens/postscreen.dart';
import 'package:x/presentation/widgets/card_post.dart';
import 'package:intl/intl.dart';
import 'package:x/presentation/widgets/post_list_widget.dart';

class SinglePostScreen extends StatefulWidget {
  const SinglePostScreen({super.key,required this.postId});

  final int postId;

  @override
  State<SinglePostScreen> createState() => _SinglePostScreenState();
}

class _SinglePostScreenState extends State<SinglePostScreen> {

   final ScrollController _scrollController = ScrollController();
  bool _showBottomSheet = true;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_scrollListener);
  }

  void _scrollListener() {
    if (_scrollController.position.userScrollDirection == ScrollDirection.reverse) {
      if (_showBottomSheet) {
        setState(() {
          _showBottomSheet = false;
        });
      }
    } else if (_scrollController.position.userScrollDirection == ScrollDirection.forward) {
      if (!_showBottomSheet) {
        setState(() {
          _showBottomSheet = true;
        });
      }
    }
  }

    @override
  void dispose() {
    _scrollController.removeListener(_scrollListener);
    _scrollController.dispose();
    super.dispose();
  }


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
      bottomSheet: _showBottomSheet? Container(
        decoration: BoxDecoration(
          color: Colors.black,
          border: Border.all(color: Colors.grey, width: 0.5)
        ),
        height: MediaQuery.of(context).size.height * 0.05,
        width: double.infinity,
      child: Center(child: TextButton(child: Text('Post Comment',
      style: Theme.of(context).textTheme.bodyLarge,
      ),
      onPressed: (){
         Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => MultiBlocProvider(
                        providers: [
                          BlocProvider(
        create: (context) => UserBloc(
            authToken: context.read<AuthCubit>().state.token!, dio: Dio())..add(GetInitialUserData()),
      ),
      BlocProvider(
        create: (context) => CreatePostBloc(
            authToken: context.read<AuthCubit>().state.token!, dio: Dio()),
      ),
     
    
                        ],
                        child: CreatePostScreen(parentId: widget.postId,),
                      )));
      },
      )),
      ):null,
                  appBar: AppBar(
                  
    title: Text('Post'),
    actions: [],
   
                  ),
                  body: NotificationListener<UserScrollNotification>(
                     onNotification: (notification) {
          final ScrollDirection direction = notification.direction;
          if (direction == ScrollDirection.reverse) {
            if (_showBottomSheet) {
              setState(() {
                _showBottomSheet = false;
              });
            }
          } else if (direction == ScrollDirection.forward) {
            if (!_showBottomSheet) {
              setState(() {
                _showBottomSheet = true;
              });
            }
          }
          return true;
        },
                    child: ListView(
                      padding: EdgeInsets.all(8.0),
                      children: [
                       
                                   
                                        
                                      
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
                            return Center(child: CircularProgressIndicator());
                          }
                        }
                        ) ,
                          //Comment Section
                          BlocBuilder<CommentBloc, CommentState>(
                              builder: (context, state) {
                            if (state is CommentLoaded) {
                              List<Postslist> posts = state.comments;
                              // print(posts.lesngth)s;
                              return PostsListWidget(posts: posts);
                            } else if (state is CommentError) {
                              return Text("No Comments Found");
                            } else {
                              return Center(child: CircularProgressIndicator());
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
    print(post.author.name);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
                             post.author.profile_pic != null
                        ? Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            CircleAvatar(
                              backgroundImage:
                                  NetworkImage(post.author.profile_pic!),
                            ),
                            SizedBox(width: MediaQuery.of(context).size.width * 0.05,),
                            Text(post.author.name!,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18.0,),
                            ),
                          ],
                        )
                        : Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            CircleAvatar(
                             child: Icon(Icons.person)
                            ),
                            SizedBox(width: MediaQuery.of(context).size.width * 0.05,),
                            Text(post.author.name!,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18.0,),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.02,),
    
                             
            Text(post.content!,
            style: TextStyle(
              fontWeight: FontWeight.w400,
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
    child: Text('Created: ' + dateTime[0]),
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
      icon:  Icon(Icons.thumb_up_sharp
      ,
      color: post.vote != null && post.vote == 1?Colors.blue:Colors.grey,
      ), onPressed: () {
        if(post.vote == null)
        {
          context.read<SingleCommunityPostBloc>().add(AddLikeDislikeSingleCommunityPostEvent(vote: 1));
        }
        else if(post.vote == 1)
        {
          context.read<SingleCommunityPostBloc>().add(RemoveLikeDislikeSingleCommunityPostEvent(vote: 1));
        }
        else if(post.vote == -1)
        {
          context.read<SingleCommunityPostBloc>().add(AddLikeDislikeSingleCommunityPostEvent(vote: 1));
        }
    
        // context.read<SingleCommunityPostBloc>().add(AddLikeDislikeSingleCommunityPostEvent(vote: 1));
      }),
                            
                              IconButton(
      icon:  Icon(Icons.bookmark_add_outlined,
      color: post.is_bookmarked?Colors.blue:Colors.grey,
      ), onPressed: () {
        context.read<SingleCommunityPostBloc>().add(BookMarkSingleCommunityPostEvent());
      }),
                            ],
                          ),
                          Divider(
                            height: MediaQuery.of(context).size.height * 0.02,
                          ),
                            ],
                            
    );
  }
}