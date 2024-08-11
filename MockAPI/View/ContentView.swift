//
//  ContentView.swift
//  MockAPI
//
//  Created by Tatsuya Moriguchi on 8/11/24.
//

import SwiftUI

struct ContentView: View {
    // To access the real API end point
     @StateObject private var viewModel = FaxViewModel(faxService: FaxAPIService())
    
    // The following uses mock API service.
//    @StateObject private var viewModel = FaxViewModel(faxService: MockFaxAPIService())
    
    var body: some View {
        VStack {
            Text("Fax Status: \(viewModel.faxStatus)")
            Button("Send Fax") {
                let dummyData = Data("Dummy PDF contnt".utf8)
                viewModel.sendFax(toNumber: "9498709543", fileData: dummyData, fileType: "pdf")
            }
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
