part of 'realm_bloc.dart';

abstract class RealmState extends Equatable {
  const RealmState();

  @override
  List<Object> get props => [];
}

class RealmInitial extends RealmState {}

class Loading extends RealmState {}

class Loaded extends RealmState {
  final List<Person> peopleList;

  const Loaded({required this.peopleList});

  @override
  List<Object> get props => [peopleList];
}

class Empty extends RealmState {}

class ItemAdded extends RealmState {}

class ItemUpdated extends RealmState {}

class ItemDeleted extends RealmState {}

class Error extends RealmState {
  final String errorMessage;

  const Error({required this.errorMessage});

  @override
  List<Object> get props => [errorMessage];
}
