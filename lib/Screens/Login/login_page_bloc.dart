import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class LoginPageBloc extends Bloc<LoginPageBlocEvent,LoginPageBlocState> {
  LoginPageBloc() : super(LoginInputNotLoadedEvent());
  @override
  Stream<LoginPageBlocState> mapEventToState(LoginPageBlocEvent event) async* {
    yield LoginInputIsProcessing();
  }

}

class LoginPageBlocEvent extends Equatable {
  @override
  List<Object?> get props => [];

}

class LoginInputLoadedEvent extends LoginPageBlocEvent {}

class LoginPageBlocState extends Equatable {
  @override
  List<Object?> get props => [];

}

class LoginInputNotLoadedEvent extends LoginPageBlocState {}
class LoginInputIsProcessing extends LoginPageBlocState {}