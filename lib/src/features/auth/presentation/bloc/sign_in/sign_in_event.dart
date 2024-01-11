part of 'sign_in_bloc.dart';

abstract class SignInEvent extends Equatable {
  const SignInEvent();

  @override
  List<Object?> get props => [];
}

class SendSmsCode extends SignInEvent {}

class SignIn extends SignInEvent {
  final String smsCode;

  const SignIn(this.smsCode);
}

class SignOut extends SignInEvent {
  const SignOut();
}
