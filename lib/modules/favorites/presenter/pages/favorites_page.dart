import 'package:astromedia/core/widgets/bottom_navigator/bottom_navigator_scaffold.dart';
import 'package:astromedia/modules/favorites/presenter/pages/favorites_mixin.dart';
import 'package:flutter/material.dart';

class FavoritesPage extends StatefulWidget {
  const FavoritesPage({super.key});

  @override
  State<StatefulWidget> createState() => _FavoritesPageState();
}

class _FavoritesPageState extends State<FavoritesPage> with FavoritesMixin {
  @override
  void initState() {
    getFavorites();
    super.initState();
  }

  @override
  void dispose() {
    storedDates.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigatorScaffold(
      appBar: AppBar(title: Text('Seus Favoritos')),
      body: ValueListenableBuilder(
        valueListenable: storedDates,
        builder: (context, storedDates, child) => ListView.builder(
              itemCount: storedDates.length,
              itemBuilder: (context, index) => Text(storedDates[index]),
            ),
      ),
    );
  }
}
