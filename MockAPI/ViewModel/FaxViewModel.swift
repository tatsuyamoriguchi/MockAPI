//
//  FaxViewModel.swift
//  MockAPI
//
//  Created by Tatsuya Moriguchi on 8/11/24.
//

import Foundation
import Combine

class FaxViewModel: ObservableObject {
    private var faxService: FaxAPIServiceProtocol
    private var cancellables = Set<AnyCancellable>()
    
    @Published var faxStatus: String = ""
    
    init(faxService: FaxAPIServiceProtocol) {
        self.faxService = faxService
    }
    
    func sendFax(toNumber: String, fileData: Data, fileType: String) {
        faxService.sendFax(toNumber: toNumber, fileData: fileData, fileType: fileType)
            .sink(receiveCompletion: { completion in
                if case let .failure(error) = completion {
                    self.faxStatus = "Failed send fax: \(error.localizedDescription)"
                }
            }, receiveValue: { response in
                self.faxStatus = "Fax sent successfully with ID: \(response.faxId ?? "Unknown")"
                
            })
            .store(in: &cancellables)
    }
     
    
}
