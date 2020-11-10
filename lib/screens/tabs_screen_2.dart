import 'package:flutter/material.dart';
import 'categories_screen.dart';
import 'favorite_screen.dart';
import '../components/main_drawer.dart';
import '../models/meal.dart';

class TabsScreen2 extends StatefulWidget {

    final List<Meal> favoritasComidas;
    const TabsScreen2(this.favoritasComidas);

  @override
  _TabsScreen2State createState() => _TabsScreen2State();
}

class _TabsScreen2State extends State<TabsScreen2> {

    int _selectedScreenIndex = 0;
    List<Map< String , Object>> _screens ;

    @override
    void initState() {
        super.initState();
        _screens = [
            { 'title': 'Lista de Categorias' , 'screen' : CategoriesScreen() } ,
            { 'title': 'Meus Favoritos' , 'screen': FavoriteScreen(widget.favoritasComidas) } ,
        ];
    }

    _selecteScreen(int index){
        setState(() {
            _selectedScreenIndex = index;
        });
    }

  @override
  Widget build(BuildContext context) {
      return Scaffold(
          appBar: AppBar(
              title: Text(_screens[_selectedScreenIndex]['title']),
          ),
          drawer: MainDrawer(),
          body: _screens[_selectedScreenIndex]['screen'],
          bottomNavigationBar: BottomNavigationBar(
              onTap: _selecteScreen,
              backgroundColor: Theme.of(context).primaryColor,
              unselectedItemColor: Colors.white,
              selectedItemColor: Theme.of(context).accentColor,
              currentIndex: _selectedScreenIndex,
              items: [
                  BottomNavigationBarItem(icon: Icon(Icons.category),title: Text('Categorias')),
                  BottomNavigationBarItem(icon: Icon(Icons.star),title: Text('Favoritos')),
              ],
          ),
      );
  }
}
