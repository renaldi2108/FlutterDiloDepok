class Model {
  List<Meal> meals;

  Model({this.meals});

  factory Model.fromJson(Map<String, dynamic> json) => Model(
    meals: List<Meal>.from(json['meals'].map( (x) => Meal.fromJson(x)) )
  );
}

class Meal {
  String strMeal, strMealThumb, idMeal;

  Meal({this.idMeal, this.strMeal, this.strMealThumb});

  factory Meal.fromJson(Map<String, dynamic> json) => Meal(
    idMeal: json['idMeal'],
    strMeal: json['strMeal'],
    strMealThumb: json['strMealThumb']
  );
}