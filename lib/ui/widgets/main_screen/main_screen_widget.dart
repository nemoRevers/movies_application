import 'package:flutter/material.dart';
import 'package:movies_db/Library/Widgets/Inherited/provider.dart';
import 'package:movies_db/domain/providers/session_data_provider.dart';
import 'package:movies_db/ui/widgets/movie_list/movie_list_model.dart';

import '../movie_list/movie_list_widget.dart';

class MainScreenWidget extends StatefulWidget {
  const MainScreenWidget({Key? key}) : super(key: key);

  @override
  State<MainScreenWidget> createState() => _MainScreenWidgetState();
}

class _MainScreenWidgetState extends State<MainScreenWidget> {
  int _selectedTab = 0;
  final movieListModel = MovieListModel();

  void onSelectTab(int index) {
    if (_selectedTab != index) {
      setState(() {
        _selectedTab = index;
      });
    }
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    movieListModel.setupLocale(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('TMDB'),
        actions: [
          IconButton(
            onPressed: () {
              SessionDataProvider().setSessionId(null);
            },
            icon: const Icon(Icons.search),
          ),
        ],
      ),
      body: IndexedStack(
        index: _selectedTab,
        children: <Widget>[
          const Center(
            child: Text(
              'Новости',
            ),
          ),
          NotifierProvider(
            model: movieListModel,
            child: const MovieListWidget(),
          ),
          const Center(
            child: Text(
              'Сериалы',
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedTab,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Новости',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.movie_filter),
            label: 'Фильмы',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.tv),
            label: 'Сериалы',
          ),
        ],
        onTap: onSelectTab,
      ),
    );
  }
}
