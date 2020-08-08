//
//  AudioGame.swift
//  RacingGame
//
//  Created by Hieu Bui on 8/8/20.
//  Copyright © 2020 project. All rights reserved.
//

import Foundation
import AVFoundation

class AudioGame {
    
    // MARK: Properties
    var player: AVAudioPlayer?
    
    func playerAudio(resourceName: String, typeAudio: String) {
        /*if let player = player, player.isPlaying {
         // stop the playback
         player.stop()
         } else {*/
        // set up the audio and play
        let urlString = Bundle.main.path(forResource: resourceName, ofType: typeAudio)
        do {
            try AVAudioSession.sharedInstance().setMode(.default)
            try AVAudioSession.sharedInstance().setActive(true, options: .notifyOthersOnDeactivation)
            guard let urlString = urlString else {
                return
            }
            
            player = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: urlString))
            guard let player = player else {
                return
            }
            
            player.play()
            
        } catch {
            print("Something went wrong!")
        }
        //}
    }
}
