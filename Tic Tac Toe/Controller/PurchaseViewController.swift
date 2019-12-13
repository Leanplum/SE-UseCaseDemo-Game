//
//  PurchaseViewController.swift
//  Leanplum Game Demo - Tic Tac Toe
//
//  Created by Zach Owens on 12/4/19.
//  Copyright © 2019 Zach Owens. All rights reserved.
//

import UIKit
import Leanplum

class PurchaseViewController: UIViewController {

    @IBOutlet weak var purchaseBtn: UIButton!
    @IBOutlet weak var backToGame: UIButton!
    @IBOutlet weak var smallPriceLabel: UILabel!
    @IBOutlet weak var largePriceLabel: UILabel!
    @IBOutlet weak var smallCreditBtn: UIButton!
    @IBOutlet weak var largeCreditBtn: UIButton!
    
    var smallCredits = 3
    var largeCredits = 6
    var userLogin = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        purchaseBtn.setTitle("Purchase Credits", for: .normal)
        
        Leanplum.onVariablesChanged {
            
            self.userLogin = (userId?.stringValue)!
            self.smallPriceLabel.text = "\(self.smallCredits) credits $\((smallPrice?.doubleValue())!)"
            self.largePriceLabel.text = "\(self.largeCredits) credits $\((largePrice?.doubleValue())!)"
            
            self.purchaseBtn.layer.cornerRadius = (btnRadius?.cgFloatValue())!
            self.backToGame.layer.cornerRadius = (btnRadius?.cgFloatValue())!
            
        }
        
    }
    
    @IBAction func smallCreditBtn(_ sender: UIButton) {
        
        purchaseBtn.setTitle("Purchase \(smallCredits) credits $\((smallPrice?.doubleValue())!)", for: .normal)
        smallCreditBtn.isSelected = true
        
    }
    
    @IBAction func largeCreditBtn(_ sender: UIButton) {
        
        purchaseBtn.setTitle("Purchase \(largeCredits) credits $\((largePrice?.doubleValue())!)", for: .normal)
        largeCreditBtn.isSelected = true
    }
    
    @IBAction func purchaseBtn(_ sender: UIButton) {
        
        
        if smallCreditBtn.isSelected {
            
            Leanplum.track("Purchase", withParameters: ["price" : (smallPrice?.doubleValue())!])
            incrementUserAttribute(credits: smallCredits, userid: userLogin)
            purchaseBtn.setTitle("Purchase Credits", for: .normal)
            smallCreditBtn.isSelected = false
            
            let gameVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "gameVC") as! GameViewController
            if let vc = UIApplication.shared.keyWindow?.rootViewController {
                vc.show(gameVC, sender: (Any).self)
            }
            
        } else if largeCreditBtn.isSelected {
            
            Leanplum.track("Purchase", withParameters: ["price" : (largePrice?.doubleValue())!])
            incrementUserAttribute(credits: largeCredits, userid: userLogin)
            purchaseBtn.setTitle("Purchase Credits", for: .normal)
            largeCreditBtn.isSelected = false
            
            let gameVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "gameVC") as! GameViewController
            if let vc = UIApplication.shared.keyWindow?.rootViewController {
                vc.show(gameVC, sender: (Any).self)
            }
            
        } else {
            
            print("no button selected")
            
        }
        
    }
    
}


extension PurchaseViewController {
    
    private func incrementUserAttribute(credits: Int, userid: String) {
        
        let json: [String: Any] = ["action": "setUserAttributes",
                                   "appId": "app_S8Yt8OeAK2Ovgrq0F8Je3S3V8g0U4ar8Cv2E7e9Lgz0",
                                   "clientKey": "dev_308Z1YC7TgWSLlFPvcf3c0WtbazKAwpEegElKcDZe9A",
                                   "apiVersion": "1.0.6",
                                   "userAttributeValuesToIncrement": ["Total Credits Purchased": "\(credits)"],
                                    "devMode": "True",
                                    "userId": "\(userid)"]

        let jsonData = try? JSONSerialization.data(withJSONObject: json)

        print(jsonData!)
        
        // create post request
        let url = URL(string: "https://www.leanplum.com/api?action=setUserAttributes")!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"

        // insert json data to the request
        request.httpBody = jsonData

        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {
                print(error?.localizedDescription ?? "No data")
                return
            }
            let responseJSON = try? JSONSerialization.jsonObject(with: data, options: [])
            if let responseJSON = responseJSON as? [String: Any] {
                print(responseJSON)
            }
        }

        task.resume()
    }
    
}
