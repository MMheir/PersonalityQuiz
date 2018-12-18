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
    var allAnswerViews: [AnswerSwitchView] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI() //Pass in view model/ puts view model into view
        // Do any additional setup after loading the view.
    }
    
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var currentAnimalType: UILabel!
    
    @IBOutlet weak var rabbitEmojiLabel: UILabel!
    @IBOutlet weak var mouseEmojiLabel: UILabel!
    @IBOutlet weak var catEmojiLabel: UILabel!
    @IBOutlet weak var dogEmojiLabel: UILabel!

    @IBOutlet weak var progressBar: UIProgressView!
    
    @IBOutlet weak var multipleAnswersStackView: UIStackView!
    
    // View model : User derived/model
    // Model : Backend/file-system
    
    internal func switchToggled() {
        submitAnswersFromUI()
        
        let state = viewModel.currentStateForUI()
        
        setAnimalTypeEmojis(animalTransparencies: state.responseAnimalsTransparencyAlphas)
    }
    
    func updateUI(){
        
        let state = viewModel.currentStateForUI()
        
        setAnimalTypeEmojis(animalTransparencies: state.responseAnimalsTransparencyAlphas)
        
        navigationItem.title = state.navigationTitle
        
        questionLabel.text = state.currentQuestion.text

        progressBar.setProgress(state.progressThroughQuestions, animated: true)
        
        currentAnimalType.text = state.yourAnimalType
        
        updateAnswersUI(using: state.currentQuestion.answers)
        
    }
    
    func setAnimalTypeEmojis(animalTransparencies: [AnimalType : CGFloat]) {
        rabbitEmojiLabel.text = "\(AnimalType.rabbit.rawValue)"
        mouseEmojiLabel.text = "\(AnimalType.mouse.rawValue)"
        catEmojiLabel.text = "\(AnimalType.cat.rawValue)"
        dogEmojiLabel.text = "\(AnimalType.dog.rawValue)"
        
        let unselectedAlpha = QuestionsViewModel.unselectedAnimalTransparencyAlpha
        
        rabbitEmojiLabel.alpha = animalTransparencies[.rabbit] ?? unselectedAlpha
        mouseEmojiLabel.alpha = animalTransparencies[.mouse] ?? unselectedAlpha
        catEmojiLabel.alpha = animalTransparencies[.cat] ?? unselectedAlpha
        dogEmojiLabel.alpha = animalTransparencies[.dog] ?? unselectedAlpha
    }

    func updateAnswersUI(using answers: [Answer]) {
        allAnswerViews.forEach{ $0.removeFromSuperview() }
        allAnswerViews = []
        answers.forEach { answer in
            let views = Bundle.main.loadNibNamed("AnswerSwitchView", owner: nil, options: nil)
            if let answerView = views?.first as? AnswerSwitchView {
                answerView.updateAnswerUI(text: answer.text) { [weak self] in
                    self?.switchToggled()
                }
                allAnswerViews.append(answerView)
                self.multipleAnswersStackView.addArrangedSubview(answerView) // Change to open func insertArrangedSubview(_ view: UIView, at stackIndex: Int)
            }
        }
    }
    
    func nextQuestion (){
        
        viewModel.incrementQuestionIndex()
        
        if viewModel.nextStateIsQuestion() { //TODO: Use 2 cases enum, switch over that enum
            updateUI()
        } else {
            performSegue(withIdentifier: "ResultsSegue", sender: nil)
        }
    }

    @IBAction func answersSubmitButtonPressed(_ sender: Any) { //call QVM from here too/ reading from view model
        
        submitAnswersFromUI()
        
        nextQuestion()
    }
    
    private func submitAnswersFromUI(){
        let answersSelected = allAnswerViews.map { $0.isSwitchOn() }
        viewModel.submitAnswersToCurrentQuestion(answersSelected: answersSelected)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?){
        if segue.identifier == "ResultsSegue" {
            
            //Fail fast only in debug for developer
            assert(segue.destination is ResultsViewController)
            if let resultsViewController = segue.destination as? ResultsViewController {
                resultsViewController.viewModel.update(from: viewModel)
            }
        } // Could we had just done an extension instead of overriding an empty function
        
        //Hard coded relationship (axioms) = internally crash on
        //assert only crash in development
        // Precondition will crash in all build (debug, release)
        // Fail fast: assert, precondition or force unwrapping
    }
    
}
