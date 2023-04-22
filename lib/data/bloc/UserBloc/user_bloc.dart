import 'package:bloc/bloc.dart';
import 'package:fake_store/data/api/api_service.dart';
import 'package:meta/meta.dart';

import '../../response/user_response.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  UserBloc() : super(UserInitial()) {
    on<GetUserEvent>(getUser);
  }

  getUser(GetUserEvent event, Emitter<UserState> emit) async {
    final response = await ApiService().getUsers();

    if (response.isNotEmpty) {
      emit(GetUserSuccessState(users: response));
    }
  }
}
