import '../screens/map_page.dart';
import '../screens/calendar_page.dart';
import '../screens/settings_page.dart';

typedef T Constructor<T>();

final Map<String, Constructor<Object>> _constructors = <String, Constructor<Object>>{};

void register<T>(Constructor<T> constructor) {
  _constructors[T.toString()] = constructor;
}

class ClassBuilder {
  static void registerClasses() {
    register<MapPage>(() => MapPage());
    register<CalendarPage>(() => CalendarPage());
    register<SettingsPage>(() => SettingsPage());
  }

  static dynamic fromString(String type) {
    return _constructors[type]();
  }
}