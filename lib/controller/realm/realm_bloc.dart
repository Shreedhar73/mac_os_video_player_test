import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_realm_test/config/realm_config.dart';
import 'package:flutter_realm_test/models/person.dart';
import 'package:realm/realm.dart';

part 'realm_event.dart';
part 'realm_state.dart';

class RealmBloc extends Bloc<RealmEvent, RealmState> {
  RealmBloc() : super(RealmInitial()) {
    on<GetAllItemsEvent>(_getAllItems);
    on<CreateEvent>(_addItem);
    on<UpdateEvent>(_updateItem);
    on<DeleteEvent>(_deleteItem);
  }

  Future<void> _getAllItems(
      GetAllItemsEvent event, Emitter<RealmState> emit) async {
    try {
      // final people = database.all<Person>();
      final people = RealmConfig.instance.realmHelper.all<Person>();
      emit(Loading());
      if (people.isEmpty) {
        emit(Empty());
      } else {
        emit(Loaded(peopleList: people.toList()));
      }
    } on RealmException catch (e) {
      emit(Error(errorMessage: e.toString()));
    }
  }

  Future<void> _addItem(CreateEvent event, Emitter<RealmState> emit) async {
    try {
      RealmConfig.instance.realmHelper.write(() {
        final person = Person(ObjectId(), event.name, event.age);
        RealmConfig.instance.realmHelper.add(person);
        emit(ItemAdded());
      });
    } on RealmException catch (e) {
      emit(Error(errorMessage: e.toString()));
    }
  }

  Future<void> _updateItem(UpdateEvent event, Emitter<RealmState> emit) async {
    try {
      RealmConfig.instance.realmHelper.write(() {
        final person = Person(event.id, event.name, event.age);
        RealmConfig.instance.realmHelper.add(person, update: true);
        emit(ItemUpdated());
      });
    } on RealmException catch (e) {
      emit(Error(errorMessage: e.toString()));
    }
  }

  Future<void> _deleteItem(DeleteEvent event, Emitter<RealmState> emit) async {
    try {
      RealmConfig.instance.realmHelper.write(() {
        RealmConfig.instance.realmHelper.delete(event.person);
        emit(ItemDeleted());
      });
    } on RealmException catch (e) {
      emit(Error(errorMessage: e.toString()));
    }
  }
}
