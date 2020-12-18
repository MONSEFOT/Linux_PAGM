import 'package:equatable/equatable.dart';
import 'package:linux_pagm/BLoC/Enums/error_type.dart';
import 'package:linux_pagm/Models/user.dart';

abstract class UserState extends Equatable {
  User user;

  UserState({this.user});

  @override
  List<Object> get props => [];

  @override
  String toString() =>
      'UserSuccess { User: [token : ${user.token} , token_type : ${user.token_type} , token_refrech : ${user.refresh_token}]}';
}

class UserInitial extends UserState {}

class UserFailure extends UserState {
  ErrorType error;
  UserFailure({this.error});
}

class UserSuccess extends UserState {
  UserSuccess({
    user,
  }) {
    super.user = user;
  }
  @override
  String toString() {
    return super.toString();
  }
}
