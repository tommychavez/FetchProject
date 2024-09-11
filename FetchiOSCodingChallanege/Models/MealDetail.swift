import SwiftUI

struct MealDetail {
    let id: String
    let meal: String
    let instructions: String
    let mealThumb: String
    let ingredients: [Ingredient]
}

struct Ingredient: Decodable, Identifiable {
    let id: String
    let name: String
    let measure: String
    
    init(name: String?, measure: String?) {
        self.name = name ?? ""
        self.measure = measure ?? ""
        self.id = UUID().uuidString
    }
}
