//
//  GameScreenViewController.swift
//  Flag Game
//
//  Created by Volkan Sahin on 30.10.2019.
//  Copyright © 2019 Volkan Sahin. All rights reserved.
//

import UIKit
//This is the game screen viewcontroller
class GameScreenViewController: UIViewController {
    //Decleration of variables
    @IBOutlet weak var countryName: UILabel!
    @IBOutlet weak var gameName: UILabel!
    @IBOutlet weak var score: UILabel!
    @IBOutlet weak var questionNumber: UILabel!
    @IBOutlet weak var button1: UIButton!
    @IBOutlet weak var button2: UIButton!
    @IBOutlet weak var button3: UIButton!
    var countries = [String]()
    var name:String = ""
    var correctAnswer = 0
    var userScore = 0
    var numberOfQuestion = 0
    var correctNumber = 0
    var flag = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Flag Game"
        //Country names of the flags
        
        gameName.text = name
        
        countries = GameEngine.init().CreateCountryArray()
        
        askQuestion()
        
        countries.sort()
        // Button Appearance Settings
        button1.layer.borderWidth = 1
        button2.layer.borderWidth = 1
        button3.layer.borderWidth = 1
        
        button1.layer.borderColor = UIColor.darkGray.cgColor
        button2.layer.borderColor = UIColor.darkGray.cgColor
        button3.layer.borderColor = UIColor.darkGray.cgColor
        
        button1.contentVerticalAlignment = .fill
        button1.contentHorizontalAlignment = .fill
        
        button2.contentVerticalAlignment = .fill
        button2.contentHorizontalAlignment = .fill
        
        
        button3.contentVerticalAlignment = .fill
        button3.contentHorizontalAlignment = .fill
        
    }
    //This function creates questions.
    func askQuestion(action:UIAlertAction! = nil){
        //Shuffle countries array and Assign first 3 flag to the buttons
        button1.isEnabled = true
        button2.isEnabled = true
        button3.isEnabled = true
        //User can play until 10 questions
        if numberOfQuestion == 10{
            let alert = UIAlertController(title: "End of The Game!", message: "You have answer \(correctNumber)/10 Question correct\nYour score is \(userScore)", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Play Again", style: .default, handler: askQuestion))
            self.present(alert, animated: true)
            numberOfQuestion = 0
            userScore = 0
            numberOfQuestion = 0
            updateGame()
        }else{
            //Every turn country array is shuffled and first 3 element(country flag) assigned to the buttons
            numberOfQuestion += 1
            countries.shuffle()
            button1.setImage(UIImage(named : countries[0]), for: .normal)
            button2.setImage(UIImage(named : countries[1]), for: .normal)
            button3.setImage(UIImage(named : countries[2]), for: .normal)
            correctAnswer = Int.random(in: 0...2)
            countryName.text = countries[correctAnswer].components(separatedBy: ".").first
        }
        updateGame()
    }
    //Tapped button function is for catching user selection
    @IBAction func buttonTapped(_ sender: UIButton) {
        if sender.tag == correctAnswer{
            userScore += 1
            correctNumber += 1
            let alert = UIAlertController(title: "Correct!", message: "Your guess is correct", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Continue", style: .default, handler: askQuestion))
            self.present(alert, animated: true)
            //This variable is used for calculating user selection in 2 Shot Challenge Game
            flag = 0
        }else{
            if gameName.text == "1 Shot Challenge"{
                userScore -= 1
                let alert = UIAlertController(title: "Wrong!", message: "You select the flag of " + countries[sender.tag].components(separatedBy: ".").first!, preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Continue", style: .default, handler: askQuestion))
                self.present(alert, animated: true)
                
            }else{
                if flag < 1{
                    flag += 1
                    let alert = UIAlertController(title: "Wrong!", message: "You select the flag of " + countries[sender.tag], preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "Continue", style: .default, handler: nil))
                    self.present(alert, animated: true)
                    sender.isEnabled = false
                }else{
                    userScore -= 1
                    flag = 0
                    let alert = UIAlertController(title: "Wrong!", message: "You select the flag of " + countries[sender.tag], preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "Continue", style: .default, handler: askQuestion))
                    self.present(alert, animated: true)
                }
            }
        }
        updateGame()
    }
    
    func updateGame(){
        score.text = String(userScore)
        questionNumber.text = "\(numberOfQuestion) / 10"
    }
    
}
