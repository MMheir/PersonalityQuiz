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
    
    // TODO: Deal with personalityResult returning an array
    func loadAnswersFromDifferentQuestions(){
<<<<<<< HEAD
        if let mostCommonAnswer = ResultsViewController.calculatePersonalityResult(responses: responses) {
            resultAnswerLabel.text = String(format: NSLocalizedString("Result", comment: ""), "\(mostCommonAnswer.rawValue)")
            
        } else {
            resultAnswerLabel.text = String(format: NSLocalizedString("Carnivore", comment: ""))
        }
=======
        let mostCommonAnswer = ResultsViewController.calculatePersonalityResult(responses: responses)
        var answerText = "You are a"
        
        if mostCommonAnswer.count != 0 {
            for answer in mostCommonAnswer {
                answerText = answerText + " \(answer.rawValue)"
            }
        } else {
            answerText = answerText + " carnivore"
        }
        
        resultAnswerLabel.text = answerText
>>>>>>> master
    }
    
    static func calculatePersonalityResult(responses: [AnimalType]) -> [AnimalType] { //Dictionnaries
        var answersFrequency: [AnimalType: Int] = [:]
//        var answersFrequency2: Dictionary<AnimalType, Int> = [:]
//        var answersFrequency3 = Dictionary<AnimalType, Int>()
//
//        var arr1: [AnimalType] = [] // initializing with a litteral
//        var arr2 = [AnimalType].init() // calling an initializer using swift shorthand
//        var arr3 = Array<AnimalType>.init() // calling an initializer using generic syntax
//
//        var test1: [AnimalType: [Int]] = [:]
//        var test2: Dictionary<AnimalType, Array<Int>> = [:]
//        var test3 = Dictionary<AnimalType, Array<Int>>.init()

        // Builds the histogram
        for response in responses {
//            answersFrequency[response] = (answersFrequency[response] ?? 0) + 1
            answersFrequency[response, default: 0] += 1
        }
        
        let answersAndCountSortedDecreasingByCount = answersFrequency.sorted { $0.value > $1.value }
        
        // Take all top answers equal by count
        let highestCount: Int? = answersAndCountSortedDecreasingByCount.first?.value
        let topAnswersAndCount = answersAndCountSortedDecreasingByCount.prefix { (_ , value: Int) -> Bool in
            return highestCount == value
        }
        
        // Extracting only the top answers
        let topAnswers = topAnswersAndCount.map { (key: AnimalType, value: Int) -> AnimalType in
            return key
        }
        
        // Build an array from the ArraySlice
        return Array<AnimalType>(topAnswers)
        // return [AnimalType](topAnswers)
        
        // For a future app: Madrid chaining
    
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
