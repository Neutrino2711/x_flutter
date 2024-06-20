import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:x/business_logic/trending/bloc/trending_bloc.dart';

class TrendingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    context.read<TrendingBloc>().add(FetchTrending());
    return Scaffold(
      appBar: AppBar(
        title: Text('Trending Hashtags'),
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
                print(state.trendingHashtags[index].name);
                return ListTile(
                  title: Text('#${state.trendingHashtags[index].name}'),
                  // subtitle: Text(state.trendingHashtags[index].),
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