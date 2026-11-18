import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'hacker_news_state.dart';

class HackerNewsCubit extends Cubit<HackerNewsState> {
  HackerNewsCubit() : super(HackerNewsInitial());
}
