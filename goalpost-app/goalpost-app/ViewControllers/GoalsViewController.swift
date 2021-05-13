//
//  ViewController.swift
//  goalpost-app
//
//  Created by Massimiliano on 18/04/2019.
//  Copyright © 2019 Massimiliano Bonafede. All rights reserved.
//

import UIKit
import CoreData

let appDelegate = UIApplication.shared.delegate as? AppDelegate

class GoalsViewController: UIViewController {
    
    //MARK: - Outlets
    
    @IBOutlet weak var tableView: UITableView!
    
    //MARK: - Properties
    
    var viewModel = GoalsViewModel()
    
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("OK")
        tableView.delegate = self
        tableView.dataSource = self
        tableView.isHidden = false
        tableView.tableFooterView = UIView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        fetchCoreDataObject()
    }
    
    //MARK: - Methods

    private func fetchCoreDataObject() {
        viewModel.fetchGoals { isCompleted in
            switch isCompleted {
            case true:
                
                self.tableView.isHidden = self.viewModel.goals.count >= 1 ? false : true
                self.tableView.reloadData()
                
            case false:
                print("Not completed fetch")
                break
            }
        }
    }
    
    //MARK: - Actions

    @IBAction func addGoalButtonWasPressed(_ sender: UIButton) {
        navigationController?.pushViewController(viewModel.addGoalWasPressed(), animated: true)
    }
    
}

//MARK: - UITableViewDelegate, UITableViewDataSource

extension GoalsViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.goals.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "goalCell") as? GoalCell else {
            return UITableViewCell()
        }
        
        let goal = viewModel.goals[indexPath.row]
        cell.congigureCellWith(goal)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .none
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        
        let deleteAction = UITableViewRowAction(style: .destructive, title: "DELETE") { rowAction, indexPath in
            
            self.viewModel.removeGoal(atIndexPath: indexPath)
            self.fetchCoreDataObject()
            
            //tableView.deleteRows(at: [indexPath], with: .automatic)
        }
        
        let addAction = UITableViewRowAction(style: .normal, title: "ADD 1") { rowAction, indexPath in
            self.viewModel.setProgress(atIndexPath: indexPath)
            tableView.reloadRows(at: [indexPath], with: .automatic)
        }
        
        deleteAction.backgroundColor = #colorLiteral(red: 0.7450980544, green: 0.1568627506, blue: 0.07450980693, alpha: 1)
        addAction.backgroundColor = #colorLiteral(red: 1, green: 0.8323456645, blue: 0.4732058644, alpha: 1)
        
        return [deleteAction, addAction]
    }
}


