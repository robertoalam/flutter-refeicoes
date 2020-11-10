import 'dart:ui';
import 'package:comidas/screens/tabs_screen_2.dart';
import 'screens/tabs_screen.dart';
import 'package:comidas/screens/meal_detail_screen.dart';
import 'package:flutter/material.dart';
import 'screens/categories_meals_screen.dart';
import 'screens/settings_screen.dart';
import 'helper/app_routes.dart';
import 'models/meal.dart';
import 'data/dummy_data.dart';
import 'models/settings.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
    Settings settings = Settings();
    List<Meal> _disponiveisComidas = DUMMY_MEALS;
    List<Meal> _favoritasComidas = [];

    void _filtroComidas(Settings settings){
        setState(() {
            this.settings = settings;
            _disponiveisComidas = DUMMY_MEALS.where((meal) {
                final filtroGluten = settings.isGlutenFree && !meal.isGlutenFree;
                final filtroLactose = settings.isLactoseFree && !meal.isLactoseFree;
                final filtroVegano = settings.isVegan && !meal.isVegan;
                final filtroVegetariano = settings.isVegetarian && !meal.isVegetarian;
                return !filtroGluten && !filtroLactose && !filtroVegano && !filtroVegetariano ;
            }).toList();
        });
    }

    void _toggleFavorita(Meal meal){
        setState(() {
          _favoritasComidas.contains(meal) ? _favoritasComidas.remove(meal) : _favoritasComidas.add(meal);
        });
    }

    bool _isFavorita(Meal meal){
        return _favoritasComidas.contains(meal);
    }

  @override
  Widget build(BuildContext context) {
      return MaterialApp(
          title: 'DeliMeals',
          theme: ThemeData(
              primarySwatch: Colors.pink,
              accentColor: Colors.amber,
              fontFamily: 'Raleway',
              canvasColor: Color.fromRGBO(255, 254, 229, 1),
              textTheme: ThemeData.light().textTheme.copyWith(
                  title: TextStyle(
                      fontSize: 20,
                      fontFamily: 'RobotoCondensed'
                  ),
              )
          ),
          routes: {
              AppRoutes.HOME: (ctx) => TabsScreen2(_favoritasComidas),
              AppRoutes.CATEGORIES_MELS:(ctx)=>CategoriesMealsScreen(_disponiveisComidas),
              AppRoutes.MEAL_DETAIL:(ctx)=>MealDetailScreen( _toggleFavorita , _isFavorita ),
              AppRoutes.SETTINGS:(ctx)=>SettingsScreen(settings , _filtroComidas),
          },
      );
  }
}