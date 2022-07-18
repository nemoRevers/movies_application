import 'package:flutter/material.dart';
import 'package:movies_db/Theme/app_colors.dart';
import 'package:movies_db/widgets/auth/auth_widget.dart';
import 'package:movies_db/widgets/main_screen/main_screen_widget.dart';
import 'package:movies_db/widgets/movie_details/movie_details_widget.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        appBarTheme: const AppBarTheme(
          backgroundColor: AppColors.mainDarkBlue,
        ),
        primarySwatch: Colors.blue,
        bottomNavigationBarTheme: const BottomNavigationBarThemeData(
          backgroundColor: AppColors.mainDarkBlue,
          selectedItemColor: Colors.white,
          unselectedItemColor: Colors.grey,
        ),
      ),
      initialRoute: AuthWidget.id,
      routes: {
        AuthWidget.id: (context) => const AuthWidget(),
        MainScreenWidget.id: (context) => const MainScreenWidget(),
        MovieDetailsWidget.id: (context) {
          final id = ModalRoute.of(context)!.settings.arguments as int;
          return MovieDetailsWidget(
            movieId: id,
          );
        },
      },
      onGenerateRoute: (RouteSettings settings) {
        return MaterialPageRoute<void>(builder: (context) {
          return const Scaffold(
            body: Center(
              child: Text('Error'),
            ),
          );
        });
      },
    );
  }
}
