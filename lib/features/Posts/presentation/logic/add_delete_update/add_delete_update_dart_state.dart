part of 'add_delete_update_dart_bloc.dart';

sealed class AddDeleteUpdateDartState extends Equatable {
  const AddDeleteUpdateDartState();
  
  @override
  List<Object> get props => [];
}

final class AddDeleteUpdateDartInitial extends AddDeleteUpdateDartState {}

class Loading extends AddDeleteUpdateDartState{}

class Success extends AddDeleteUpdateDartState{
   final String message;
  const Success({required this.message});
  @override
  List<Object> get props => [message];
}

class Error extends AddDeleteUpdateDartState{
  final String message;
  const Error({required this.message});
  @override
  List<Object> get props => [message];
}
