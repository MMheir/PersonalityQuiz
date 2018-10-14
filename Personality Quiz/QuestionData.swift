//
//  File.swift
//  Personality Quiz
//
//  Created by cl-dev on 2018-09-11.
//  Copyright © 2018 cl-dev. All rights reserved.
//

import Foundation

struct Question {
    var text: String
    var type: ResponseType
    var answers: [Answer]
}

enum ResponseType{
    case single, multiple, ranged
}

struct Answer {
    var text: String
    var type: AnimalType
}

enum AnimalType: Character {
    case dog = "🐶", cat = "🐱", mouse = "🐭", rabbit = "🐰"
}
