import 'package:notes_app/core/navigation/routes/login_route.dart';
import 'package:notes_app/core/navigation/routes/profile_route.dart';

class RegistrationRoute {
  static const String name = 'registration';

  static String get navigateRoute => '${ProfileRoute.name}/${LoginRoute.name}/$name';
}