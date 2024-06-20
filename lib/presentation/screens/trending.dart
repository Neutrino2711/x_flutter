import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:x/business_logic/trending/bloc/trending_bloc.dart';

class TrendingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    context.read<TrendingBloc>().add(FetchTrending());
    return Scaffold(
      appBar: AppBar(
        title: TextButton(onPressed:  (){},
        style: ButtonStyle(
          backgroundColor: WidgetStateProperty.all(Colors.grey[200]),
          fixedSize: WidgetStateProperty.all(Size(MediaQuery.of(context).size.height*0.35, MediaQuery.of(context).size.height*0.05)),
          // padding: WidgetStateProperty.all(EdgeInsets.all(10)),
        ),
          child: Text("Search X",
          style: TextStyle(
            color: Colors.grey,
            fontSize: 20,
          ),
          ),),
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
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is TrendingLoaded) {
            return ListView.builder(
              itemCount: state.trendingHashtags.length,
              itemBuilder: (context, index) {
                // print(state.trendingHashtags[index].name);s
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Text('Trending'),
                    ListTile(
                      // leading: Text('Trending'),
                      title: Text('#${state.trendingHashtags[index].name}'),
                      trailing: Text('${state.trendingHashtags[index].count} posts'),
                      // subtitle: Text(state.trendingHashtags[index].),
                    ),
                  ],
                );
              },
            );
          } else if (state is TrendingError) {
            return Center(
              child: Text(state.message),
            );
          } else {
            return Container();
          }
        },
      ),
    );
  }
}