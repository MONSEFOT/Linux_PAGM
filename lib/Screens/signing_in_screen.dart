import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:linux_pagm/BLoC/Blocs/Anime/anime_bloc.dart';
import 'package:linux_pagm/BLoC/Blocs/signing_in_bloc.dart';
import 'package:linux_pagm/BLoC/Cubits/password_obscure_text.dart';
import 'package:linux_pagm/BLoC/Cubits/token_checking.dart';
import 'package:linux_pagm/BLoC/Enums/cheking_token_and_signing_out_operations.dart';
import 'package:linux_pagm/BLoC/Enums/error_type.dart';
import 'package:linux_pagm/BLoC/Enums/signing_button_type.dart';
import 'package:linux_pagm/Models/user.dart';
import 'package:linux_pagm/Resources/string.dart';
import 'package:linux_pagm/Resources/theme.dart';
import 'package:linux_pagm/Screens/Errors/error.dart';
import 'package:linux_pagm/Screens/home.dart';
import 'package:linux_pagm/SingIn/user_event.dart';
import 'package:linux_pagm/SingIn/user_state.dart';

class SigningInScreen extends StatefulWidget {
  @override
  _SigningInScreenState createState() => _SigningInScreenState();
}

class _SigningInScreenState extends State<SigningInScreen> {
  TextEditingController _email = new TextEditingController();
  TextEditingController _password = new TextEditingController();
  final passwordObscureText = PasswordObscureText(true);
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: blueNight,
      body: Center(
        child: BlocBuilder<TokenCheckingAndSingOut, UserState>(
          cubit: TokenCheckingAndSingOut(
              operation: ChekingTokenAndSigningOutOperations.chekingToken),
          builder: (context, state) {
            if (state is UserInitial) {
              return CircularProgressIndicator(
                backgroundColor: red,
              );
            } else if (state is UserSuccess) {
              return Container(
                height: 500.0,
                width: 500.0,
                margin: EdgeInsets.all(5.0),
                padding: EdgeInsets.all(5.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15.0),
                  color: black,
                ),
                alignment: Alignment.center,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _appTitle(),
                    SizedBox(
                      height: 20.0,
                    ),
                    _signingButton(SigningButtonType.starting, state.user),
                    SizedBox(
                      height: 20.0,
                    ),
                    _signingButton(SigningButtonType.signingOut, state.user),
                  ],
                ),
              );
            } else if (state is UserFailure) {
              return Container(
                height: 500.0,
                width: 500.0,
                margin: EdgeInsets.all(5.0),
                padding: EdgeInsets.all(5.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15.0),
                  color: black,
                ),
                alignment: Alignment.center,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _appTitle(),
                    SizedBox(
                      height: 20.0,
                    ),
                    _emailField(),
                    SizedBox(
                      height: 30.0,
                    ),
                    _passwordField(_obscureText),
                    SizedBox(
                      height: 30.0,
                    ),
                    BlocBuilder<SignInBloc, UserState>(
                      builder: (context, state) {
                        if (state is UserInitial) {
                          return CircularProgressIndicator(
                            backgroundColor: red,
                          );
                        } else if (state is UserSuccess) {
                          return _signingButton(
                              SigningButtonType.starting, state.user);
                        } else if (state is UserFailure) {
                          switch (state.error) {
                            case ErrorType.connection:
                              {
                                return Column(
                                  children: [
                                    errorDisplaying(
                                      "Chack your internet connection",
                                    ),
                                    IconButton(
                                      icon: Icon(
                                        Icons.refresh,
                                        color: white,
                                      ),
                                      onPressed: () {
                                        context.read<SignInBloc>().add(
                                              UserSigningIn(
                                                inputs: {
                                                  "username": _email.text,
                                                  "password": _password.text
                                                },
                                              ),
                                            );
                                      },
                                    ),
                                  ],
                                );
                              }
                              break;
                            case ErrorType.userInformations:
                              {
                                return Column(
                                  children: [
                                    errorDisplaying(
                                      "Your username or password is incorrected",
                                    ),
                                    IconButton(
                                      icon: Icon(
                                        Icons.refresh,
                                        color: white,
                                      ),
                                      onPressed: () {
                                        context.read<SignInBloc>().add(
                                              UserSigningIn(
                                                inputs: {
                                                  "username": _email.text,
                                                  "password": _password.text
                                                },
                                              ),
                                            );
                                      },
                                    ),
                                  ],
                                );
                              }
                              break;
                            default:
                              {
                                return Column(
                                  children: [
                                    errorDisplaying(
                                      "That is a problem witch stoped you process",
                                    ),
                                    IconButton(
                                      icon: Icon(
                                        Icons.refresh,
                                        color: white,
                                      ),
                                      onPressed: () {
                                        context.read<SignInBloc>().add(
                                              UserSigningIn(
                                                inputs: {
                                                  "username": _email.text,
                                                  "password": _password.text
                                                },
                                              ),
                                            );
                                      },
                                    ),
                                  ],
                                );
                              }
                          }
                        } else {
                          return _signingButton(SigningButtonType.signingIn);
                        }
                      },
                    ),
                  ],
                ),
              );
            }
          },
        ),
      ),
    );
  }

  Widget _appTitle() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text("PAGM", style: appTitle),
        Text('by MonsefOT', style: appDeveloper),
      ],
    );
  }

  Widget _emailField() {
    return Container(
      width: 300.0,
      child: TextField(
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15.0),
            borderSide: BorderSide(width: 3, color: red),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15.0),
            borderSide: BorderSide(width: 3, color: Colors.white),
          ),
          disabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15.0),
            borderSide: BorderSide(width: 3, color: Colors.white),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15.0),
            borderSide: BorderSide(width: 3, color: Colors.white),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15.0),
            borderSide: BorderSide(width: 3, color: Colors.red),
          ),
          labelText: "Email",
          labelStyle: TextStyle(color: white),
        ),
        cursorColor: white,
        toolbarOptions:
            ToolbarOptions(copy: true, cut: true, paste: true, selectAll: true),
        controller: _email,
        keyboardType: TextInputType.emailAddress,
        style: TextStyle(color: white),
      ),
    );
  }

  Widget _passwordField(bool obscureText) {
    return Container(
      width: 300.0,
      child: TextField(
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15.0),
            borderSide: BorderSide(width: 3, color: white),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15.0),
            borderSide: BorderSide(width: 3, color: white),
          ),
          disabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15.0),
            borderSide: BorderSide(width: 3, color: white),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15.0),
            borderSide: BorderSide(width: 3, color: white),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15.0),
            borderSide: BorderSide(width: 3, color: red),
          ),
          labelText: "Password",
          labelStyle: TextStyle(color: white),
          suffixIcon: IconButton(
            icon: Icon(
              (_obscureText)
                  ? CupertinoIcons.eye_slash
                  : CupertinoIcons.eye_fill,
              color: white,
            ),
            onPressed: () {
              setState(() {
                var cubit = PasswordObscureText(_obscureText)
                  ..changeObscureStatus()
                  ..close();
                _obscureText = cubit.state;
              });
            },
          ),
        ),
        cursorColor: white,
        obscureText: obscureText,
        controller: _password,
        keyboardType: TextInputType.visiblePassword,
        style: TextStyle(color: white),
      ),
    );
  }

  Widget _signingButton(SigningButtonType signingButtonType, [User user]) {
    return Container(
      width: 250.0,
      child: FlatButton(
        color: blueNight,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        child: Container(
          padding: EdgeInsets.all(10.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: _sigingButtonTitle(signingButtonType),
          ),
        ),
        onPressed: () {
          if (signingButtonType == SigningButtonType.starting) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => BlocProvider(
                  create: (context) => AnimeBloc(),
                  child: Home(),
                ),
              ),
            );
          } else if (signingButtonType == SigningButtonType.signingIn) {
            context.read<SignInBloc>().add(
                  UserSigningIn(
                    inputs: {
                      "username": _email.text,
                      "password": _password.text
                    },
                  ),
                );
          } else {
            setState(() {
              TokenCheckingAndSingOut(
                  operation: ChekingTokenAndSigningOutOperations.siginingOut,
                  event: UserSigningOut(
                      user: user,
                      keys: [refreshingAccessTokenKey, accessTokenKey]))
                ..close();
            });
          }
        },
      ),
    );
  }

  List<Widget> _sigingButtonTitle(SigningButtonType signingButtonType) {
    if (signingButtonType == SigningButtonType.starting) {
      return [
        Text(
          "Sta",
          style: TextStyle(
              color: white, fontSize: 18, fontStyle: FontStyle.italic),
        ),
        Text(
          "rt",
          style:
              TextStyle(color: red, fontSize: 18, fontStyle: FontStyle.italic),
        ),
      ];
    } else if (signingButtonType == SigningButtonType.signingIn) {
      return [
        Text(
          "Sign",
          style: TextStyle(
              color: white, fontSize: 18, fontStyle: FontStyle.italic),
        ),
        Text(
          "In",
          style:
              TextStyle(color: red, fontSize: 18, fontStyle: FontStyle.italic),
        ),
      ];
    } else {
      return [
        Text(
          "Sign",
          style: TextStyle(
              color: white, fontSize: 18, fontStyle: FontStyle.italic),
        ),
        Text(
          "Out",
          style:
              TextStyle(color: red, fontSize: 18, fontStyle: FontStyle.italic),
        ),
      ];
    }
  }
}
