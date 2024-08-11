//
//  FaxResponse.swift
//  MockAPI
//
//  Created by Tatsuya Moriguchi on 8/11/24.
//

import Foundation
import Combine

// Define a protocol for the Fax API service
protocol FaxAPIServiceProtocol {
    func sendFax(toNumber: String, fileData: Data, fileType: String) -> AnyPublisher<FaxResponse, Error> // Combine
//    func sendFax(toNumber: String, fileData: Data, fileType: String) async throws -> FaxResponse // Async/Await
}

// Define a model for the reponse.
struct FaxResponse: Codable {
    let status: String
    let faxId: String?
    let message: String?
}
