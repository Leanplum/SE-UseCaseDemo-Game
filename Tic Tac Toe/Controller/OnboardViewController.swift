//
//  OnboardViewController.swift
//  Leanplum Game Demo - Tic Tac Toe
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
    
    var onboardTrack = LPVar.define("onboard", with: false)
    var btnRadius = LPVar.define("radius", with: 4.0)
    var companyNameTitle = LPVar.define("companyNameTitle", with: "LEANPLUM DEMO")
    var picture1 = LPVar.define("picture1", withFile: "image4.png")
    var picture2 = LPVar.define("picture2", withFile: "image4.png")
    var picture3 = LPVar.define("picture3", withFile: "image4.png")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        Leanplum.onVariablesChanged({
                        
            self.screenOnePic?.image = self.picture1?.imageValue()
            self.screenTwoPic?.image = self.picture2?.imageValue()
            self.screenThreePic?.image = self.picture3?.imageValue()
            
            self.titleLabel.text = (self.companyNameTitle?.stringValue!)

        })

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
