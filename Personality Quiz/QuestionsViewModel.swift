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
    internal static let unselectedAnimalTransparencyAlpha: CGFloat = 0.25

    private var currentQuestion: Question {
        return questions[questionIndex]
    }
    
    /// [0,1] value to describe progression through questions
    private var progressThroughQuestions: Float {
        return Float(questionIndex)/Float(questions.count)
    }
    //mutating properties and calculated properties are var
    
    internal private(set) var answersChosen = [Answer: Bool]()
    // DONE: Store type of answer directly when user answers (could be array of type or frequency dictionnary from type to int directly)
    internal var mostCommonAnswers: [AnimalType] {
        return QuestionsViewModel.calculateCurrentAnimalType(responses: answersChosen)
            .map { (key: AnimalType, value: Int) -> AnimalType in
                return key
            }
    }
    
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
    
    private static func calculateCurrentAnimalType(responses: [Answer : Bool]) -> [(key: AnimalType,value: Int)]{
       
        let animalFrequency = calculateAnimalFrequency(responses: responses)
        
        let answersAndCountSortedDecreasingByCount = animalFrequency.sorted { $0.value > $1.value }
        
        // Take all top answers equal by count
        let highestCount: Int? = answersAndCountSortedDecreasingByCount.first?.value
        let topAnswersAndCount = answersAndCountSortedDecreasingByCount.prefix { (_ , value: Int) -> Bool in
            return highestCount == value
        }
        
        // Build an array from the ArraySlice
        return Array<(key: AnimalType,value: Int)>(topAnswersAndCount)
        
    }
    
    private static func calculateAnimalFrequency(responses: [Answer : Bool]) -> [AnimalType: Int]{
        var animalFrequency: [AnimalType: Int] = [:]
        // Builds the histogram
        for (answer, isSelected) in responses {
            if isSelected {
                animalFrequency[answer.type, default: 0] += 1
            }
        }
        
        return animalFrequency
    }
    
    private static func calculateTotalAnswersPerAnimalType(questions: [Question]) -> [AnimalType : Int] {
        var totalAnswersPerAnimalType = [AnimalType : Int]()
        
        for question in questions {
            for answer in question.answers {
                totalAnswersPerAnimalType[answer.type, default: 0] += 1
            }
        }
        
        return totalAnswersPerAnimalType
    }
    
    //MARK - Interface for view controller
    
    internal func currentStateForUI() -> (currentQuestion: Question, progressThroughQuestions: Float, navigationTitle: String, yourAnimalType: String, responseAnimalsTransparencyAlphas: [AnimalType : CGFloat]){
        return (currentQuestion, progressThroughQuestions, navigationTitle, getCurrentAnimalType(), calculateTransparencyAlpha())
    }
    
    internal mutating func incrementQuestionIndex() {
        questionIndex += 1
    }
    
    internal func nextStateIsQuestion() -> Bool {
        return questionIndex < questions.count
    }
 
    internal mutating func submitAnswersToCurrentQuestion(answersSelected: [Bool]){
        
        let currentAnswers = currentQuestion.answers
        
        for (index, isSelected) in answersSelected.enumerated() {
            answersChosen.updateValue(isSelected, forKey: currentAnswers[index])
        }
    }
    
    //MARK - CurrentStateForUI
    
    private func calculateTransparencyAlpha() -> [AnimalType : CGFloat] {
        let animalFrequency = QuestionsViewModel.calculateAnimalFrequency(responses: answersChosen)
        
        let totalAnswersPerAnimalType = QuestionsViewModel.calculateTotalAnswersPerAnimalType(questions: questions)
        
        var transparencyAlphas = [AnimalType : CGFloat]()
        
        let unselectedAlpha = QuestionsViewModel.unselectedAnimalTransparencyAlpha
        
        for animalType in AnimalType.allCases {
            if let frequency = animalFrequency[animalType],
                let totalAnswers = totalAnswersPerAnimalType[animalType],
                frequency > 0,
                totalAnswers > 0 {
                let ratio: CGFloat = CGFloat(frequency)/CGFloat(totalAnswers)
                transparencyAlphas[animalType] = (ratio*(1-unselectedAlpha)) + unselectedAlpha
            } else {
                transparencyAlphas[animalType] = unselectedAlpha
            }
            
        }
        return transparencyAlphas
    }
    
    private var navigationTitle: String {
        let index = NSNumber(value: questionIndex+1)
        return String(format: NSLocalizedString("Question", comment: ""), index)
    } // DONE: format number (get format string for number)
    
    internal func getCurrentAnimalType() -> String {
        var responseText = "Your Animal Type so far: "
        for answer in mostCommonAnswers {
            responseText = responseText + "\(answer.rawValue)"
        }
        return responseText
    }
    
}
