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

enum SomeError: Error {
    case inventoryShortage(reason: String)
    case lackOfMoney(reason: String)
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
            do {
                try checkCondition(product: product, price: 100)
            } catch {
                print(error)
                return
            }
            inputMoney -= 100
            inputMoneyLabel.text = "金額：\(inputMoney)円"
            print("いろはすを購入しました。")
        case .ryokucha:
            do {
                try checkCondition(product: product, price: 120)
            } catch {
                print(error)
                return
            }
            inputMoney -= 120
            inputMoneyLabel.text = "金額：\(inputMoney)円"
            print("緑茶を購入しました。")
        case .gogothi:
            do {
                try checkCondition(product: product, price: 150)
            } catch {
                print(error)
                return
            }
            inputMoney -= 150
            inputMoneyLabel.text = "金額：\(inputMoney)円"
            print("午後ティーを購入しました。")
        }
    }
    
    //購入条件チェック
    func checkCondition(product: Drink, price: Int) throws {
        switch product {
        case .irohasu:
            if irohasuStock == 0 {
                throw SomeError.inventoryShortage(reason: "いろはすの在庫がありません。")
            } else if inputMoney < price  {
                throw SomeError.lackOfMoney(reason: "\(inputMoney)円しか入れられていないので、いろはすを購入できません。")
            }
            irohasuStock -= 1
        case .ryokucha:
            if ryokuchaStock == 0 {
                throw SomeError.inventoryShortage(reason: "緑茶の在庫がありません。")
            } else if inputMoney < price {
                throw SomeError.lackOfMoney(reason: "\(inputMoney)円しか入れられていないので、緑茶を購入できません。")
            }
            ryokuchaStock -= 1
        case .gogothi:
            if gogothiStock == 0 {
                throw SomeError.inventoryShortage(reason: "午後ティーの在庫がありません。")
            } else if inputMoney < price {
                throw SomeError.lackOfMoney(reason: "\(inputMoney)円しか入れられていないので、午後ティーを購入できません。")
            }
            gogothiStock -= 1
        }
    }
}
