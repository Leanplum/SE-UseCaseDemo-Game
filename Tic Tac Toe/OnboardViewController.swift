//
//  OnboardViewController.swift
//  Tic Tac Toe
//
//  Created by Zach Owens on 12/11/19.
//  Copyright © 2019 Zach Owens. All rights reserved.
//

import UIKit
import Leanplum

class OnboardViewController: UIViewController {

    @IBOutlet weak var screenOnePic: UIImageView!
    @IBOutlet weak var screenTwoPic: UIImageView!
    @IBOutlet weak var screenThreePic: UIImageView!
    @IBOutlet weak var loginBtn: UIButton!
    @IBOutlet weak var titleLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        Leanplum.onVariablesChanged {
                        
            self.screenOnePic?.image = picture1?.imageValue()
            self.screenTwoPic?.image = picture2?.imageValue()
            self.screenThreePic?.image = picture3?.imageValue()
            
            self.titleLabel.text = (companyNameTitle?.stringValue!)

        }

    }
    
    @IBAction func skipBtn(_ sender: Any) {
        
        let loginVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "HomeViewController") as! LoginViewController
        if let vc = UIApplication.shared.keyWindow?.rootViewController {
            vc.show(loginVC, sender: (Any).self)
        }
        
    }
    
    @IBAction func loginBtn(_ sender: Any) {
        
        let loginVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "HomeViewController") as! LoginViewController
        if let vc = UIApplication.shared.keyWindow?.rootViewController {
            vc.show(loginVC, sender: (Any).self)
        }
        
    }
    
    
}
