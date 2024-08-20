//
//  MockAPIService.swift
//  MockAPI
//
//  Created by Tatsuya Moriguchi on 8/11/24.
//

import Foundation
//import Combine

class MockFaxAPIService: FaxAPIServiceProtocol {

//    func sendFax(toNumber: String, fileData: Data, fileType: String) -> AnyPublisher<FaxResponse, Error> { // Combiine
    func sendFax(toNumber: String, fileData: Data, fileType: String) async throws -> FaxResponse { // Async/Await

        // Combine
        //        let mockResponse = FaxResponse(status: "success", faxId: "123456789", message: "Fax sent successfully")
//        return Just(mockResponse)
//            .setFailureType(to: Error.self)
//            .eraseToAnyPublisher()
        
        // Async/Await
        return FaxResponse(status: "success", faxId: "123456789", message: "Fax sent successfully")
    }
}
