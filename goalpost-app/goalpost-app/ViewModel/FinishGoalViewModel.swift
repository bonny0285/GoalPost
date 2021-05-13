//
//  FinishGoalViewModel.swift
//  goalpost-app
//
//  Created by Bonafede Massimiliano on 13/05/21.
//  Copyright © 2021 Massimiliano Bonafede. All rights reserved.
//

import UIKit

class FinishGoalViewModel {
    
    func createGoalWasPressed(_ sender: UINavigationController?) {
        sender?.popToRootViewController(animated: true)
    }
}
