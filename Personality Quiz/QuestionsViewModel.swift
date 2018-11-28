//
//  QuestionsViewModel.swift
//  Personality Quiz
//
//  Created by Maxine Mheir on 2018-10-11.
//  Copyright © 2018 cl-dev. All rights reserved.
//

//Document class, functions, variables

//mutability and things referencing it
//When mutating, struct use different ones where class doesn't

//TODOs:
// - Implement scroll view on QuestionsViewController (new branch)
//    - Multiline labels in a stack view in a scroll view
//    - Make an article with findings
//   - Not use storyboard and programatically build your view (eg if you have different number of answers) diff

import Foundation
import UIKit

struct QuestionsViewModel {
    
    private var questionIndex = 0
    private var currentQuestion: Question {
        return questions[questionIndex]
    }
    
    /// [0,1] value to describe progression through questions
    private var progressThroughQuestions: Float {
        return Float(questionIndex)/Float(questions.count)
    }
    //mutating properties and calculated properties are var
    
    private var navigationTitle: String {
        let index = NSNumber(value: questionIndex+1)
        return String(format: NSLocalizedString("Question", comment: ""), index)
    } // DONE: format number (get format string for number)
    
    internal private(set) var answersChosen = [Answer: Bool]()
    // DONE: Store type of answer directly when user answers (could be array of type or frequency dictionnary from type to int directly)
    
    private let questions: [Question] = [ //part of model
        Question(text: NSLocalizedString("firstQuestion", comment: "The first question"),
                 type: .multiple,
                 answers:[
                    Answer(text: NSLocalizedString("Steak", comment: "The user likes steak"), type: .dog),
                    Answer(text: NSLocalizedString("Fish", comment: "The user likes fish"), type: .cat),
                    Answer(text: NSLocalizedString("Cheese", comment: "The user likes cheese"), type: .mouse),
                    Answer(text: NSLocalizedString("Carrots", comment: "The user likes carrots"), type: .rabbit)
            ]),
        Question(text: NSLocalizedString("secondQuestion", comment: "The second question"),
                 type: .multiple,
                 answers:[
                    Answer(text: NSLocalizedString("Swimming", comment: "The user enjoys swimming"), type: .dog),
                    Answer(text: NSLocalizedString("Sleeping", comment: "The user enjoys sleeping"), type: .cat),
                    Answer(text: NSLocalizedString("Eating", comment: "The user enjoys eating"), type: .mouse),
                    Answer(text: NSLocalizedString("Jumping", comment: "The user enjoys jumping"), type: .rabbit)
            ]),
        Question(text: NSLocalizedString("thirdQuestion", comment: "The third question"),
                 type: .single,
                 answers:[
                    Answer(text: NSLocalizedString("I love them", comment: "The user loves car rides"), type: .dog),
                    Answer(text: NSLocalizedString("I dislike them", comment: "The user doesn't love car rides"), type: .cat),
                    Answer(text: NSLocalizedString("I barely notice them", comment: "The user barely notices car rides"), type: .mouse),
                    Answer(text: NSLocalizedString("I get a little nervous", comment: "The user gets nervous in car rides"), type: .rabbit)
            ])
    ]
    // String comments to provide context for the element for translate
    
    //MARK - Interface for view controller
    
    internal func currentStateForUI() -> (currentQuestion: Question, progressThroughQuestions: Float, navigationTitle: String){
        return (currentQuestion, progressThroughQuestions, navigationTitle)
    }
    
    internal mutating func incrementQuestionIndex() {
        questionIndex += 1
    }
    
    internal func nextStateIsQuestion() -> Bool {
        return questionIndex < questions.count
    }
 
    internal mutating func userRespondCurrentQuestion(answersSelected: [Bool]){
        
        let currentAnswers = currentQuestion.answers
        
        for (index, isSelected) in answersSelected.enumerated() {
            answersChosen.updateValue(isSelected, forKey: currentAnswers[index])
        }
    }
}
