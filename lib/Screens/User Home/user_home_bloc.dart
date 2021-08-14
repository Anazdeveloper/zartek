import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zartek/Modals/restaurant_modal.dart';
import 'package:zartek/Repos/user_home_repo.dart';

class UserHomeBloc extends Bloc<UserHomeEvent, UserHomeState> {
  UserHomeBloc() : super(UserHomeInputNotLoadedYetState());

  @override
  Stream<UserHomeState> mapEventToState(event) async* {
    if(event is UserHomeUiLoadedEvent) {
      yield UserHomeInputNotLoadedYetState();
      final List<Restaurant> restaurantResponse = await UserHomeRepo().getData();
      yield UserHomeUiLoadedState(restaurantResponse.first.tableMenuList!.first.categoryDishes);
    }
  }

}

class UserHomeEvent extends Equatable {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class UserHomeUiLoadedEvent extends UserHomeEvent {}

class UserHomeState extends Equatable {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class UserHomeInputNotLoadedYetState extends UserHomeState {}

class UserHomeUiNotLoadedYetState extends UserHomeState {}

class UserHomeUiLoadedState extends UserHomeState {
  final List<CategoryDishes> ? categoryDishes;
  UserHomeUiLoadedState(this.categoryDishes);
}