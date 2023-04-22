part of 'user_bloc.dart';

@immutable
abstract class UserState {}

class UserInitial extends UserState {}

class GetUserSuccessState extends UserState {
  final List<UserResponse> users;

  GetUserSuccessState({required this.users});
}

class UserErrorState extends UserState {}
