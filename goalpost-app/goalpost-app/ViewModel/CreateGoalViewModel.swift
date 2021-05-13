//
//  CreateGoalViewModel.swift
//  goalpost-app
//
//  Created by Bonafede Massimiliano on 13/05/21.
//  Copyright © 2021 Massimiliano Bonafede. All rights reserved.
//

import UIKit

class CreateGoalViewModel {
    
    func nextButtonWasPressed() -> UIViewController {
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        let controller = storyboard.instantiateViewController(withIdentifier: "FinishGoalViewController")
        return controller
    }
}
