

import 'package:flutter_bloc/flutter_bloc.dart';

class PasswordObscureText extends Cubit<bool>{
  PasswordObscureText(bool state) : super(state);

  //when the user click on the button of showing password this method will strat  
  //Cheking the password obscure status
  //After cheking the fun will return the opposite of the status value
  void changeObscureStatus(){

    //changing the status 
    emit((state)? false : true);
  } 
}
