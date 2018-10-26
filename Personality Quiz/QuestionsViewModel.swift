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
// - Question stack view cropping text and left aligned switches should be right aligned
//   - Not use storyboard and programatically build your view (eg if you have different number of answers) diff
// - Test cases:
//  - none
//  - one
//  - multiple equal
//  - clear winner
// - Unit test

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
        return String(format: NSLocalizedString("Question", comment: ""), questionIndex+1)
    } //DONE: Localization strings (low priority)
    
    internal private(set) var answersChosen: [AnimalType] = []
    // DONE: Store type of answer directly when user answers (could be array of type or frequency dictionnary from type to int directly)
    
    private let questions: [Question] = [ //part of model
        Question(text: NSLocalizedString("firstQuestion", comment: ""),
                 type: .multiple,
                 answers:[
                    Answer(text: NSLocalizedString("Steak", comment: ""), type: .dog),
                    Answer(text: NSLocalizedString("Fish", comment: ""), type: .cat),
                    Answer(text: NSLocalizedString("Cheese", comment: ""), type: .mouse),
                    Answer(text: NSLocalizedString("Carrots", comment: ""), type: .rabbit)
            ]),
        Question(text: NSLocalizedString("secondQuestion", comment: ""),
                 type: .multiple,
                 answers:[
                    Answer(text: NSLocalizedString("Swimming", comment: ""), type: .dog),
                    Answer(text: NSLocalizedString("Sleeping", comment: ""), type: .cat),
                    Answer(text: NSLocalizedString("Eating", comment: ""), type: .mouse),
                    Answer(text: NSLocalizedString("Jumping", comment: ""), type: .rabbit)
            ]),
        Question(text: NSLocalizedString("thirdQuestion", comment: ""),
                 type: .single,
                 answers:[
                    Answer(text: NSLocalizedString("I love them", comment: ""), type: .dog),
                    Answer(text: NSLocalizedString("I dislike them", comment: ""), type: .cat),
                    Answer(text: NSLocalizedString("I barely notice them", comment: ""), type: .mouse),
                    Answer(text: NSLocalizedString("I get a little nervous", comment: ""), type: .rabbit)
            ])
    ]
    
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
            if isSelected {
                answersChosen.append(currentAnswers[index].type)
            }
        }
    }
}
