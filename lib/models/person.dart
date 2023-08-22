import 'package:realm/realm.dart';
part 'person.g.dart';

@RealmModel()
@MapTo('person')
class _Person {
  @PrimaryKey()
  @MapTo('_id')
  late ObjectId id;

  late String name;
  late int age;
}
