// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter_test/flutter_test.dart';
import 'package:linux_pagm/BLoC/Cubits/password_obscure_text.dart';


void main(){

  //enable ans disable the obscuring of the password text method test
  test("The method is for obscuring the password text characters", (){
    var disable = PasswordObscureText(true)..changeObscureStatus()..close();
    var enable = PasswordObscureText(false)..changeObscureStatus()..close();

    //disable  
    expect(disable.state, false);
    
    //enable
    expect(enable.state, true);
  });
}
