//
//  ViewControllerGame.swift
//  hw3game
//
//  Created by User16 on 2019/5/13.
//  Copyright © 2019 User16. All rights reserved.
//

import UIKit
import AVFoundation
import AudioToolbox



class ViewControllerGame: UIViewController {
    
    var counter = 0.0
    var timer = Timer()
    var gametimer = Timer()
    var isPlaying = false
    var  score = 0
    var checkStart = 0
    var  timeScore = 0
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        timeLabel.text = String(counter)
        
        
    }
    
    @IBOutlet weak var touchButton: UIButton!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var timeScoreLabel: UILabel!
    @IBOutlet weak var startButton: UIButton!
    @IBOutlet weak var resetButton: UIButton!
    
    @IBAction func startTimer(_ sender: Any) {
        checkStart = 1
        
        if(isPlaying) {
            return
        }
        startButton.isEnabled = false
        
        timer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(UpdateTimer), userInfo: nil, repeats: true)
        isPlaying = true
        
        gametimer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true){_ in
            
            if self.touchButton.frame.origin.y == 740{
                self.touchButton.frame.origin = CGPoint(x:57, y:490)
            }
            else{
                UIViewPropertyAnimator.runningPropertyAnimator(withDuration: 1, delay: 0, options: [.repeat], animations: {self.touchButton.frame.origin = CGPoint(x:57, y:740)})
            }
        }
        
        
    }
    
    @IBAction func resetTimer(_ sender: Any) {
        checkStart = 0
        timeScore = 0
        timeScoreLabel.text = "\(timeScore)"
        
        startButton.isEnabled = true
        
        timer.invalidate()
        isPlaying = false
        counter = 0.0
        timeLabel.text = String(counter)
        
        gametimer.invalidate()
        self.touchButton.frame.origin = CGPoint(x:57, y:490)
        
        score = 0
        scoreLabel.text = String(score)
    }
    
    @objc func UpdateTimer() {
        counter = counter + 0.1
        timeLabel.text = String(format: "%.1f", counter)
        
        timeScore = (1000 - Int(self.counter) % 1000) * 10
        timeScoreLabel.text = "\(timeScore)"
        
    }
    
    
    @IBAction func scoreButton(_ sender: Any) {
        if checkStart == 1 {
            score = score + 1
            scoreLabel.text = String(score)
            
            AudioServicesPlaySystemSound(1009)
            
            if score == 20 {
                checkStart = 0
                
                startButton.isEnabled = true
                
                timer.invalidate()
                isPlaying = false
                timeLabel.text = String(counter)
                
                gametimer.invalidate()
                self.touchButton.frame.origin = CGPoint(x:57, y:490)
            }
        }
    }
}
