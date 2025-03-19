//
//  ViewController.swift
//  CatchTheEric
//
//  Created by Zeynep Kargı on 19.03.2025.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var highScoreLabel: UILabel!
    
    @IBOutlet weak var eric1: UIImageView!
    @IBOutlet weak var eric2: UIImageView!
    @IBOutlet weak var eric3: UIImageView!
    @IBOutlet weak var eric4: UIImageView!
    @IBOutlet weak var eric5: UIImageView!
    @IBOutlet weak var eric6: UIImageView!
    @IBOutlet weak var eric7: UIImageView!
    @IBOutlet weak var eric8: UIImageView!
    @IBOutlet weak var eric9: UIImageView!
    
    var score = 0
    var time = 20
    var highScore = 0
    
    var ericArray = [UIImageView]()
    
    var timer = Timer()
    var hideTimer = Timer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        scoreLabel.text = "Score: \(score)"
        
        timeLabel.text = "\(time)"
        
        let storedHighScore = UserDefaults.standard.object(forKey: "highscore")
        
        if storedHighScore == nil {
            highScore = 0
            highScoreLabel.text = "HighScore: \(highScore)"
        }
        if let newScore = storedHighScore as? Int {
            highScore = newScore
            highScoreLabel.text = "HighScore: \(highScore)"
        }
        
        
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(timerFunction), userInfo: nil, repeats: true)
        hideTimer = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(hideEric), userInfo: nil, repeats: true)
        
        eric1.isUserInteractionEnabled = true
        eric2.isUserInteractionEnabled = true
        eric3.isUserInteractionEnabled = true
        eric4.isUserInteractionEnabled = true
        eric5.isUserInteractionEnabled = true
        eric6.isUserInteractionEnabled = true
        eric7.isUserInteractionEnabled = true
        eric8.isUserInteractionEnabled = true
        eric9.isUserInteractionEnabled = true

        
        let recognizer1 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer2 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer3 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer4 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer5 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer6 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer7 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer8 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer9 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        
        eric1.addGestureRecognizer(recognizer1)
        eric2.addGestureRecognizer(recognizer2)
        eric3.addGestureRecognizer(recognizer3)
        eric4.addGestureRecognizer(recognizer4)
        eric5.addGestureRecognizer(recognizer5)
        eric6.addGestureRecognizer(recognizer6)
        eric7.addGestureRecognizer(recognizer7)
        eric8.addGestureRecognizer(recognizer8)
        eric9.addGestureRecognizer(recognizer9)
        
        ericArray = [eric1, eric2, eric3, eric4, eric5, eric6, eric7, eric8, eric9]
        
        hideEric()
        
    }
    
    
    @objc func hideEric(){
        for i in ericArray{
            i.isHidden = true
        
        }
        let random = Int(arc4random_uniform(UInt32((ericArray.count)-1)))
        ericArray[random].isHidden = false
    }
    
    @objc func increaseScore(){
        score += 1
        scoreLabel.text = "Score: \(score)"
    }
    
    @objc func timerFunction(){
        
        time -= 1
        timeLabel.text = "\(time)"
        
        
        if (time == 0){
            timer.invalidate()
            hideTimer.invalidate()
            
            for i in ericArray{
                i.isHidden = true
            
            }
            
            //HIGHSCORE
            if self.score > self.highScore{
                self.highScore = self.score
                self.highScoreLabel.text = "HighScore: \(self.highScore)"
                UserDefaults.standard.set(self.highScore, forKey: "highscore")
            }
            
            //ALERT
            let alert = UIAlertController(title: "Time is over", message: "Do you want to play again? ", preferredStyle: UIAlertController.Style.alert)
            let okButton = UIAlertAction(title: "OK", style: UIAlertAction.Style.cancel, handler: nil)
            
            let replayButton = UIAlertAction(title: "Replay", style: UIAlertAction.Style.default) {(UIAlertAction) in
                self.score = 0
                self.time = 20
                self.scoreLabel.text = "Score: \(self.score)"
                self.timeLabel.text = "Time: \(self.time)"
                
                
                self.timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.timerFunction), userInfo: nil, repeats: true)
                self.hideTimer = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(self.hideEric), userInfo: nil, repeats: true)
                
            }
             
            alert.addAction(okButton)
            alert.addAction(replayButton)
            self.present(alert, animated: true ,completion: nil)
        }
    }


}

