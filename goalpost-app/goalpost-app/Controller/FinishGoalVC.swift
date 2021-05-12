//
//  FinishGoalVC.swift
//  goalpost-app
//
//  Created by Massimiliano on 21/04/2019.
//  Copyright © 2019 Massimiliano Bonafede. All rights reserved.
//

import UIKit
import CoreData

class FinishGoalVC: UIViewController, UITextFieldDelegate {
    
    //MARK: - Outlets
    
    @IBOutlet weak var createGoalBtn: UIButton!
    @IBOutlet weak var pointTxtField: UITextField!
    
    //MARK: - Properties
    
    var goalDescription: String!
    var goalType: GoalType!
    
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        createGoalBtn.bindToKeyboard()
        pointTxtField.delegate = self
    }
    
    //MARK: - Methods
    
    func initData(description: String, type: GoalType) {
        self.goalDescription = description
        self.goalType = type
    }
    
    private func save(completion: (_ finished: Bool) -> ()) {
        guard let managedContext = appDelegate?.persistentContainer.viewContext else { return }
        
        let goal = Goal(context: managedContext)
        
        goal.goalDescription = goalDescription
        goal.goalType = goalType.rawValue
        goal.goalCompletionValue = Int32(pointTxtField.text!)!
        goal.goalProgress = Int32(0)
        
        do {
            try managedContext.save()
            print("Successed fully saved data!")
            completion(true)
            
        } catch {
            debugPrint("Could not save: \(error.localizedDescription)")
            completion(false)
        }
    }
    
    
    //MARK: - Actions
    
    @IBAction func createGoalBtnWasPressed(_ sender: Any) {
        // Pass data into Core Data Goal Model
        
        guard pointTxtField.text != nil else { return }
        
        save { isComplete in
            if isComplete {
                dismiss(animated: true, completion: nil)
            }
        }
    }
    
    @IBAction func backBtnWasPressed(_ sender: Any) {
        navigationController?.popViewController(animated: true)
        //dismissDetail()
    }
}
