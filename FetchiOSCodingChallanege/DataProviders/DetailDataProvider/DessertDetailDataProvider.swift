import SwiftUI

struct DessertDetailDataProvider: DetailDataProvider {
    func getDetails(id: String) async throws -> MealDetailsDTO {
        try await DataProvider().getData(apiEndpoint: .details(id: id))
    }
}
