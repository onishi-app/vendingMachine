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
    
    var irohasuStock = 3
    var ryokuchaStock = 2
    var gogothiStock = 1
    
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
            guard let result = sendMoneyAction(value: 10) else {
                print("所持金が不足しています。")
                return
            }
            print(result)
        case 2:
            guard let result = sendMoneyAction(value: 50) else {
                print("所持金が不足しています。")
                return
            }
            print(result)
        case 3:
            guard let result = sendMoneyAction(value: 100) else {
                print("所持金が不足しています。")
                return
            }
            print(result)
        case 4:
            guard let result = sendMoneyAction(value: 500) else {
                print("所持金が不足しています。")
                return
            }
            print(result)
        case 5:
            guard let result = sendMoneyAction(value: 1000) else {
                print("所持金が不足しています。")
                return
            }
            print(result)
        default: return
        }
    }
    
    // おつりボタン
    @IBAction func changeButton(_ sender: Any) {
        money += inputMoney
        print("\(inputMoney)円のおつりをもらいました")
        inputMoney = 0
        moneyLabel.text = "所持金：\(money)円"
        inputMoneyLabel.text = "金額：\(inputMoney)円"
    }
    
    func sendMoneyAction(value: Int) -> String? {
        if money < value {
            return nil
        }
        
        money -= value
        inputMoney += value
        moneyLabel.text = "所持金：\(money)円"
        inputMoneyLabel.text = "金額：\(inputMoney)円"
        
        return "\(value)円を入れました。"
    }
    
    // 購入処理
    func buyDrink(product: Drink) {
        switch product {
        case .irohasu:
            if !inventoryControl(product: product) {
                print("在庫がありません。")
                return
            }
            if inputMoney - 100 < 0 {
                print("お金が足りません。")
                return
            }
            inputMoney -= 100
            inputMoneyLabel.text = "金額：\(inputMoney)円"
            print("いろはすを購入しました。")
        case .ryokucha:
            if !inventoryControl(product: product) {
                print("在庫がありません。")
                return
            }
            if inputMoney - 120 < 0 {
                print("お金が足りません。")
                return
            }
            inputMoney -= 120
            inputMoneyLabel.text = "金額：\(inputMoney)円"
            print("緑茶を購入しました。")
        case .gogothi:
            if !inventoryControl(product: product) {
                print("在庫がありません。")
                return
            }
            if inputMoney - 150 < 0 {
                print("お金が足りません。")
                return
            }
            inputMoney -= 150
            inputMoneyLabel.text = "金額：\(inputMoney)円"
            print("午後ティーを購入しました。")
        }
    }
    
    // 在庫管理
    func inventoryControl(product: Drink) -> Bool {
        switch product {
        case .irohasu:
            if irohasuStock == 0 {
                return false
            }
            irohasuStock -= 1
            return true
        case .ryokucha:
            if ryokuchaStock == 0 {
                return false
            }
            ryokuchaStock -= 1
            return true
        case .gogothi:
            if gogothiStock == 0 {
                return false
            }
            gogothiStock -= 1
            return true
        }
    }
}

