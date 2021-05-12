//
//  CreateGoalVC.swift
//  goalpost-app
//
//  Created by Massimiliano on 20/04/2019.
//  Copyright © 2019 Massimiliano Bonafede. All rights reserved.
//

import UIKit
import CoreData

class CreateGoalVC: UIViewController {

    //MARK: - Outlets

    @IBOutlet weak var goalTextView: UITextView!
    @IBOutlet weak var shortTermBtn: UIButton!
    @IBOutlet weak var longTermBtn: UIButton!
    @IBOutlet weak var nextBtn: UIButton!
    
    //MARK: - Properties

    var goalType: GoalType = .shortTerm
    
    //MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        nextBtn.bindToKeyboard()
        shortTermBtn.setSelectedColor()
        longTermBtn.setDeselectedColor()
        goalTextView.delegate = self
    }
    
    //MARK: - Actions

    @IBAction func backButtonWasPressed(_ sender: Any) {
        navigationController?.popViewController(animated: true)
        //dismissDetail()
    }
    
    
    @IBAction func nextButtonWasPressed(_ sender: Any) {
        if goalTextView.text != "" && goalTextView.text != "What is your goal ?" {
            guard let finishGoalVC = storyboard?.instantiateViewController(withIdentifier: "FinishGoalVC") as? FinishGoalVC else {return}
            finishGoalVC.initData(description: goalTextView.text!, type: goalType)
            presentingViewController?.presentSecondaryDetail(finishGoalVC)
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

extension CreateGoalVC: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        goalTextView.text = ""
        goalTextView.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
    }
}
