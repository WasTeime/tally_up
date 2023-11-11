import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:tally_up/src/features/auth/data/repository/authController.dart';

part 'sign_in_event.dart';
part 'sign_in_state.dart';

//https://youtu.be/-IfjS0fpFrY?si=H0wd-VU1z1v9pWPO

class SignInBloc extends Bloc<SignInEvent, SignInState> {
  final _authController = AuthController();

  SignInBloc() : super(SignInInitial()) {
    on<SignIn>((event, emit) async {
      emit(SignInProcess());
      try {
        await _authController.signIn(event.smsCode);
        emit(SignInSuccess());
      } catch (message) {
        emit(SignInFailure(message.toString()));
      }
    });

    on<SendSmsCode>((event, emit) async {
      try {
        await _authController.sendPhoneCode(event.phoneNumber);
      } catch (e) {
        print(e);
      }
    });

    on<SignOut>((event, emit) async {
      //TODO почему тут не надо try catch (по идее log out можно совершить всегда)
      await _authController.logOut();
    });
  }
}
