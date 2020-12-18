import 'package:equatable/equatable.dart';

abstract class UserEvent extends Equatable { 
  @override
  List<Object> get props => [];
}

class UserSignIn extends UserEvent {
  final Map<String  , dynamic> inputs;


  UserSignIn({this.inputs});
}