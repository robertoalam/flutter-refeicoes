import 'package:comidas/components/meal_item.dart';
import 'package:flutter/material.dart';
import '../models/meal.dart';

class FavoriteScreen extends StatelessWidget {
  final List<Meal> favoritasComidas;
  const FavoriteScreen(this.favoritasComidas);

  @override
  Widget build(BuildContext context) {
    if(favoritasComidas.isEmpty){
      return Center(
        child: Text("Minhas Refeicoes Favoritas"),
      );
    }else{
      return ListView.builder(
          itemCount: favoritasComidas.length,
          itemBuilder: (ctx , index){
            return MealItem(favoritasComidas[index]);
          }
      );
    }


  }
}
