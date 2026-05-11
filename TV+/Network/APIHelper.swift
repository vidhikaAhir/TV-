//
//  APIHelper.swift
//  TV+
//
//  Created by neo on 5/7/26.
//

import Foundation

protocol APIClient {
    func fetchRequests<T: APIRequestHelper>(request: T) async throws -> T.response
}

class APIHelper: APIClient {
    
    func fetchRequests<T: APIRequestHelper>(request: T) async throws -> T.response {
        guard let url = URL(string: request.baseUrl + request.url) else {
            throw URLError(.badURL)
        }

        var apiRequest = URLRequest(url: url)
        apiRequest.httpMethod = request.httpMethod
        apiRequest.timeoutInterval = 10
        apiRequest.allHTTPHeaderFields = request.headers
        
        let (data, response) = try await URLSession.shared.data(for: apiRequest)
        print(apiRequest)

        guard let httpsResponse = response as? HTTPURLResponse,
              200...299 ~= httpsResponse.statusCode else {
            throw URLError(.badServerResponse)
        }
        
        do {
            let jsonObject = try JSONSerialization.jsonObject(with: data, options: [])
            let prettyData = try JSONSerialization.data(withJSONObject: jsonObject, options: [.prettyPrinted])
            
            if let prettyString = String(data: prettyData, encoding: .utf8) {
                print(prettyString)
            }
        } catch {
            throw error
        }
        return try JSONDecoder().decode(T.response.self, from: data)
    }

}
