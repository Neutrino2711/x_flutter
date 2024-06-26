import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:x/business_logic/blocs/cubit/auth_cubit.dart';
import 'package:x/business_logic/blocs/user/bloc/user_bloc.dart';
import 'package:x/business_logic/following/bloc/following_bloc.dart';
import 'package:x/business_logic/trending/bloc/trending_bloc.dart';
import 'package:x/business_logic/user_list/bloc/userlist_bloc.dart';
import 'package:x/presentation/screens/search_user_page.dart';

class TrendingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    context.read<TrendingBloc>().add(FetchTrending());
    final int UserId = context.read<UserBloc>().state.user!.id;
    return Scaffold(
      appBar: AppBar(
        title: TextButton(
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => MultiBlocProvider(
                          providers: [
                            BlocProvider(
                              create: (context) => UserlistBloc(
                                authToken: context.read<AuthCubit>().state.token!,
                                dio: Dio(),
                              ),
                            ),
                            BlocProvider(
                              create: (context) => FollowingBloc(
                                authToken:  context.read<AuthCubit>().state.token!,
                                dio: Dio(),
                              ),
                            ),
                           
                          ],
                          child: SelectOtherUser(userId: UserId),
                        )));
          },
          style: ButtonStyle(
            backgroundColor: WidgetStateProperty.all(Colors.grey[200]),
            fixedSize: WidgetStateProperty.all(Size(
                MediaQuery.of(context).size.height * 0.35,
                MediaQuery.of(context).size.height * 0.05)),
            // padding: WidgetStateProperty.all(EdgeInsets.all(10)),
          ),
          child:const Text(
            "Search X",
            style: TextStyle(
              color: Colors.grey,
              fontSize: 20,
            ),
          ),
        ),
        centerTitle: true,

        // actions: [
        //   TextButton(

        //     onPressed: (){},
        //     child: Text("Search X")
        //   ),
        // ],
      ),
      body: BlocBuilder<TrendingBloc, TrendingState>(
  builder: (context, state) {
    if (state is TrendingLoading) {
      return Center(child: CircularProgressIndicator());
    } else if (state is TrendingLoaded) {
      return ListView.separated(
        separatorBuilder: (context, index) => Divider(
          height: MediaQuery.of(context).size.height * 0.001,
          color: Colors.grey,
        ),
        itemCount: state.trendingHashtags.length,
        itemBuilder: (context, index) {
          return ListTile(
            // leading: Icon(Icons.trending_up, color: Colors.blue),
            title: Text(
              '#${state.trendingHashtags[index].name}',
              style: TextStyle(fontWeight: FontWeight.bold,
              fontSize: 20.0
              ),
            ),
            trailing: Text(
              '${state.trendingHashtags[index].count} posts',
              style: TextStyle(color: Colors.grey[600],
              fontSize: 20.0),
            ),
            onTap: () {
              // Handle tap if necessary
            },
          );
        },
      );
    } else if (state is TrendingError) {
      return Center(child: Text(state.message));
    } else {
      return Container();
    }
  },
),
    );
  }
}
