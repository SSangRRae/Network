//
//  LotteryManager.swift
//  Network
//
//  Created by SangRae Kim on 1/16/24.
//

import UIKit
import Alamofire

struct Lottery: Codable {
    let drwNoDate: String
    let drwNo: Int
    let drwtNo1: Int
    let drwtNo2: Int
    let drwtNo3: Int
    let drwtNo4: Int
    let drwtNo5: Int
    let drwtNo6: Int
    let bnusNo: Int
    
    var returnNumbers: [Int] {
        return [drwtNo1, drwtNo2, drwtNo3, drwtNo4, drwtNo5, drwtNo6, bnusNo]
    }
}

struct NumbersColor {
    var number: Int
    var color: CGColor {
        switch number {
        case 1...10: return UIColor.yellow.cgColor
        case 11...20: return UIColor.blue.cgColor
        case 21...30: return UIColor.red.cgColor
        case 31...40: return UIColor.gray.cgColor
        case 41...45: return UIColor.green.cgColor
        default: return UIColor.white.cgColor
        }
    }
}

struct LotteryManager {
    func requestToServer(round: String, completionHandler: @escaping (Lottery) -> Void){
        let url = "https://www.dhlottery.co.kr/common.do?method=getLottoNumber&drwNo=\(round)"
        AF.request(url, method: .get).responseDecodable(of: Lottery.self) { response in
            switch response.result {
            case .success(let success):
                completionHandler(success)
            case .failure(let failure):
                print(failure)
            }
        }
    }
}
