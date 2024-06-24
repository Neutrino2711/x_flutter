import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:x/business_logic/blocs/user/bloc/user_bloc.dart';
import 'package:x/business_logic/following/bloc/following_bloc.dart';
import 'package:x/business_logic/user_list/bloc/userlist_bloc.dart';
import 'package:x/data/models/user.dart';

// import 'package:savio/constants/decorations.dart';
// import 'package:savio/presentation/widgets/user_profile_pic.dart';

class SelectOtherUser extends StatelessWidget {
  SelectOtherUser({super.key, required this.userId});

  TextEditingController _searchController = TextEditingController();

  final int userId;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextField(
          // controller: _searchController,
          
          onChanged: (value) {
            if (value.length > 2) {
              context.read<UserlistBloc>().add(SearchUserList(value));
            }
          },
          decoration: InputDecoration(
            hintText: 'Search X',
            hintStyle: TextStyle(
              color: Colors.grey,
              fontSize: 20,
            ),
            border: InputBorder.none,
            contentPadding:
                EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
          ),
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(children: [
          const SizedBox(
            height: 30,
          ),
          // TextField(
          //   decoration: InputDecoration(
          //     labelText: 'Search',
          //     // labelStyle: bodyStyle
          //   ),
          //   onChanged: (value) {
          //     if (value.length > 2) {
          //       context.read<SearchUserBloc>().add(SearchUserEvent(value));
          //     }
          //   },
          // ),
          const SizedBox(
            height: 20,
          ),
          Expanded(
            child: BlocBuilder<UserlistBloc, UserlistState>(
              builder: (context, state) {
                if (state is UserlistLoaded) {
                  return ListView.builder(
                    itemCount: state.users.length,
                    itemBuilder: (context, index) {
                      String? pic = state.users[index].profile_pic;
                      //  context.read<UserBloc>()..add(GetInitialUserData());s

                      bool isFollowing =
                          state.users[index].followers!.contains(userId);
                      print(isFollowing);
                      print(state.users[index].followers!);
                      print(state.users[index].id);
                      return ListTile(
                        onTap: () {
                          Navigator.of(context).pop(state.users[index]);
                        },
                        leading: pic == null
                            ? CircleAvatar(
                                child: const Icon(Icons.person),
                              )
                            : CircleAvatar(
                                backgroundImage: NetworkImage(
                                  pic,
                                ),
                              ),
                        title: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              state.users[index].name!,
                              // style: bodyStyle,
                            ),
                            Text(
                              state.users[index].email,
                              // style: copyWith(
                              //     fontSize: Theme.of(context)
                              //         .textTheme
                              //         .bodySmall!
                              //         .fontSize),
                            ),
                            BlocBuilder<FollowingBloc, FollowingState>(
                              builder: (context, followstate) {
                                
                                return ElevatedButton(
                                  onPressed: () {
                                    context.read<FollowingBloc>().add(
                                        AddFollowingEvent(
                                            state.users[index].id));
                                    isFollowing = !isFollowing;
                                  },
                                  child: isFollowing
                                      ? Text("Unfollow")
                                      : Text("Follow"),
                                );
                              },
                            )
                          ],
                        ),
                      );
                    },
                  );
                } else if (state is UserlistInitial) {
                  return Container();
                } else {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
              },
            ),
          ),
        ]),
      ),
    );
  }
}
