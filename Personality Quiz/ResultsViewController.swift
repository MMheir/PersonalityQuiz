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
    
    let viewModel = ResultsViewModel() // Add internal to signal you haven't forgotten about access modifiers
    
    override func viewDidLoad() {
        super.viewDidLoad()
        resultAnswerLabel.text = viewModel.getAnswerText()
        navigationItem.hidesBackButton = true
        // Do any additional setup after loading the view.
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
