//
//  ViewController.swift
//  BullsEye
//
//  Created by Andrew Cunningham on 12/06/2017.
//  Copyright © 2017 andrewaac. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var currentValue: Int = 0
    var targetValue:  Int = 0
    var levelValue:   Int = 1
    var scoreValue:   Int = 0
    
    @IBOutlet weak var gameDesc:        UILabel!
    @IBOutlet weak var scoreTextLabel:  UILabel!
    @IBOutlet weak var levelTextLabeL:  UILabel!
    @IBOutlet weak var slider:          UISlider!
    @IBOutlet weak var randomNumLabel:  UILabel!
    @IBOutlet weak var scoreLabel:      UILabel!
    @IBOutlet weak var levelLabel:      UILabel!
    @IBOutlet weak var startOverButton: UIButton!
    @IBOutlet weak var infoButton:      UIButton!
    @IBOutlet weak var checkButton:     UIButton!

    // MARK: Lifecycle Funcs
    override func viewDidLoad() {
        super.viewDidLoad()
        startOverButton.setTitle("start_over".localised, for: .normal)
        checkButton.setTitle("check".localised, for: .normal)
        scoreTextLabel.text = "points".localised
        levelTextLabeL.text = "level".localised
        gameDesc.text       = "game_desc".localised
        startFreshRound()
        updateLabels()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // MARK: IBActions
    @IBAction func sliderMoved(_ slider: UISlider){
        currentValue = lroundf(slider.value)
    }
    
    @IBAction func checkScore(){
        let diff = abs(currentValue - targetValue)
        var title = ""
        var message = "\(currentValue) - "
        if(diff == 0){
            scoreValue += 10
            title = "well_done".localised
            message.append("ten_points".localised)
        } else if(diff >= 1 && diff <= 5){
            scoreValue += 5
            title = "good_attempt".localised
            message.append("five_points".localised)
        } else {
            title = "unlucky".localised
            message.append("no_points".localised)
        }
        levelValue += 1
        showNextLevelAlert(title: title, message: message)
    }
    
    @IBAction func showInfoAlert(){
        let rules = "rules_desc".localised
        let alert = UIAlertController(title: "rules_title".localised,
                                      message: rules, preferredStyle: .alert)
        let action = UIAlertAction(title: "dismiss".localised,
                                   style: .default,
                                   handler: nil)
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    
    @IBAction func startOver(){
        startFreshRound()
        updateLabels()
    }
    
    // MARK: Funcs
    func startFreshRound(){
        startNewRound()
        scoreValue = 0
        levelValue = 1
    }
    
    func startNewRound(){
        targetValue = 1 + Int(arc4random_uniform(100))
        currentValue = 50
        slider.value = Float(currentValue)
    }
    
    func updateLabels(){
        randomNumLabel.text = "\(targetValue)"
        scoreLabel.text = "\(scoreValue)"
        levelLabel.text = "\(levelValue)"
    }
    
    func showNextLevelAlert(title: String, message: String){
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "next_level".localised, style: .default, handler: nil)
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
        startNewRound()
        updateLabels()
    }
}

extension String{
var localised: String{
        return NSLocalizedString(self, comment: "")
    }
}
