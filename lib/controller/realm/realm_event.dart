part of 'realm_bloc.dart';

abstract class RealmEvent extends Equatable {
  const RealmEvent();

  @override
  List<Object> get props => [];
}

class GetAllItemsEvent extends RealmEvent {}

class CreateEvent extends RealmEvent {
  final String name;
  final int age;

  const CreateEvent({
    required this.name,
    required this.age,
  });

  @override
  List<Object> get props => [name, age];
}

class UpdateEvent extends RealmEvent {
  final ObjectId id;
  final String name;
  final int age;

  const UpdateEvent({
    required this.id,
    required this.name,
    required this.age,
  });

  @override
  List<Object> get props => [id, name, age];
}

class DeleteEvent extends RealmEvent {
  final Person person;

  const DeleteEvent({required this.person});

  @override
  List<Object> get props => [person];
}
