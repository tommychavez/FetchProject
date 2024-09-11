import SwiftUI

struct MockThrowingDetailDataProvider: DetailDataProvider {
    func getDetails(id: String) async throws -> MealDetailsDTO {
        throw URLError(.unknown)
    }
}
