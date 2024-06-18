import 'package:flutter/material.dart';
import 'package:x/data/models/posts_list.dart';

class PostCard extends StatelessWidget {
  const PostCard({
    super.key,
    required this.posts,
    required this.index,
    required this.onTap,
  });

  final List<Postslist> posts;
  final int index;
  final void Function() onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(20.0)
          ,
        
          // border: Border.all(color: Colors.black, width: 0.5)
          ),
          child: 
              
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  
                    
              ListTile(
                title: Text(posts[index].author.name!,
                style: TextStyle(fontWeight: FontWeight.w700),
                ),
                leading:  posts[index].author.profile_pic != null?CircleAvatar(
                    backgroundImage: NetworkImage(posts[index].author.profile_pic!),
                  ):CircleAvatar(
                    child: Icon(Icons.person),
                  ),
              ),
                     
                  
                  SizedBox(
                  height: MediaQuery.of(context).size.height * 0.02,
                 ),
                  // Text(posts[index].author.name!),
                 posts[index].content!=null? Text(posts[index].content!,
                 style: TextStyle(
                  fontWeight: FontWeight.w300,
                  fontSize: 18.0,
                  ),
                 ):Container(),
                 SizedBox(
                  height: MediaQuery.of(context).size.height * 0.02,
                 ),
                 posts[index].image != null ?  ClipRRect(
                                  borderRadius: BorderRadius.circular(16.0),
                                  child: Image.network(
                                    posts[index].image!,
                                    fit: BoxFit.fill,
                                    width: double.infinity,
                                  ),
                                )
                    : Container(
                    ),
                                        Row(
                                    children: [
                                      IconButton(
                                          icon: const Icon(Icons.favorite), onPressed: () {}),
                                      IconButton(
                                          icon: const Icon(Icons.comment), onPressed: () {}),
                                      IconButton(
                                          icon: const Icon(Icons.share), onPressed: () {}),
                                    ],
                                  ),
              
              
                ],
              ),
            
        ),
      ),
    );
  }
}

// posts[index].author.profile_pic != null ? CircleAvatar(
//                                         backgroundImage: NetworkImage(posts[index].author.profile_pic!),
//                                       ):const CircleAvatar(
//                                         child: Icon(Icons.person),
//                                       ),