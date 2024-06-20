part of 'trending_bloc.dart';

sealed class TrendingState extends Equatable {
  const TrendingState();
  
  @override
  List<Object> get props => [];
}

final class TrendingInitial extends TrendingState {}

final class TrendingLoading extends TrendingState {}

final class TrendingLoaded extends TrendingState {
  final List<Trending> trendingHashtags;

  const TrendingLoaded(this.trendingHashtags);

  @override
  List<Object> get props => [trendingHashtags];
}


final class TrendingError extends TrendingState {
  final String message;

  const TrendingError(this.message);

  @override
  List<Object> get props => [message];
}