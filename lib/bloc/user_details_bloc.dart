import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_application_2/repositories/user_details_repository.dart';

import '../models/user.dart';

class UserEvent {}

class GetDataEvent extends UserEvent {
  final String username;
  GetDataEvent({required this.username});
}

abstract class UserState {
  const UserState();
}

class UserStateInitial extends UserState {
  const UserStateInitial();
}

class UserStateLoading extends UserState {
  const UserStateLoading();
}

class UserStateLoaded extends UserState {
  final User data;

  const UserStateLoaded(this.data);
}

class UserStateError extends UserState {
  final String message;

  const UserStateError(this.message);
}

class UserDetailsBloc extends Bloc<UserEvent, UserState>{

  final UserDetailsRepository repositoryImp;

  UserDetailsBloc(this.repositoryImp) : super(const UserStateInitial()){
    on<GetDataEvent>(_onGetDataEvent);
      
    }

    void _onGetDataEvent(GetDataEvent event, Emitter<UserState> emit) async{
      emit(const UserStateLoading());
      final username = event.username;
      try{
        final result = await repositoryImp.getUserDataByUsername(username);
        emit(UserStateLoaded(result));
      } catch(error){
        emit(UserStateError(error.toString()));
      }
    }
}

