//
//  FaxAPIService.swift
//  MockAPI
//
//  Created by Tatsuya Moriguchi on 8/11/24.
//

import Foundation
import Combine

class FaxAPIService: FaxAPIServiceProtocol {
    // Dummy url
    private let baseURL = "https://restapi.efaxcorporate.com/v1.0/faxes"
    
    func sendFax(toNumber: String, fileData: Data, fileType: String) -> AnyPublisher<FaxResponse, any Error> { // Comobine
//    func sendFax(toNumber: String, fileData: Data, fileType: String) async throws -> FaxResponse {  // Async/Await

        guard let url = URL(string: baseURL) else {
            return Fail(error: URLError(.badURL)).eraseToAnyPublisher() // Combine
//            throw URLError(.badURL) // Async/Await
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("Bearer YOUT_API_TOKEN", forHTTPHeaderField: "Authorization")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let body = [
        "to": toNumber,
        "fileData": fileData.base64EncodedString(),
        "fileType": fileType
        ]

        // Combine
        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: body, options: [])
        } catch {
            return Fail(error: error).eraseToAnyPublisher()
        }

        // Async/Await
//        request.httpBody = try JSONSerialization.data(withJSONObject: body, options: [])
        

        // Combine
        return URLSession.shared.dataTaskPublisher(for: request)
            .map(\.data)
            .decode(type: FaxResponse.self, decoder: JSONDecoder())
            .eraseToAnyPublisher()

        // Async/Await
//        let (data, _) = try await URLSession.shared.data(for: request)
//        return try JSONDecoder().decode(FaxResponse.self, from: data)
    }
}

