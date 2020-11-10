import 'package:flutter/material.dart';
import '../models/meal.dart';

class MealDetailScreen extends StatelessWidget {
    final Function(Meal) onToggleFavorita;
    final bool Function(Meal) isFavorita;
    const MealDetailScreen(this.onToggleFavorita , this.isFavorita);

  Widget _createSectionTitle(BuildContext context, String title) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: Text(
        title,
        style: Theme.of(context).textTheme.title,
      ),
    );
  }

  //FUNCAO QUE EXIBE AS LISTAS
  Widget _createSectionContainer(Widget child) {
    return Container(
        width: 300,
        height: 200,
        padding: EdgeInsets.all(10),
        margin: EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(10),
        ),
        child: child);
  }

  @override
  Widget build(BuildContext context) {
    final meal = ModalRoute.of(context).settings.arguments as Meal;
    return Scaffold(
      appBar: AppBar(
        title: Text(meal.title),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              height: 300,
              width: double.infinity,
              child: Image.network(meal.imageUrl, fit: BoxFit.cover),
            ),
            _createSectionTitle(context, 'Ingredientes'),
            _createSectionContainer(
              ListView.builder(
                  itemCount: meal.ingredients.length,
                  itemBuilder: (context, index) {
                    return Card(
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                          vertical: 5,
                          horizontal: 10,
                        ),
                        child: Text(meal.ingredients[index]),
                      ),
                      color: Theme.of(context).accentColor,
                    );
                  }),
            ),
              _createSectionTitle(context, 'Passos'),
              _createSectionContainer(
                  ListView.builder(
                      itemCount: meal.steps.length,
                      itemBuilder: (context , index){
                          return ListTile(
                              leading: CircleAvatar(
                                  child: Text("${index+1}"),
                              ),
                                title: Text(meal.steps[index]),
                          );
                      }
                  )
              )
          ],
        ),
      ),
        floatingActionButton: FloatingActionButton(
            child: Icon( isFavorita(meal)? Icons.star : Icons.star_border),
            onPressed: (){
                onToggleFavorita(meal);
            },
        ),
    );
  }
}
