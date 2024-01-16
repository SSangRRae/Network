//
//  BeerManager.swift
//  Network
//
//  Created by SangRae Kim on 1/16/24.
//

import UIKit
import Alamofire

struct Beer: Codable {
    var id: Int
    var name: String
    var description: String
    var image_url: String?
}

struct BeerManager {
    let url: String
    
    func requestToRandomServer(completionHandler: @escaping (Beer) -> Void) {
        AF.request(url, method: .get).responseDecodable(of: [Beer].self) { response in
            switch response.result {
            case .success(let success):
                completionHandler(success[0])
            case .failure(let failure):
                print(failure)
            }
        }
    }
    
    func requestToListServer(completionHandler: @escaping ([Beer]) -> Void) {
        AF.request(url, method: .get).responseDecodable(of: [Beer].self) { response in
            switch response.result {
            case .success(let success):
                print(success)
                completionHandler(success)
            case .failure(let failure):
                print(failure)
            }
        }
    }
}
