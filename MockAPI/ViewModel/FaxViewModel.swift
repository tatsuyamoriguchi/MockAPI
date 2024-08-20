//
//  FaxViewModel.swift
//  MockAPI
//
//  Created by Tatsuya Moriguchi on 8/11/24.
//

import Foundation
//import Combine

class FaxViewModel: ObservableObject {
    private var faxService: FaxAPIServiceProtocol
//    private var cancellables = Set<AnyCancellable>() // Combine
    
    @Published var faxStatus: String = ""
    
    init(faxService: FaxAPIServiceProtocol) {
        self.faxService = faxService
    }
    
    func sendFax(toNumber: String, fileData: Data, fileType: String) {

        // Combine
//        faxService.sendFax(toNumber: toNumber, fileData: fileData, fileType: fileType)
//            .sink(receiveCompletion: { completion in
//                if case let .failure(error) = completion {
//                    self.faxStatus = "Failed send fax: \(error.localizedDescription)"
//                }
//            }, receiveValue: { response in
//                self.faxStatus = "Fax sent successfully with ID: \(response.faxId ?? "Unknown")"
//                
//            })
//            .store(in: &cancellables)
        
        // Async/Await
        Task {
            do {
                let response = try await faxService.sendFax(toNumber: toNumber, fileData: fileData, fileType: fileType)
                DispatchQueue.main.async {
                    self.faxStatus = "Fax sent successfully with ID: \(response.faxId ?? "Unknown")"
                }
                
            } catch {
                DispatchQueue.main.sync {
                    self.faxStatus = "Failed to send fax: \(error.localizedDescription)"
                }
            }
        }
    }
}
