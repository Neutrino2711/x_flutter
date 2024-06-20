import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:x/constants/constants.dart';
import 'package:x/data/models/trending.dart';

part 'trending_event.dart';
part 'trending_state.dart';

class TrendingBloc extends Bloc<TrendingEvent, TrendingState> {
  TrendingBloc({required this.authToken, required this.dio}) : super(TrendingInitial()) {
    on<FetchTrending>(_onFetchTrendingEvent);

 
  }
  String authToken;
  Dio dio;

  Future<void> _onFetchTrendingEvent(FetchTrending event, Emitter<TrendingState> emit) async {
    emit(TrendingLoading());
    try {
      Response response = await dio.get(
        PostConstants.trendingUrl,
        options: Options(
          headers: {'Authorization' : 'Token $authToken'},
        ),
      );
      emit(TrendingLoaded((response.data as List).map((e) => Trending.fromMap(e)).toList()));
      // final trendingHashtags = await _trendingRepository.fetchTrending();
      // emit(TrendingLoaded(trendingHashtags));
    } catch (e) {
      emit(TrendingError(e.toString()));
    }
  }

}
