//
//  UpBitAPI.swift
//  SwiftUIPractice
//
//  Created by 최대성 on 9/3/24.
//

import Foundation
import SwiftUI

struct Market: Hashable, Codable {
    let market, koreanName, englishName: String
//    var isLike = false

    enum CodingKeys: String, CodingKey {
        case market
        case koreanName = "korean_name"
        case englishName = "english_name"
//        case isLike
    }
}
typealias Markets = [Market]

struct UpbitAPI {
    
    private init() { }

    static func fetchAllMarket(completion: @escaping (Markets) -> Void) {
        
        let url = URL(string: "https://api.upbit.com/v1/market/all")!
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data else { return }
            do {
                let decodedData = try JSONDecoder().decode( Markets.self, from: data)
                DispatchQueue.main.async {
                    completion(decodedData)
                }
            } catch {
                print(error)
            }
        }.resume()
    }
    
    
    static func fetchMArket() async throws -> Markets {
        let url = URL(string: "https://api.upbit.com/v1/market/all")!
        
        let (data, response) = try await URLSession.shared.data(from: url)
        
        let decodeData = try JSONDecoder().decode(Markets.self, from: data)
        
        return decodeData
        
    }
}
