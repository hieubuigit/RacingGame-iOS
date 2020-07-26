//
//  StartGameController.swift
//  RacingGame
//
//  Created by Hieu Bui on 7/21/20.
//  Copyright © 2020 project. All rights reserved.
//

import UIKit

class StartGameController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    @IBAction func next(_ sender: Any) {
       let startGameController =  EndGameController()
             self.navigationController?.pushViewController(startGameController, animated: true)
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
