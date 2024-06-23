import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:x/business_logic/user_list/bloc/userlist_bloc.dart';

// import 'package:savio/constants/decorations.dart';
// import 'package:savio/presentation/widgets/user_profile_pic.dart';

class SelectOtherUser extends StatelessWidget {
   SelectOtherUser({super.key});

  TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:  TextField(
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
              contentPadding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
            ),
            style: TextStyle(
              color: Colors.black,
              fontSize: 20,
            ),
          ),
        
        )
      ,
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
                      return ListTile(
                        onTap: () {
                          Navigator.of(context).pop(state.users[index]);
                        },
                        leading:pic == null? CircleAvatar(
                              child: const Icon(Icons.person),
                            ):
                            CircleAvatar(
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