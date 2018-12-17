//
//  AnswerSwitchView.swift
//  Personality Quiz
//
//  Created by Maxine Mheir on 2018-12-13.
//  Copyright © 2018 cl-dev. All rights reserved.
//

import UIKit

class AnswerSwitchView: UIView {
    
    @IBOutlet private weak var answerSwitch: UISwitch!
    
    @IBOutlet private weak var label: UILabel!
    
    internal func isSwitchOn() -> Bool {
        return answerSwitch.isOn
    }
    
//    @IBAction func switchSelected() {
//        questionsViewController.switchToggled()
//    }
    
    internal func updateAnswerUI(text: String) {
        label.text = text
        answerSwitch.isOn = false
    }
    
    // update UI function to set text and switch (take string and bool)
    // read only property for answerSwitch to return the bool
}
