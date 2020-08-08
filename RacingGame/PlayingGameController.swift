//
//  PlayingGameController.swift
//  RacingGame
//
//  Created by Hieu Bui on 7/21/20.
//  Copyright © 2020 project. All rights reserved.
//

import UIKit
import AVFoundation

class PlayingGameController: UIViewController {
    
    var timer:Timer!
    var gameIsPause: Bool = false
    var w:CGFloat!, h:CGFloat!
    var Score = ""
    
    // Audio Game
    var audioGame = AudioGame()
    
    @IBOutlet weak var lblDiem: UILabel!
    @IBOutlet weak var xe: UIImageView!
    @IBOutlet weak var xe1: UIImageView!
    @IBOutlet weak var xe2: UIImageView!
    @IBOutlet weak var xe3: UIImageView!
    @IBOutlet weak var coin: UIImageView!
    @IBOutlet weak var racetrack: UIImageView!
    
    // Button Pause Game
    var isTapped: Bool = false
    @IBOutlet weak var pauseAndResume: UIButton!
    
    @IBAction func buttonControl(_ sender: UIButton) {
        if isTapped {
            sender.pulseButton()    // Animation for button
            audioGame.playerAudio(resourceName: "click_button", typeAudio: "mp3")
            
            pauseAndResume.setImage(UIImage(named: "pause_button"), for: .normal)
            isTapped = false
            timer = Timer.scheduledTimer(timeInterval: 0.005, target: self, selector: #selector(ChayXe), userInfo: nil, repeats: true)
        } else {
            sender.flashButton()    // Animation for button
            audioGame.playerAudio(resourceName: "click_button", typeAudio: "mp3")
            
            pauseAndResume.setImage(UIImage(named: "play_button"), for: .normal)
            isTapped = true
            timer.invalidate()
        }
    }
    
    // Tinh tien khi vuot qua mot xe
    func chayXeVaTien (object: UIImageView) {
        object.frame = CGRect(x: object.frame.origin.x, y: object.frame.origin.y + 1, width: object.frame.size.width, height: object.frame.size.height)
    }
    
    // Tinh diem khi player's Car vuot qua cac car khac
    func tinhDiemKhiVuotQuaXe(xe: UIImageView) {
        if xe.frame.origin.y == h {
            xe.frame.origin.y = 0 - 135
            let r:Float = Float(arc4random_uniform(UInt32(w)))
            xe.frame.origin.x = CGFloat(r)
            
            guard let text = self.lblDiem.text else { return }
            var diem = Int(text)
            diem = diem! + 1
            lblDiem.text = String(diem!)
        }
    }
    
    @objc func ChayXe() {
        // Racetrack Moving
        //roadMoving(racetrack: racetrack)
        
        // Xuat hien ngau nhien xe va tien
        chayXeVaTien(object: xe1)
        chayXeVaTien(object: xe2)
        chayXeVaTien(object: xe3)
        chayXeVaTien(object: coin)
        
        // Tinh diem khi plyer's vuot qua cac car khac
        tinhDiemKhiVuotQuaXe(xe: xe1)
        tinhDiemKhiVuotQuaXe(xe: xe2)
        tinhDiemKhiVuotQuaXe(xe: xe3)
        
        // Xuat hien lai coin khi Player's Car khong cham
        if coin.frame.origin.y == h {
            coin.frame.origin.y = 0 - 39
            let r:Float = Float(arc4random_uniform(UInt32(w)))
            coin.frame.origin.x = CGFloat(r)
        }
        
        // Kiem tra Player's Car cham vao Car khac
        if xe1.frame.intersects(xe.frame) || xe2.frame.intersects(xe.frame) || xe3.frame.intersects(xe.frame) {
            timer.invalidate()
            EndGame()
        }
        
        // Tinh diem khi Player's Car cham vao coin (Hieu Bui)
        if coin.frame.intersects(xe.frame) {
            audioGame.playerAudio(resourceName: "coin_sound_effect", typeAudio: "mp3")
            
            coin.frame.origin.y = 0 - 39
            let r:Float = Float(arc4random_uniform(UInt32(w)))
            
            coin.frame.origin.x = CGFloat(r)
            guard let text = self.lblDiem.text else { return }
            var diem = Int(text)
            diem = diem! + 10
            
            lblDiem.text = String(diem!)
        }
    }
    
    // MARK: Move the Player's Car
    @IBAction func KeoTha(_ sender: UIPanGestureRecognizer) {
        let tran = sender.translation(in: self.view)
        sender.view!.center = CGPoint(x: sender.view!.center.x + tran.x, y: sender.view!.center.y)
        sender.setTranslation(CoreGraphics.CGPoint.zero, in: self.view)
    }
    
    // MARK: Animation for the coin (Hieu Bui)
    var coins: [UIImage] = []
    
    func createImageArray(totalImage: Int, imagePrefix: String) -> [UIImage] {
        var imageArray: [UIImage] = []
        for imageCount in 1...totalImage {
            let imageName = "\(imagePrefix)_\(imageCount).png"
            let image = UIImage(named: imageName)!
            
            imageArray.append(image)
        }
        return imageArray
    }
    
    func animateCoin(imageView: UIImageView, images: [UIImage]) {
        imageView.animationImages = images
        imageView.startAnimating()
    }
    
    func coinExe() {
        coins = createImageArray(totalImage: 6, imagePrefix: "coin")
        animateCoin(imageView: coin, images: coins)
    }
    
    // MARK: ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        // Animation for coin
        // Set up animation for coin
        UIView.animate(withDuration: 0.75, animations: coinExe, completion: nil)
        
        // Cho diem gia tri bang 0
        lblDiem.text = "0"
        
        // Lay kich thuot man hinh
        w = self.view.frame.width
        h = self.view.frame.height
        
        xe1.frame.origin.y = 0 - 600
        xe2.frame.origin.y = 0 - 200
        xe3.frame.origin.y = 0 - 400
        coin.frame.origin.y = 0 - 350
        
        // Xac dinh ban dau cua cac doi tuong
        xe1.frame = CGRect(x: xe1.frame.origin.x, y: xe1.frame.origin.y - 600, width: xe1.frame.size.width, height: xe1.frame.size.height)
        xe2.frame = CGRect(x: xe2.frame.origin.x, y: xe2.frame.origin.y - 600, width: xe2.frame.size.width, height: xe2.frame.size.height)
        xe3.frame = CGRect(x: xe3.frame.origin.x, y: xe3.frame.origin.y - 600, width: xe3.frame.size.width, height: xe3.frame.size.height)
        coin.frame = CGRect(x: coin.frame.origin.x, y: coin.frame.origin.y - 600, width: coin.frame.size.width, height: coin.frame.size.height)
        
        timer = Timer.scheduledTimer(timeInterval: 0.005, target: self, selector: #selector(ChayXe), userInfo: nil, repeats: true)
    }
    
    func EndGame(){
        self.Score = lblDiem.text ?? ""
        performSegue(withIdentifier: "EndGame", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let vc = segue.destination as! EndGameController
        vc.Score = self.Score
    }
}
