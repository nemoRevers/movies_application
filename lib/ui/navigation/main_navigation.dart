import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:movies_db/ui/widgets/auth/auth_model.dart';
import 'package:movies_db/ui/widgets/auth/auth_widget.dart';
import 'package:movies_db/ui/widgets/main_screen/main_screen_widget.dart';
import 'package:movies_db/ui/widgets/movie_details/movie_details_widget.dart';

import '../../Library/Widgets/Inherited/provider.dart';

class MainNavigationRouteNames {
  static const auth = "auth";
  static const mainScreen = "/";
  static const movieDetails = "/movie_details";
}

class MainNavigation {
  String initialRoute(bool isAuth) => isAuth
      ? MainNavigationRouteNames.mainScreen
      : MainNavigationRouteNames.auth;

  final routes = <String, Widget Function(BuildContext context)>{
    MainNavigationRouteNames.auth: (context) => NotifierProvider(
          model: AuthModel(),
          child: const AuthWidget(),
        ),
    MainNavigationRouteNames.mainScreen: (context) => const MainScreenWidget(),
  };

  Route<Object> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case MainNavigationRouteNames.movieDetails:
        final arguments = settings.arguments;
        final movieId = arguments is int ? arguments : 0;
        return MaterialPageRoute(
          builder: (BuildContext context) =>
              MovieDetailsWidget(movieId: movieId),
        );
      default:
        const Widget widget = Text('Navigation error!!!');
        return MaterialPageRoute(builder: (BuildContext context) => widget);
    }
  }
}
