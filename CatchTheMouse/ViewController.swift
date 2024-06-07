//
//  ViewController.swift
//  CatchTheMouse
//
//  Created by Hikmet Tütüncü on 4.06.2024.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var highScore: UILabel!
    var highScoreNum = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        let storedHighscore = UserDefaults.standard.object(forKey: "highscore")
        if storedHighscore == nil {
            highScore.text = "HighScore: \(highScoreNum)"
        }
        
        if let newScore = storedHighscore as? Int {
            highScoreNum = newScore
            highScore.text = "HighScore: \(highScoreNum)"
        }
    }

    @IBAction func playTheGame(_ sender: Any) {
        performSegue(withIdentifier: "toGamePlayVC", sender: nil)
    }
    
}

