//
//  PlayingGameController.swift
//  RacingGame
//
//  Created by Hieu Bui on 7/21/20.
//  Copyright © 2020 project. All rights reserved.
//

import UIKit

class PlayingGameController: UIViewController {

    var Score = ""
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func next(_ sender: Any) {
        //EndGame()
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    /*func EndGame(){
           //self.Score = lblDiem.text ?? ""
         self.Score = "1"
           performSegue(withIdentifier: "EndGame", sender: self)
       }
       
       override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
           let vc = segue.destination as! EndGameController
           vc.Score = self.Score
       }*/
}
