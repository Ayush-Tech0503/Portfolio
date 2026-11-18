import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'get_api_state.dart';

class GetApiCubit extends Cubit<GetApiState> {
  GetApiCubit() : super(GetApiInitial());
}
