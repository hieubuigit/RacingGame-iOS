//
//  StartGameController.swift
//  RacingGame
//
//  Created by Hieu Bui on 7/21/20.
//  Copyright © 2020 project. All rights reserved.
//

import UIKit

class StartGameController: UIViewController {
    // Audio Game
    var audioGame = AudioGame()
    
    @IBAction func ExitGame(_ sender: UIButton) {
        sender.flashButton()
        audioGame.playerAudio(resourceName: "click_button", typeAudio: "mp3")
        exit(0)
    }
    
    override func viewDidLoad() {
        //audioGame.playerAudio(resourceName: "animal_martin", typeAudio: "mp3")
        
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
    
    @IBAction func next(_ sender: UIButton) {
        let startGameController =  EndGameController()
        sender.shakeButton()
        audioGame.playerAudio(resourceName: "click_button", typeAudio: "mp3")
        self.navigationController?.pushViewController(startGameController, animated: true)
    }
    
}
