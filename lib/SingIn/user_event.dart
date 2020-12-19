import 'package:equatable/equatable.dart';
import 'package:linux_pagm/Models/user.dart';

abstract class UserEvent extends Equatable { 
  @override
  List<Object> get props => [];
}

class UserSigningIn extends UserEvent {
  final Map<String  , dynamic> inputs;


  UserSigningIn({this.inputs});
}

class UserSigningOut extends UserEvent{
  User user;
  List<String> keys;

  UserSigningOut({this.user , this.keys});
}