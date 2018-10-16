//
//  QuestionsViewController.swift
//  Personality Quiz
//
//  Created by cl-dev on 2018-09-11.
//  Copyright © 2018 cl-dev. All rights reserved.
//

import UIKit

class QuestionsViewController: UIViewController {
    
    var viewModel = QuestionsViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI(viewModel: viewModel) //Pass in view model/ puts view model into view
        
        // Do any additional setup after loading the view.
    }
    
    @IBOutlet weak var progressBar: UIProgressView!
    @IBOutlet weak var questionLabel: UILabel!
    
    @IBOutlet weak var multipleAnswersStackView: UIStackView!
    
    @IBOutlet weak var multipleLabel1: UILabel!
    @IBOutlet weak var multipleLabel2: UILabel!
    @IBOutlet weak var multipleLabel3: UILabel!
    @IBOutlet weak var multipleLabel4: UILabel!
    
    @IBOutlet weak var multipleSwitch1: UISwitch!
    @IBOutlet weak var multipleSwitch2: UISwitch!
    @IBOutlet weak var multipleSwitch3: UISwitch!
    @IBOutlet weak var multipleSwitch4: UISwitch!
    
    
    // View model : User derived/model
    // Model : Backend/file-system
    
    private var answersChosen: [Answer] = []
    
    //var viewModel = QuestionsViewModel()
    
    func updateUI(viewModel: QuestionsViewModel){
        
        let state = viewModel.currentStateForUI()
        
        navigationItem.title = state.navigationTitle
        
        
        questionLabel.text = state.currentQuestion.text
        progressBar.setProgress(state.progressThroughQuestions, animated: true)
        
        multipleAnswers(using: state.currentQuestion.answers)
        
    }
    
    func multipleAnswers (using answers: [Answer])
    {
        multipleLabel1.text = answers[0].text
        multipleLabel2.text = answers[1].text
        multipleLabel3.text = answers[2].text
        multipleLabel4.text = answers[3].text
        
        multipleSwitch1.isOn = false
        multipleSwitch2.isOn = false
        multipleSwitch3.isOn = false
        multipleSwitch4.isOn = false
    }
    
    func nextQuestion (viewModel: QuestionsViewModel)
    {
        viewModel.questionIndex += 1
        
        if viewModel.questionIndex < viewModel.question.count {
            updateUI(viewModel: viewModel)
        } else {
            performSegue(withIdentifier: "ResultsSegue", sender: nil)
        }
    }
    @IBAction func multipleAnswersButtonPressed(_ sender: Any) { //call QVM from here too/ reading from view model
        let currentAnswers = state.currentQuestion.answers
        
        if multipleSwitch1.isOn {
            answersChosen.append(currentAnswers[0])
        }
        if multipleSwitch2.isOn {
            answersChosen.append(currentAnswers[1])
        }
        if multipleSwitch3.isOn {
            answersChosen.append(currentAnswers[2])
        }
        if multipleSwitch4.isOn {
            answersChosen.append(currentAnswers[3])
        }
        
        nextQuestion(viewModel: viewModel)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?){
        if segue.identifier == "ResultsSegue" {
            
            //Fail fast only in debug for developer
            assert(segue.destination is ResultsViewController)
            if let resultsViewController = segue.destination as? ResultsViewController {
                resultsViewController.responses = answersChosen
            }
        } // Could we had just done an extension instead of overriding an empty function
        
        //Hard coded relationship (axioms) = internally crash on
        //assert only crash in development
        // Precondition will crash in all build (debug, release)
        // Fail fast: assert, precondition or force unwrapping
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
