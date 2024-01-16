//
//  BeerManager.swift
//  Network
//
//  Created by SangRae Kim on 1/16/24.
//

import UIKit
import Alamofire

struct Beer: Codable {
    var name: String
    var description: String
    var image_url: String?
}

struct BeerManager {
    let url = "https://api.punkapi.com/v2/beers/random"
    func requestToServer(completionHandler: @escaping (Beer) -> Void) {
        AF.request(url, method: .get).responseDecodable(of: [Beer].self) { response in
            switch response.result {
            case .success(let success):
                completionHandler(success[0])
            case .failure(let failure):
                print(failure)
            }
        }
    }
}
