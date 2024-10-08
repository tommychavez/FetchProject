import SwiftUI

struct DataProvider {
    func getData<T: Decodable>(apiEndpoint: APIEndpoint) async throws -> T {
        if let url = apiEndpoint.url {
            do {
                let (data, response) = try await URLSession.shared.data(from: url)
                if let urlResponse = response as? HTTPURLResponse, urlResponse.statusCode >= 200, urlResponse.statusCode < 300 {
                    let decodedResponse  = try JSONDecoder().decode(T.self, from: data)
                    return decodedResponse
                }
                throw URLError(.badServerResponse)
            } catch {
                throw URLError(.cannotDecodeRawData)
            }
        }
        throw URLError(.badURL)
    }
}
