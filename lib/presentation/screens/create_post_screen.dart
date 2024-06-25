import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:x/business_logic/bloc/create_post_bloc.dart';
import 'package:x/business_logic/blocs/bloc/post_list_bloc.dart';
import 'package:x/business_logic/blocs/cubit/auth_cubit.dart';
import 'package:x/business_logic/blocs/user/bloc/user_bloc.dart';

class CreatePostScreen extends StatefulWidget {

  CreatePostScreen({Key? key, this.parentId}) : super(key: key);
  final int? parentId;
  @override
  State<CreatePostScreen> createState() => _CreatePostScreenState();
}

class _CreatePostScreenState extends State<CreatePostScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController contentController = TextEditingController();

  File? _image;

  Future<void> _getImage() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    pickedFile != null
        ? setState(() {
            _image = File(pickedFile.path);
          })
        : null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // title: Text('Create Post'),
        leading: IconButton(
          icon: Icon(Icons.close),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: [
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blue,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
            ),
            child: Text('Post',
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: Colors.white, fontWeight: FontWeight.bold)
             ,),
            onPressed: () {
              if (_formKey.currentState!.validate()) {
               widget.parentId==null? context.read<CreatePostBloc>().add(CreatePostOnlyEvent(
                    content: contentController.text, image: _image?.path)):
                    context.read<CreatePostBloc>().add(CreateCommentEvent(
                      content: contentController.text, image: _image?.path, postId: widget.parentId!));
                    
                    // context.read<PostListBloc>().add(GetPostListEvent());
                     Navigator.pop(context);
              }
              else 
              {
                print("error");
              }
    
             
            },
          ),
        ],
      ),
      body: Form(
        key: _formKey,
        child: Scaffold(
          body: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                BlocBuilder<UserBloc, UserState>(
                  builder: (context, state) {
                    if (state is LoadedUserState) {
                      return state.user!.profile_pic != null
                          ? Padding(
                              padding: const EdgeInsets.only(left: 20.0),
                              child: CircleAvatar(
                                backgroundImage:
                                    NetworkImage(state.user!.profile_pic!),
                              ),
                            )
                          : const Padding(
                              padding: EdgeInsets.all(8.0),
                              child: CircleAvatar(
                                child: Icon(Icons.person),
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
                Padding(
                  padding: EdgeInsets.all(20.0),
                  child: TextFormField(
                    controller: contentController,
                    keyboardType: TextInputType.multiline,
                    // autofocus: true,
                    showCursor: true,
                    decoration: const InputDecoration(
                      hintText: 'Start typing here ..',
                      border: InputBorder.none,
                    ),
                      
                    maxLines: null,
                    validator: (value) {
                      if (value!.isEmpty && _image == null) {
                        return 'Post cannot be empty';
                      }
                      return null;
                    },
                  ),
                ),
              ],
            ),
          ),
          bottomSheet:Padding(
        padding: const EdgeInsets.all(10.0),
        child: Row(
          children: [
            IconButton(
              icon: Icon(Icons.attach_file, color: Colors.blue),
              onPressed: _getImage,
            ),
            Spacer(),
          ],
        ),
      ),
        ),
      ),
    );
  }
}
