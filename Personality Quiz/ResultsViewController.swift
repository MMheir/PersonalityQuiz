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
        calculatePersonalityResult()
        navigationItem.hidesBackButton = true
        // Do any additional setup after loading the view.
    }
    
    var responses: [Answer]!
    
    func calculatePersonalityResult(){ //Dictionnaries
        var answersFrequency: [AnimalType: Int] = [:]
        let responseTypes = responses.map {$0.type}
        
        for response in responseTypes {
            answersFrequency[response] = (answersFrequency[response] ?? 0) + 1
        }
        
//        let answersSorted = answersFrequency.sorted(by:
//        {(pair1, pair2) -> Bool in
//            return pair1.value > pair2.value
//        })
//
//        let mostCommonAnswer = answersSorted.first!.key
        
        let mostCommonAnswer = answersFrequency.sorted{$0.1 > $1.1}.first!.key // $0 and $1?
        
        resultAnswerLabel.text = "You are a \(mostCommonAnswer.rawValue)"
        
        
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
