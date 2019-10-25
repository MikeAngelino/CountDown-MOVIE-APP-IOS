//
//  ViewController.swift
//  CountX
//
//  Created by Miguel Menendez on 10/25/19.
//  Copyright © 2019 cogitoCODE. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    var minute = Timer()
    var isTimerRunning = false
    var player: AVAudioPlayer?
    
    @IBOutlet weak var YRS: UILabel!
    var yrs = 00
    
    @IBOutlet weak var DAY: UILabel!
    var day = 00
    
    @IBOutlet weak var HRS: UILabel!
    var hrs = 00
    
    @IBOutlet weak var MIN: UILabel!
    var min = Int(arc4random_uniform(20)*60)
    //var min = 5
    
    @IBOutlet weak var SEC: UILabel!
    
    
    //timer function
    func runTime(){
        
        minute = Timer.scheduledTimer(timeInterval: 1, target: self, selector: (#selector(ViewController.counter)), userInfo: nil, repeats: true)
    }
    
    
    //implement the counter method
    @objc func counter(){
        
        //set colors for the set zero values
        YRS?.textColor = UIColor.red
        DAY?.textColor = UIColor.red
        HRS?.textColor = UIColor.red
        
        //if the hrs are 0 then start sound and counter
        if (hrs < 1){
            
            player = initializePlayer()
            player?.play()
            
            min-=1
            
            //to properly display the minutes
            let x = Int(min)/60
            MIN?.text = String(format: "%02d", x)
            
            //to properly display the seconds
            SEC?.text = String(format: "%02d", min % 60)
            
            //if minutes are 0 set it red
            if (MIN?.text == "00"){
                MIN?.text = "00"
                MIN?.textColor = UIColor.red
                
                //if sec are 0 set to red
                if (SEC?.text == "00"){
                    minute.invalidate()
                    player?.stop()
                    SEC?.text = "00"
                    SEC?.textColor = UIColor.red
                    
                }
            }
        }
    }
    
    //sound player function with path
    func initializePlayer() -> AVAudioPlayer? {
        guard let path = Bundle.main.path(forResource: "Tick", ofType: "m4a") else {
            return nil
        }
        return try? AVAudioPlayer(contentsOf: URL(fileURLWithPath: path))
    }
    
    //this function is standard for IOS views
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //start the timer when view opens
        runTime()
        
    }
}

