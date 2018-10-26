//
//  ResultsViewController.swift
//  Personality Quiz
//
//  Created by cl-dev on 2018-09-11.
//  Copyright © 2018 cl-dev. All rights reserved.
//

import UIKit

class ResultsViewController: UIViewController {
    
    @IBOutlet weak var resultAnswerLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadAnswersFromDifferentQuestions()
        navigationItem.hidesBackButton = true
        // Do any additional setup after loading the view.
    }
    
    var responses: [AnimalType]!
    
    func loadAnswersFromDifferentQuestions(){
        if let mostCommonAnswer = ResultsViewController.calculatePersonalityResult(responses: responses) {
            resultAnswerLabel.text = "You are a \(mostCommonAnswer.rawValue)"
        } else {
            resultAnswerLabel.text = "You are a carnivore"
        } // TODO Localize
    }
    
    static func calculatePersonalityResult(responses: [AnimalType]) -> AnimalType? { //Dictionnaries
        var answersFrequency: [AnimalType: Int] = [:]
        
        for response in responses {
//            answersFrequency[response] = (answersFrequency[response] ?? 0) + 1
            answersFrequency[response, default: 0] += 1
        }
        
        
        if answersFrequency.count > 1 {
            let secondMostCommonAnswer = answersFrequency.sorted { $0.value > $1.value }[1].value
            let mostCommonAnswer = answersFrequency.sorted { $0.value > $1.value }.first?.value
            
            if (mostCommonAnswer == secondMostCommonAnswer ){
                return .multiple
            }
        }
        
        return answersFrequency
            .sorted { $0.value > $1.value }
            .first?.key
    }
    
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}
