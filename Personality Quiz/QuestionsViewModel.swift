//
//  QuestionsViewModel.swift
//  Personality Quiz
//
//  Created by Maxine Mheir on 2018-10-11.
//  Copyright © 2018 cl-dev. All rights reserved.
//

import Foundation
import UIKit

class QuestionsViewModel {
    
    public var questionIndex = 0
    public var currentQuestion: Question {
        return question[questionIndex]
    }
    public var currentAnswer: [Answer] {
        return currentQuestion.answers
    }
    public var totalProgress: Float {
        return Float(questionIndex)/Float(question.count)
    }
    
    public var answersChosen: [Answer] {
        return []
    }
    
    public var question: [Question] = [ //part of model
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
}
