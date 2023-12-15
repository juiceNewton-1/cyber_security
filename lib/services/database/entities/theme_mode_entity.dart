
import 'package:hive/hive.dart';

part 'theme_mode_entity.g.dart';

@HiveType(typeId: 3)
enum ThemeModeEntity  {
  @HiveField(0)
  ligth,
  @HiveField(1)
  dark,
}
