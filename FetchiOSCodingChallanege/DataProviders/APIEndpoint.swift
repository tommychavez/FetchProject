import SwiftUI

enum APIEndpoint {
    case details(id: String)
    case categories(id: String)
    
    var url: URL? {
        guard let url = URL(string: baseUrl()) else {
            return nil
        }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.url?.append(queryItems: [queryItem()])
        return urlRequest.url
    }
    
    private func baseUrl() -> String {
        switch self {
        case .categories:
            "https://themealdb.com/api/json/v1/1/filter.php?"
        case .details:
            "https://themealdb.com/api/json/v1/1/lookup.php?"
        }
    }
    
    private func queryItem() -> URLQueryItem {
        switch self {
        case .categories(let id):
                .init(name: "c", value: id)
        case .details(let id):
                .init(name: "i", value: id)
        }
    }
}
