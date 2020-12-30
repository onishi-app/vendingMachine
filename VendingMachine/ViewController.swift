//
//  ViewController.swift
//  VendingMachine
//
//  Created by ryosuke on 2020/12/30.
//

import UIKit

enum Drink {
    case irohasu
    case ryokucha
    case gogothi
}

class ViewController: UIViewController {

    // 所持金ラベル
    @IBOutlet weak var moneyLabel: UILabel!
    // 投入金額ラベル
    @IBOutlet weak var inputMoneyLabel: UILabel!
    
    var money = 1000
    var inputMoney = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
 
        
    }
    
    // 購入ボタン
    @IBAction func buyButton(_ sender: Any) {
        guard let button = sender as? UIButton else {
            return
        }
        
        switch button.tag {
        case 1:
            buyDrink(product: .irohasu)
        case 2:
            buyDrink(product: .ryokucha)
        case 3:
            buyDrink(product: .gogothi)
        default:
            return
        }
    }
    
    // 投入額選択ボタン
    @IBAction func sendMoney(_ sender: Any) {
        guard let button = sender as? UIButton else {
            return
        }
        
        switch button.tag {
        case 1:
            sendMoneyAction(value: 10)
        case 2:
            sendMoneyAction(value: 50)
        case 3:
            sendMoneyAction(value: 100)
        case 4:
            sendMoneyAction(value: 500)
        case 5:
            sendMoneyAction(value: 1000)
        default: return
        }
    }
    
    // お釣りボタン
    @IBAction func changeButton(_ sender: Any) {
    
    }
    
    func sendMoneyAction(value: Int) {
        money -= value
        inputMoney += value
        
        moneyLabel.text = "所持金：\(money)円"
        inputMoneyLabel.text = "金額：\(inputMoney)円"
    }
    
    // 購入処理
    func buyDrink(product: Drink) {
        switch product {
        case .irohasu:
            inputMoney -= 100
            inputMoneyLabel.text = "金額：\(inputMoney)円"
            print("いろはすを購入しました。")
        case .ryokucha:
            inputMoney -= 120
            inputMoneyLabel.text = "金額：\(inputMoney)円"
            print("緑茶を購入しました。")
        case .gogothi:
            inputMoney -= 150
            inputMoneyLabel.text = "金額：\(inputMoney)円"
            print("午後ティーを購入しました。")
        }
    }
}
