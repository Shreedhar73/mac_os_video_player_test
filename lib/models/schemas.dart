import 'package:realm/realm.dart';
part 'schemas.g.dart';

@RealmModel()
class _Car {
  @PrimaryKey()
  late ObjectId id;

  late String? model;
  late int? miles;
}
