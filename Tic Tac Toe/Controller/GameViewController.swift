//
//  GameViewController.swift
//  Leanplum Game Demo - Tic Tac Toe
//
//  Created by Zach Owens on 1/23/19.
//  Copyright © 2019 Zach Owens. All rights reserved.
//

import UIKit
import Leanplum
import os.log

class GameViewController: UIViewController {

    var activePlayer = 1 //cross
    var gameState = [0,0,0,0,0,0,0,0,0]
    let winningCombos = [[0,1,2],[3,4,5],[6,7,8],[0,3,6],[1,4,7],[2,5,8],[0,4,8],[2,4,6]]
    var gameIsActive = true

    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var welcomeLabel: UILabel!
    @IBOutlet weak var backgroundImage: UIImageView!
    
    var delegate = UIApplication.shared.delegate as! AppDelegate
    
    var userLogin = ""
    var email = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        Leanplum.advance(to: "firstGame")

        label.isHidden = true
        
        print("user logged in is: \(userLogin)")
        
        Leanplum.forceContentUpdate()
        
        welcomeText?.onValueChanged( {
            self.welcomeLabel.text = welcomeText?.stringValue
            
            
        })
        
    }

    @IBAction func gameButton(_ sender: UIButton) {

        if (gameState[sender.tag-1] == 0 && gameIsActive == true)
        {

        gameState[sender.tag-1] = activePlayer
            
        if activePlayer == 1 {
            sender.setImage(UIImage(named: "cross"), for: UIControl.State())
            activePlayer = 2
        }
        else {
            sender.setImage(UIImage(named: "nought"), for: UIControl.State())
            activePlayer = 1
        }
    }
        var winner: String!
        
        for combo in winningCombos {
            if gameState[combo[0]] != 0 && gameState[combo[0]] == gameState[combo[1]] && gameState[combo[1]] == gameState[combo[2]]  {
                
                gameIsActive = false
                
                if gameState[combo[0]] == 1 {
                    winner = "cross"
                    label.text = "Cross has Won"
                }
                else{
                    winner = "nought"
                    label.text = "Nought has Won"
                }
                
                label.isHidden = false
                playAgainButton.isHidden = false

                Leanplum.track("gameResult", withParameters: ["winner" : winner])
            }
        }
        
        gameIsActive = false
        
        for i in gameState{
            if i == 0{
                gameIsActive = true
                break
            }
        }
            if gameIsActive == false{
                label.text = "Game is a Draw"
                winner = "draw"
                label.isHidden = false
                playAgainButton.isHidden = false

                Leanplum.track("gameResult", withParameters: ["winner" : winner])
            }
        }
    
    @IBOutlet weak var playAgainButton: UIButton!
    @IBAction func playAgain(_ sender: UIButton) {
        
        gameState = [0,0,0,0,0,0,0,0,0]
        activePlayer = 1
        gameIsActive = true
        
        label.isHidden = true
        playAgainButton.isHidden = true

        Leanplum.advance(to: "newGame")
        
        for i in 1...9{
            
            let button = view.viewWithTag(i) as! UIButton
            button.setImage(nil, for: UIControl.State())
        }
         
    }
    
    @IBAction func purchaseBtn(_ sender: UIButton) {
        
        performSegue(withIdentifier: "purchaseSegue", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "purchaseSegue" {
            let nextViewController = segue.destination as! PurchaseViewController
            nextViewController.userLogin = userLogin

        }
    }
    

    
}

