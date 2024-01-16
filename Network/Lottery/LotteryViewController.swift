//
//  LotteryViewController.swift
//  Network
//
//  Created by SangRae Kim on 1/16/24.
//

import UIKit

class LotteryViewController: UIViewController {

    @IBOutlet var textField: UITextField!
    @IBOutlet var numberLabels: [UILabel]!
    
    var pickerView = UIPickerView()
    let numberList: [Int] = Array(1...1102).reversed()
    let manager = LotteryManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configure()
        manager.requestToServer(round: "1102") { lottery in
            self.showNumbers(lottery: lottery)
        }
    }
}

extension LotteryViewController {
    func configure() {
        navigationItem.title = "Lottery"
        
        textField.tintColor = .clear
        textField.inputView = pickerView
        
        pickerView.delegate = self
        pickerView.dataSource = self
        
        for numberLabel in numberLabels {
            numberLabel.textColor = .black
            numberLabel.textAlignment = .center
            numberLabel.font = .boldSystemFont(ofSize: 16)
            numberLabel.layer.borderWidth = 1
            numberLabel.layer.borderColor = UIColor.black.cgColor
            numberLabel.layer.cornerRadius = numberLabel.frame.width / 2
        }
    }
    
    func showNumbers(lottery: Lottery) {
        for idx in 0...numberLabels.count - 1 {
            numberLabels[idx].text = "\(lottery.returnNumbers[idx])"
            numberLabels[idx].layer.backgroundColor = NumbersColor(number: lottery.returnNumbers[idx]).color
        }
    }
}

extension LotteryViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return numberList.count
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        textField.text = "\(numberList[row])회차"
        manager.requestToServer(round: "\(numberList[row])") { lottery in
            self.showNumbers(lottery: lottery)
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return "\(numberList[row])회차"
    }
}
