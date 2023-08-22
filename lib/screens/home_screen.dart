import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_realm_test/controller/realm/realm_bloc.dart';
import 'package:realm/realm.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // List<dynamic> people = database.all<Person>().toList();
    // final sortedPeople = database.query<Person>("name=='James'");

    // final people = database.all<Person>();

    final TextEditingController nameController = TextEditingController();
    final TextEditingController ageController = TextEditingController();

    // void create() {
    //   database.write(() {
    //     final person = Person(ObjectId(), "Anish", 18);
    //     database.add(person);
    //     log("New Person added");
    //   });
    // }

    // void read() {
    //   if (people.isEmpty) {
    //     log("Empty");
    //   } else {
    //     for (var person in people) {
    //       log("${person.id}, ${person.name}, ${person.age}");
    //     }
    //   }
    // }

    // void update() {
    //   final person = people.last;
    //   if (people.isEmpty) {
    //     log("Empty");
    //   } else {
    //     database.write(() {
    //       log("${person.name} Updated");
    //       database.add(
    //         Person(person.id, "James", 20),
    //         update: true,
    //       );
    //     });
    //   }
    // }

    // void delete() {
    //   final people = database.all<Person>();
    //   final person = people.last;
    //   if (people.isEmpty) {
    //     log("Empty");
    //   } else {
    //     database.write(() {
    //       log("${person.name} Deleted");
    //       database.delete(person);
    //     });
    //   }
    // }

    void showForm(ObjectId? id, String? name, int? age) {
      if (id != null) {
        nameController.text = name!;
        ageController.text = age!.toString();
      } else {
        nameController.text = "";
        ageController.text = "";
      }

      showModalBottomSheet(
        context: context,
        elevation: 5,
        isScrollControlled: true,
        builder: (context) {
          return Container(
            padding: EdgeInsets.only(
              top: 15,
              left: 15,
              right: 15,
              bottom: MediaQuery.of(context).viewInsets.bottom + 120,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                TextField(
                  controller: nameController,
                  decoration: const InputDecoration(hintText: 'Name'),
                ),
                const SizedBox(
                  height: 10,
                ),
                TextField(
                  controller: ageController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(hintText: 'Age'),
                ),
                const SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                  onPressed: () {
                    if (id == null) {
                      Navigator.of(context).pop();
                      context.read<RealmBloc>().add(
                            CreateEvent(
                              name: nameController.text.trim(),
                              age: int.parse(ageController.text.trim()),
                            ),
                          );
                    }
                    if (id != null) {
                      Navigator.of(context).pop();
                      context.read<RealmBloc>().add(
                            UpdateEvent(
                              id: id,
                              name: nameController.text.trim(),
                              age: int.parse(ageController.text.trim()),
                            ),
                          );
                    }
                  },
                  child: Text(
                    id == null ? 'Create New Item' : 'Update Item',
                  ),
                ),
              ],
            ),
          );
        },
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text("Home Screen"),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              const SizedBox(
                height: 20,
              ),
              BlocConsumer<RealmBloc, RealmState>(
                listener: (context, state) {
                  if (state is Loaded) {
                    log("Loaded");
                  } else if (state is ItemAdded) {
                    log("New Item Added");
                    context.read<RealmBloc>().add(GetAllItemsEvent());
                  } else if (state is ItemUpdated) {
                    log("Item Updated");
                    context.read<RealmBloc>().add(GetAllItemsEvent());
                  } else if (state is ItemDeleted) {
                    log("Item deleted");
                    context.read<RealmBloc>().add(GetAllItemsEvent());
                  } else if (state is Error) {
                    log("Error: ${state.errorMessage}");
                  }
                },
                builder: (context, state) {
                  if (state is Loaded) {
                    return ListView.builder(
                      shrinkWrap: true,
                      itemCount: state.peopleList.length,
                      itemBuilder: (context, index) {
                        final person = state.peopleList[index];
                        return ListTile(
                          title: Text("${person.name} (${person.age})"),
                          subtitle: Text(person.id.toString()),
                          trailing: SizedBox(
                            width: 100,
                            child: Row(
                              children: [
                                IconButton(
                                  onPressed: () => showForm(
                                    person.id,
                                    person.name,
                                    person.age,
                                  ),
                                  icon: const Icon(Icons.edit),
                                ),
                                IconButton(
                                  onPressed: () {
                                    context
                                        .read<RealmBloc>()
                                        .add(DeleteEvent(person: person));
                                  },
                                  icon: const Icon(Icons.delete),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  } else if (state is Error) {
                    return Center(
                      child: Text(state.errorMessage.toString()),
                    );
                  } else if (state is Empty) {
                    return const Center(
                      child: Text("Empty"),
                    );
                  }
                  return Container();
                },
              ),
              const SizedBox(
                height: 50,
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showForm(null, null, null);
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
