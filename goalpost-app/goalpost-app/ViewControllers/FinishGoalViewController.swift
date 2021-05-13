//
//  FinishGoalVC.swift
//  goalpost-app
//
//  Created by Massimiliano on 21/04/2019.
//  Copyright © 2019 Massimiliano Bonafede. All rights reserved.
//

import UIKit
import CoreData

class FinishGoalViewController: UIViewController, UITextFieldDelegate {
    
    //MARK: - Outlets
    
    @IBOutlet weak var createGoalBtn: UIButton!
    @IBOutlet weak var pointTxtField: UITextField!
    
    //MARK: - Properties
    
    var goalDescription: String!
    var goalType: GoalType!
    var viewModel = FinishGoalViewModel()
    
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        pointTxtField.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        createGoalBtn.bindToKeyboard()
        goalDescription = Manager.shared.goalData?.description
        goalType = Manager.shared.goalData?.goalType
        print("Description: \(goalDescription)")
        print("Goal type: \(goalType)")
    }
    
    //MARK: - Methods
    
//    func initData(description: String, type: GoalType) {
//        self.goalDescription = description
//        self.goalType = type
//    }
    
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
                viewModel.createGoalWasPressed(navigationController)
                //dismiss(animated: true, completion: nil)
            }
        }
    }
    
    @IBAction func backBtnWasPressed(_ sender: Any) {
        navigationController?.popViewController(animated: true)
        //dismissDetail()
    }
}
