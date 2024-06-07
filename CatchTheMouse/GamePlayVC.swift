//
//  GamePlayVC.swift
//  CatchTheMouse
//
//  Created by Hikmet Tütüncü on 4.06.2024.
//

import UIKit

class GamePlayVC: UIViewController {
    
    final let highScoreString = "HighScore: "
    final let scoreString = "Score: "
    final let timeString = "Time: "

    @IBOutlet weak var score: UILabel!
    @IBOutlet weak var img1: UIImageView!
    @IBOutlet weak var img2: UIImageView!
    @IBOutlet weak var img3: UIImageView!
    @IBOutlet weak var img4: UIImageView!
    @IBOutlet weak var img5: UIImageView!
    @IBOutlet weak var img6: UIImageView!
    @IBOutlet weak var img7: UIImageView!
    @IBOutlet weak var img8: UIImageView!
    @IBOutlet weak var img9: UIImageView!
    @IBOutlet weak var timeLabel: UILabel!
    
    var imgList = [UIImageView]()
    
    var timer = Timer()
    var hideTimer = Timer()
    
    var randomInt = 0
    var counter = 10
    var scoreNum = 0
    var highScoreNum = 0
    
    @IBOutlet weak var highScore: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()

        imgList.append(img1)
        imgList.append(img2)
        imgList.append(img3)
        imgList.append(img4)
        imgList.append(img5)
        imgList.append(img6)
        imgList.append(img7)
        imgList.append(img8)
        imgList.append(img9)
        
        setScoreLabel()
        
        img1.isUserInteractionEnabled = true
        img2.isUserInteractionEnabled = true
        img3.isUserInteractionEnabled = true
        img4.isUserInteractionEnabled = true
        img5.isUserInteractionEnabled = true
        img6.isUserInteractionEnabled = true
        img7.isUserInteractionEnabled = true
        img8.isUserInteractionEnabled = true
        img9.isUserInteractionEnabled = true
        
        let recognizer1 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer2 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer3 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer4 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer5 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer6 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer7 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer8 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer9 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        
        img1.addGestureRecognizer(recognizer1)
        img2.addGestureRecognizer(recognizer2)
        img3.addGestureRecognizer(recognizer3)
        img4.addGestureRecognizer(recognizer4)
        img5.addGestureRecognizer(recognizer5)
        img6.addGestureRecognizer(recognizer6)
        img7.addGestureRecognizer(recognizer7)
        img8.addGestureRecognizer(recognizer8)
        img9.addGestureRecognizer(recognizer9)
        
        
        
        for img in imgList {
            img.isHidden = true
        }
        
        
        setTimeLabel()
        setScoreLabel()
        
        let storedHighscore = UserDefaults.standard.object(forKey: "highscore")
        if storedHighscore == nil {
            setHighScoreLabel()
        }
        
        if let newScore = storedHighscore as? Int {
            highScoreNum = newScore
            setHighScoreLabel()
        }
        
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(timerFunction), userInfo: nil, repeats: true)
        hideTimer = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(hideMouse), userInfo: nil, repeats: true)
        
    }
    
    @objc func increaseScore() {
        scoreNum += 1
        setScoreLabel()
    }
    
    @objc func hideMouse() {
        for img in imgList {
            img.isHidden = true
        }
        randomInt = Int.random(in: 0..<9)
        imgList[randomInt].isHidden = false
    }
    
    @objc func timerFunction() {
        
        counter -= 1
        setTimeLabel()
        
        if counter == 0 {
            timer.invalidate()
            hideTimer.invalidate()
            
            if self.scoreNum > self.highScoreNum {
                self.highScoreNum = self.scoreNum
                setHighScoreLabel()
                UserDefaults.standard.set(self.highScoreNum, forKey: "highscore")
            }
            
            let alert = UIAlertController(title: "Time's Over", message: "Do you want to play again?", preferredStyle: UIAlertController.Style.alert)
            let okButton = UIAlertAction(title: "OK", style: .default, handler: nil)
            alert.addAction(okButton)
            let replayButton = UIAlertAction(title: "Replay", style: .default) {
                (UIAlertAction) in
                
                self.scoreNum = 0
                self.setScoreLabel()
                self.counter = 10
                self.setTimeLabel()
                
                self.timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.timerFunction), userInfo: nil, repeats: true)
                self.hideTimer = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(self.hideMouse), userInfo: nil, repeats: true)
            }
            alert.addAction(replayButton)
            self.present(alert, animated: true)
            
            for img in imgList {
                img.isHidden = true
            }
        }
    }
    
    private func setHighScoreLabel() {
        highScore.text = "\(highScoreString) \(highScoreNum)"
    }
    
    private func setScoreLabel() {
        score.text = "\(scoreString) \(scoreNum)"
    }
    
    private func setTimeLabel() {
        timeLabel.text = "\(timeString) \(counter)"
    }
 

}
