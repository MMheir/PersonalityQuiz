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
// - Answers "logic" into view model [x]
// - Move interface stuff at top of struct VM
// - All todos with results (types, etc)
// - Find a way to use a loop to access switches and labels in VC instead of "hard coding" it
//   - Outlet array
//   - Not use storyboard and programatically build your view (eg if you have different number of answers)
// - Git branches (to have a safety net)

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
        return "Question #\(questionIndex+1)"
    } //TODO: Localization strings (low priority)
    
    private var answersChosen: [AnimalType] = []
    // DONE: Store type of answer directly when user answers (could be array of type or frequency dictionnary from type to int directly)
    
    private let questions: [Question] = [ //part of model
        Question(text: "What is your favorite food?",
                 type: .multiple,
                 answers:[
                    Answer(text: "Streak", type: .dog),
                    Answer(text: "Fish", type: .cat),
                    Answer(text: "Cheese", type: .mouse),
                    Answer(text: "Carrots", type: .rabbit)
            ]),
        Question(text: "What activities do you enjoy?",
                 type: .multiple,
                 answers:[
                    Answer(text: "Swimming", type: .dog),
                    Answer(text: "Sleeping", type: .cat),
                    Answer(text: "Eating", type: .mouse),
                    Answer(text: "Jumping", type: .rabbit)
            ]),
        Question(text: "How much do you enjoy car rides?",
                 type: .single,
                 answers:[
                    Answer(text: "I love them", type: .dog),
                    Answer(text: "I dislike them", type: .cat),
                    Answer(text: "I barely notice them", type: .mouse),
                    Answer(text: "I get a little nervous", type: .rabbit)
            ])
    ]
    
    //MARK - Interface for view controller
    
    internal func currentStateForUI() -> (currentQuestion: Question, progressThroughQuestions: Float, navigationTitle: String){
        return (currentQuestion, progressThroughQuestions, navigationTitle)
    }
    
    internal mutating func incrementQuestionIndex() {
        questionIndex += 1
    }
    
    internal func isQuestion() -> Bool {
        return questionIndex < questions.count
    }
 
    internal mutating func userRespondCurrentQuestion(answersSelected: [Bool]) -> [AnimalType]{
        
        let currentAnswers = currentQuestion.answers
        
        for (index, isSelected) in answersSelected.enumerated() {
            if isSelected {
                answersChosen.append(currentAnswers[index].type)
            }
        }
        return answersChosen
    }
}
