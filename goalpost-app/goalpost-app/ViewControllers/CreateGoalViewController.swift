//
//  CreateGoalVC.swift
//  goalpost-app
//
//  Created by Massimiliano on 20/04/2019.
//  Copyright © 2019 Massimiliano Bonafede. All rights reserved.
//

import UIKit
import CoreData

class CreateGoalViewController: UIViewController {

    //MARK: - Outlets

    @IBOutlet weak var goalTextView: UITextView!
    @IBOutlet weak var shortTermBtn: UIButton!
    @IBOutlet weak var longTermBtn: UIButton!
    @IBOutlet weak var nextBtn: UIButton!
    
    //MARK: - Properties

    var goalType: GoalType = .shortTerm
    var viewModel = CreateGoalViewModel()
    
    //MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        goalTextView.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        nextBtn.bindToKeyboard()
        shortTermBtn.setSelectedColor()
        longTermBtn.setDeselectedColor()
    }
    
    
    //MARK: - Actions

    @IBAction func backButtonWasPressed(_ sender: Any) {
        navigationController?.popViewController(animated: true)
        //dismissDetail()
    }
    
    
    @IBAction func nextButtonWasPressed(_ sender: Any) {
        if goalTextView.text != "" && goalTextView.text != "What is your goal ?" {
//            guard let finishGoalVC = storyboard?.instantiateViewController(withIdentifier: "FinishGoalViewController") as? FinishGoalViewController else {return}
            
            Manager.shared.goalData = GoalData(
                description: goalTextView.text!,
                goalType: goalType
            )
            
            navigationController?.pushViewController(viewModel.nextButtonWasPressed(), animated: true)
            
//            finishGoalVC.initData(description: goalTextView.text!, type: goalType)
//            presentingViewController?.presentSecondaryDetail(finishGoalVC)
        }
    }
    
    @IBAction func shortTermButtonWasPressed(_ sender: Any) {
        goalType = .shortTerm
        shortTermBtn.setSelectedColor()
        longTermBtn.setDeselectedColor()
    }
    
    
    @IBAction func longTermButtonWasPressed(_ sender: Any) {
        goalType = .longTerm
        longTermBtn.setSelectedColor()
        shortTermBtn.setDeselectedColor()
    }
}

//MARK: - UITextViewDelegate

extension CreateGoalViewController: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        goalTextView.text = ""
        goalTextView.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
    }
}
