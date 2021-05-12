//
//  GoalCell.swift
//  goalpost-app
//
//  Created by Massimiliano on 19/04/2019.
//  Copyright © 2019 Massimiliano Bonafede. All rights reserved.
//

import UIKit

class GoalCell: UITableViewCell {

    //MARK: - Outlets

    @IBOutlet weak var goalDescriptionLbl: UILabel!
    @IBOutlet weak var goalTypeLbl: UILabel!
    @IBOutlet weak var goalProgressLbl: UILabel!
    @IBOutlet weak var completionView: UIView!
    
    //MARK: - Methods

    func congigureCellWith(_ goal: Goal) {
        goalDescriptionLbl.text = goal.goalDescription
        goalTypeLbl.text = goal.goalType
        goalProgressLbl.text = String(describing: goal.goalProgress)
        
        let isCompleted = goal.goalProgress == goal.goalCompletionValue
        completionView.isHidden = !isCompleted
    }
}
