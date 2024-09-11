struct MealsDTO: Decodable {
    let meals: [MealDTO]
}

struct MealDTO: Decodable {
    let strMeal: String
    let strMealThumb: String
    let idMeal: String
}
