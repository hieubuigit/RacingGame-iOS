//
//  StartGameController.swift
//  RacingGame
//
//  Created by Hieu Bui on 7/21/20.
//  Copyright © 2020 project. All rights reserved.
//

import UIKit

class StartGameController: UIViewController {

    @IBAction func ExitGame(_ sender: UIButton) {
        exit(0)
    }
    
    override func viewDidLoad() {
       super.viewDidLoad()
        AppDelegate.AppUtility.lockOrientation(.portrait)
        // Do any additional setup after loading the view.
    }
    
    /*struct AppUtility {

        static func lockOrientation(_ orientation: UIInterfaceOrientationMask) {

            if let delegate = UIApplication.shared.delegate as? AppDelegate {
                delegate.orientationLock = orientation
            }
        }

        /// OPTIONAL Added method to adjust lock and rotate to the desired orientation
        static func lockOrientation(_ orientation: UIInterfaceOrientationMask, andRotateTo rotateOrientation:UIInterfaceOrientation) {

            self.lockOrientation(orientation)

            UIDevice.current.setValue(rotateOrientation.rawValue, forKey: "orientation")
            UINavigationController.attemptRotationToDeviceOrientation()
        }

    }*/

    @IBAction func next(_ sender: Any) {
       let startGameController =  EndGameController()
             self.navigationController?.pushViewController(startGameController, animated: true)
    }
   

}
