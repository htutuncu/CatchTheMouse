//
//  ViewController.swift
//  CatchTheMouse
//
//  Created by Hikmet Tütüncü on 4.06.2024.
//

import UIKit

class ViewController: UIViewController {
    
    final let highScoreString = "HighScore: "
    @IBOutlet weak var highScore: UILabel!
    var highScoreNum = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        let storedHighscore = UserDefaults.standard.object(forKey: "highscore")
        if storedHighscore == nil {
            highScore.text = "\(highScoreString) \(highScoreNum)"
        }
        
        if let newScore = storedHighscore as? Int {
            highScoreNum = newScore
            highScore.text = "\(highScoreString) \(highScoreNum)"
        }
    }

    @IBAction func playTheGame(_ sender: Any) {
        performSegue(withIdentifier: "toGamePlayVC", sender: nil)
    }
    
}

