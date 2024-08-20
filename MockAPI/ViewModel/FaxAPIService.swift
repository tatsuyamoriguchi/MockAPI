//
//  FaxAPIService.swift
//  MockAPI
//
//  Created by Tatsuya Moriguchi on 8/11/24.
//

import Foundation
//import Combine

class FaxAPIService: FaxAPIServiceProtocol {
    // Dummy url
    private let baseURL = "https://restapi.efaxcorporate.com/v1.0/faxes"
    
//    func sendFax(toNumber: String, fileData: Data, fileType: String) -> AnyPublisher<FaxResponse, any Error> { // Comobine
//    function sendFax(toNumber, fileData, fileType) returns FaxResponse (async, throws) {

    func sendFax(toNumber: String, fileData: Data, fileType: String) async throws -> FaxResponse {  

        //Async/Await
        // Step 1: Validate the base URL string
        // if baseURL is not a valid URL:
        // throw an error indicating a bad URL
        guard let url = URL(string: baseURL) else {
//            return Fail(error: URLError(.badURL)).eraseToAnyPublisher() // Combine
            throw URLError(.badURL) // Async/Await
        }
        // Step 2: Create a URL request object
        // create a URLRequest object with the URL
        var request = URLRequest(url: url)
        
        // Step 3: Set the HTTP method to POST
        // set the HTTP method of the request to POST
        request.httpMethod = "POST"

        // Step 4: Add necessary headers to the request
        // add an "Authorization" header with the value "Bearer YOUR_API_TOKEN"
        request.addValue("Bearer YOUT_API_TOKEN", forHTTPHeaderField: "Authorization")
        // add a "Content-Type" header with the value "application/json"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        // Step 5: Prepare the request body
        // create a dictionary (or map) for the request body containing:
        //    "to" : toNumber
        //    "fileData" : base64 encoded string of fileData
        //    "fileType" : fileType
        let body = [
        "to": toNumber,
        "fileData": fileData.base64EncodedString(),
        "fileType": fileType
        ]

        // Combine
//        do {
//            request.httpBody = try JSONSerialization.data(withJSONObject: body, options: [])
//        } catch {
//            return Fail(error: error).eraseToAnyPublisher()
//        }

        // Async/Await
        // Step 6: Convert the request body to JSON format
        // convert the dictionary (or map) to JSON data
        // set this JSON data as the HTTP body of the request
        request.httpBody = try JSONSerialization.data(withJSONObject: body, options: [])
        

        // Combine
//        return URLSession.shared.dataTaskPublisher(for: request)
//            .map(\.data)
//            .decode(type: FaxResponse.self, decoder: JSONDecoder())
//            .eraseToAnyPublisher()

        // Async/Await
        // Step 7: Perform the network request asynchronously
        // execute the network request using URLSession, waiting for the response
        let (data, _) = try await URLSession.shared.data(for: request)

        // Step 8: Decode the response data into a FaxResponse object
        // decode the received data into a FaxResponse object
        // Step 9: Return the decoded FaxResponse object
        // return the FaxResponse object
        return try JSONDecoder().decode(FaxResponse.self, from: data)
    }
}



/*
 function sendFax(toNumber, fileData, fileType) returns FaxResponse (async, throws) {
     // Step 1: Validate the base URL string
     if baseURL is not a valid URL:
         throw an error indicating a bad URL
     
     // Step 2: Create a URL request object
     create a URLRequest object with the URL
     
     // Step 3: Set the HTTP method to POST
     set the HTTP method of the request to POST
     
     // Step 4: Add necessary headers to the request
     add an "Authorization" header with the value "Bearer YOUR_API_TOKEN"
     add a "Content-Type" header with the value "application/json"
     
     // Step 5: Prepare the request body
     create a dictionary (or map) for the request body containing:
         "to" : toNumber
         "fileData" : base64 encoded string of fileData
         "fileType" : fileType
     
     // Step 6: Convert the request body to JSON format
     convert the dictionary (or map) to JSON data
     set this JSON data as the HTTP body of the request
     
     // Step 7: Perform the network request asynchronously
     execute the network request using URLSession, waiting for the response
     
     // Step 8: Decode the response data into a FaxResponse object
     decode the received data into a FaxResponse object
     
     // Step 9: Return the decoded FaxResponse object
     return the FaxResponse object
 }

 */

