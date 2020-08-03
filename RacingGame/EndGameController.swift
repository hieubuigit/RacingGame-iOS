//
//  EndGameController.swift
//  RacingGame
//
//  Created by Hieu Bui on 7/21/20.
//  Copyright © 2020 project. All rights reserved.
//

import UIKit
import CoreData

class EndGameController: UIViewController {
    
    
    
    var Score = ""
    var HighScore = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        //Call function
        //DeleteHighScore()
        //insertScoreToLable()
        //checkHighScore(score: Score)
        //updateHighScoreLabel()
    }
    
    @IBOutlet weak var scoreLabel: UILabel!
    
    @IBOutlet weak var highScoreLabel: UILabel!
    @IBAction func homeButton(_ sender: Any) {
        
    }
    @IBAction func restartButton(_ sender: Any) {
    }
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    //MARK: func Add, Update, Get high score
    func insertScoreToLable()  {
         scoreLabel.text = Score
        //HighScore = getHighScore()
        //highScoreLabel.text = self.getHighScore()
    }
    func updateHighScoreLabel()  {
        //Set time
        DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
            self.highScoreLabel.text = self.getHighScore()
        }
        
    }
    func AddNewHighScore(score: String) {
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        
        let managedContext = appDelegate.persistentContainer.viewContext
        
        let entity = NSEntityDescription.entity(forEntityName: "Game", in: managedContext)!
        
        let information = NSManagedObject(entity: entity, insertInto: managedContext)
        
        information.setValue("admin", forKeyPath: "name")
        information.setValue(score, forKeyPath: "highscore")
        
        
        do {
            try managedContext.save()
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
    }
    func UpdateNewHighScore(newHighScore: String) {
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        
        let managedContext = appDelegate.persistentContainer.viewContext
        
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Game")
        request.predicate = NSPredicate(format: "name = %@", "admin")
        do
        {
            let test = try managedContext.fetch(request)
            let updateHighScore = test[0] as! NSManagedObject
            updateHighScore.setValue(newHighScore, forKey: "highscore")
            do{
                try managedContext.save()
            }catch{
                print(error)
            }
            
        }catch let error as NSError {
            print("Could not get. \(error), \(error.userInfo)")
        }
    }
    
    func DeleteHighScore() {
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        
        let managedContext = appDelegate.persistentContainer.viewContext
        
        let requestFetch = NSFetchRequest<NSFetchRequestResult>(entityName: "Game")
        let delete = NSBatchDeleteRequest(fetchRequest: requestFetch)
        do
        {
            
            try managedContext.execute(delete)
            
            try managedContext.save()
            
        }catch let error as NSError {
            print("Could not get. \(error), \(error.userInfo)")
        }
    }
    
    func checkHighScore(score : String){
        
        if(getHighScore() == ""){
            AddNewHighScore(score: score)
        }else if(getHighScore() < score){
            UpdateNewHighScore(newHighScore: score)
        }
    }
    func getHighScore() -> String {
        var highScoreList = [AnyObject]()
        var highScore = ""
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return "" }
        
        let managedContext = appDelegate.persistentContainer.viewContext
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Game")
        request.returnsObjectsAsFaults = false
        do{
            highScoreList = try managedContext.fetch(request)
            for item:AnyObject in highScoreList {
                highScore = item.value(forKey: "highscore") as! String
                
            }
        } catch let error as NSError {
            print("Could not get. \(error), \(error.userInfo)")
        }
        
        return highScore
    }
    
    // MARK: Lock Orientation
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        AppDelegate.AppUtility.lockOrientattion(.portrait)
        AppDelegate.AppUtility.lockOrientattion(.portrait, andRotateTo: .portrait)
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        AppDelegate.AppUtility.lockOrientattion(.all)
    }
}
