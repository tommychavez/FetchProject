protocol DetailDataProvider {
    func getDetails(id: String) async throws -> MealDetailsDTO
}
