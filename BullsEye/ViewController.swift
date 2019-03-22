//
//  ViewController.swift
//  BullsEye
//
//  Created by Lucas Almeida on 19/03/19.
//  Copyright © 2019 Lucas Almeida. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var gameInfoText: UILabel!
    @IBOutlet weak var targetLabel: UILabel!
    @IBOutlet weak var minSliderValue: UILabel!
    @IBOutlet weak var maxSliderValue: UILabel!
    @IBOutlet weak var slider: UISlider!
    @IBOutlet weak var totalScoreText: UILabel!
    @IBOutlet weak var totalScoreValue: UILabel!
    @IBOutlet weak var roundText: UILabel!
    @IBOutlet weak var roundValue: UILabel!
    
    private let pointsGained = 100
    private let bonusPointsForOneOff = 50
    private var targetValue: Int = 0
    private var currentValue: Int = 0
    private var score: Int = 0
    private var roundsNumber: Int = 1
    
    @IBAction func edit() {
        
    }
    
    @IBAction func startNewGame() {
        currentValue = 0
        score = 0
        roundsNumber = 1
        setUpSlider()
        updateLabels()
    }
    
    func startNewRound() {
        setUpSlider()
        updateLabels()
    }
    
    private func setUpSlider() {
        slider.minimumValue = 1
        slider.maximumValue = 100
        slider.value = 50
        currentValue = Int(slider.value)
        minSliderValue.text = String(Int(slider.minimumValue))
        maxSliderValue.text = String(Int(slider.maximumValue))
    }
    
    @IBAction func sliderMoved(_ slider: UISlider) {
        print(slider.value)
        let roundedValue = slider.value.rounded()
        currentValue = Int(roundedValue)
    }
    
    private func generateScore() -> Int {
        let randomScore = Int.random(in: 1...100)
        return randomScore
    }
    
    func updateLabels() {
        targetValue = generateScore()
        targetLabel.text = String(targetValue)
        totalScoreValue.text = String(score)
        roundValue.text = String(roundsNumber)
    }
    
    func calculateScore() -> Int {
        let difference: Int = abs(targetValue - currentValue)
        if difference == 0 {
            return pointsGained * 2
        } else if difference == 1 {
            return pointsGained + bonusPointsForOneOff
        } else {
            return pointsGained - difference
        }
    }
    
    func evaluatePerformance(for difference: Int) -> String {
        if difference == 0 {
            return "Perfect"
        } else if difference < 5 {
            return "You almost had it!"
        } else if difference < 10 {
            return "Pretty good!"
        } else {
            return "Not even close"
        }
    }
    
    @IBAction func showAlert(_ sender: UIButton) {
        let currentScore = calculateScore()
        score += currentScore
        let difference = abs(targetValue - currentValue)
        let title = evaluatePerformance(for: difference)
        
        let message = "You scored \(currentScore) points"
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default) { (action) in
            self.roundsNumber = self.roundsNumber + 1
            self.startNewRound()
        }
        alert.addAction(action)
        self.present(alert, animated: true, completion: nil)
    }
    
    func setUpSliderCustom() {
        let thumbImageNormal = #imageLiteral(resourceName: "SliderThumb-Normal")
        slider.setThumbImage(thumbImageNormal, for: .normal)
        let thumbImageHighlighted = #imageLiteral(resourceName: "SliderThumb-Highlighted")
        slider.setThumbImage(thumbImageHighlighted, for: .highlighted)
        
        let insets = UIEdgeInsets(top: 0, left: 14, bottom: 0, right: 14)
        
        let trackLeftImage = #imageLiteral(resourceName: "SliderTrackLeft")
        let trackLeftResizable = trackLeftImage.resizableImage(withCapInsets: insets)
        slider.setMinimumTrackImage(trackLeftResizable, for: .normal)
        
        let trackRightImage = #imageLiteral(resourceName: "SliderTrackRight")
        let trackRightResizable = trackRightImage.resizableImage(withCapInsets: insets)
        slider.setMaximumTrackImage(trackRightResizable, for: .normal)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    
        startNewRound()
        setUpSliderCustom()
    }
}

