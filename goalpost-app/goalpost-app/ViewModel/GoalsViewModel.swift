//
//  GoalsViewModel.swift
//  goalpost-app
//
//  Created by Bonafede Massimiliano on 13/05/21.
//  Copyright © 2021 Massimiliano Bonafede. All rights reserved.
//

import UIKit
import CoreData

class GoalsViewModel {
    
    var goals: [Goal] = []
    
    func addGoalWasPressed() -> UIViewController {
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        let controller = storyboard.instantiateViewController(withIdentifier: "CreateGoalViewController")
        return controller
    }
    
    
    func fetchGoals(completion: @escaping (Bool) -> ()) {
        guard let managedContex = appDelegate?.persistentContainer.viewContext else { return }
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Goal")
        
        do {
            goals = try managedContex.fetch(fetchRequest) as! [Goal]
            print("Successfully Fetched data.")
            completion(true)
        } catch {
            debugPrint("Could not fetch: \(error.localizedDescription)")
            completion(false)
        }
    }
    
    func removeGoal(atIndexPath indexPath: IndexPath) {
        guard let manageContext = appDelegate?.persistentContainer.viewContext else { return }
        
        manageContext.delete(goals[indexPath.row])
        
        do {
            try manageContext.save()
            print("Successfully removed goal!")
        } catch{
            debugPrint("Could not remove:\(error.localizedDescription)")
        }
    }
    
    
    func setProgress(atIndexPath indexPath: IndexPath) {
        guard let managedContex = appDelegate?.persistentContainer.viewContext else { return }
        
        let chosenGoal = goals[indexPath.row]
        
        guard chosenGoal.goalProgress < chosenGoal.goalCompletionValue else { return }
        
        chosenGoal.goalProgress = chosenGoal.goalProgress + 1
        
        do {
            try managedContex.save()
            print("Successfully set progress!")
        } catch {
            debugPrint("Could not set progress: \(error.localizedDescription)")
        }
    }
    
    
}
