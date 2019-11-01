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
        countries += ["Afghanistan","Albania","Algeria","American Samoa","Andorra","Anguilla","Angola","Antigua & Deps","Antartica","Argentina","Aland Islands","Armenia","Aruba","Australia","Austria","Azerbaijan","Bahamas","Bahrain","Bangladesh","Barbados","Belarus","Belgium","Belize","Benin","Bermuda","Bhutan","Bolivia","Bosnia Herzegovina","Botswana","Bouvet Island","Bonaire","Brazil","Brunei","Bulgaria","Burkina","Burundi","Cambodia","Cameroon","Canada","Cape Verde","Cayman Islands ","Central African Rep","Chad","Chile","China","Cocos Islands","Colombia","Comoros","Democratic Congo","Congo","Costa Rica","Croatia","Cuba","Cyprus","Czech Republic","Cook Island","Christmas Island","Curacao","Denmark","Djibouti","Dominica","Dominican Republic","East Timor","Ecuador","Egypt","El Salvador","England","Equatorial Guinea","Eritrea","Estonia","Esvatini","European Union","Ethiopia","Falkland Islands","Faroe Islands","Fiji","Finland","France","French Guiana","French Polynesia","French Southern Territories","Gabon","Gambia","Georgia","Germany","Ghana","Gibraltar","Greece","Greenland","Grenada","Guam","Guatemala","Guernsey","Guadeloupe","Guinea","Guinea-Bissau","Guyana","Haiti","Honduras","Heard Island","Hong Kong","Hungary","Iceland","India","Indonesia","Iran","Iraq","Ireland","Israel","Italy","Ivory Coast","Jamaica","Japan","Jersey","Jordan","Kazakhstan","Kenya","Kiribati","Korea North","Korea South","Kosovo","Kuwait","Kyrgyzstan","Laos","Latvia","Lebanon","Lesotho","Liberia","Libya","Liechtenstein","Lithuania","Luxembourg","Macedonia","Macao","Malawi","Malaysia","Maldives","Mali","Malta","Marshall Islands”,””Madagascar,”Martinique","Mauritania","Mauritius","Mayotte","Mexico","Micronesia","Moldova","Monaco","Mongolia","Montenegro","Morocco","Mozambique","Myanmar","Namibia","Nauru","Nepal","Netherlands","New Zealand","New Caledonia","Nicaragua","Niger","Nigeria","Niue","Norway","Northern Mariana Islands","Oman","Pakistan","Palau","Panama","Palestine","Papua New Guinea","Paraguay","Peru","Philippines","Pitcairn","Poland","Portugal","Puerto Rico","Qatar","Reunion","Romania","Russian Federation","Rwanda","St Kitts & Nevis","St Lucia","St Pierre and Miquelon","Saint Vincent & the Grenadines","Samoa","San Marino","Sao Tome & Principe","Saudi Arabia","Scotland","Senegal","Serbia","Seychelles","Sierra Leone","Singapore","Saint Martin","Slovakia","Slovenia","Solomon Islands","Somalia","South Africa","South Georgia","South Sudan","Spain","Sri Lanka","Sudan","Suriname","Sweden","Switzerland","Svalbard and Jan Mayen","Syria","Taiwan","Tajikistan","Tanzania","Thailand","Togo","Tonga","Tokelau","Trinidad & Tobago","Tunisia","Turkey","Turks and Caicos Islands","Turkmenistan","Tuvalu","Uganda","Ukraine","United Arab Emirates","United Kingdom","United States","Uruguay","Uzbekistan","Western Sahara","Wales","Wallis and Futuna","Vanuatu","Vatican City","Virgin Island","Venezuela","Vietnam","Yemen","Zambia","Zimbabwe"]
        
        gameName.text = name
       
        askQuestion()
        
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
            countryName.text = countries[correctAnswer]
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
                let alert = UIAlertController(title: "Wrong!", message: "You select the flag of " + countries[sender.tag], preferredStyle: .alert)
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
