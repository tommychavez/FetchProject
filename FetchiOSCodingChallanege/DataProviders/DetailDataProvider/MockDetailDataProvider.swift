import SwiftUI

struct MockDetailDataProvider: DetailDataProvider {
    func getDetails(id: String) async throws -> MealDetailsDTO {
        .init(
            meals:
                [
                    mockMealDetailDTO(),
                    mockMealDetailDTO(),
                    mockMealDetailDTO()
                ]
        )
    }
    
    private func mockMealDetailDTO() -> MealDetailDTO {
        let mockString = UUID().uuidString
        return .init(
            idMeal: mockString,
            strMeal: mockString,
            strDrinkAlternate: mockString,
            strCategory: mockString,
            strArea: mockString,
            strInstructions: mockString,
            strMealThumb: mockString,
            strTags: mockString,
            strYoutube: mockString,
            strSource: mockString,
            strImageSource: mockString,
            strCreativeCommonsConfirmed: mockString,
            dateModified: mockString,
            strIngredient1: mockString,
            strIngredient2: mockString,
            strIngredient3: mockString,
            strIngredient4: mockString,
            strIngredient5: mockString,
            strIngredient6: mockString,
            strIngredient7: mockString,
            strIngredient8: mockString,
            strIngredient9: mockString,
            strIngredient10: mockString,
            strIngredient11: mockString,
            strIngredient12: mockString,
            strIngredient13: mockString,
            strIngredient14: mockString,
            strIngredient15: mockString,
            strIngredient16: mockString,
            strIngredient17: mockString,
            strIngredient18: mockString,
            strIngredient19: mockString,
            strIngredient20: mockString,
            strMeasure1: mockString,
            strMeasure2: mockString,
            strMeasure3: mockString,
            strMeasure4: mockString,
            strMeasure5: mockString,
            strMeasure6: mockString,
            strMeasure7: mockString,
            strMeasure8: mockString,
            strMeasure9: mockString,
            strMeasure10: mockString,
            strMeasure11: mockString,
            strMeasure12: mockString,
            strMeasure13: mockString,
            strMeasure14: mockString,
            strMeasure15: mockString,
            strMeasure16: mockString,
            strMeasure17: mockString,
            strMeasure18: mockString,
            strMeasure19: mockString,
            strMeasure20: mockString
        )
    }
}
