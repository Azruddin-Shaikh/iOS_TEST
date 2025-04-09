//
//  MockService.swift
//  iOS_Exam
//
//  Created by Azruddin Shaikh on 09/04/25.
//

import Foundation

class MockService {
    
    static let shared = MockService()
    
    private init() {}
    
    func loadMockJson() -> [MockItem]? {
        guard let url = Bundle.main.url(forResource: "MockJson", withExtension: "json") else {
            print("MockJson.json file not found")
            return nil
        }
        
        do {
            let data = try Data(contentsOf: url)
            let items = try JSONDecoder().decode([MockItem].self, from: data)
            return items
        } catch {
            print("Error decoding MockJson.json: \(error)")
            return nil
        }
    }

}
